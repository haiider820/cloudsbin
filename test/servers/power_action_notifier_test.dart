import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/servers/data/models/power_action.dart';
import 'package:cloudsbin/features/servers/presentation/power_action_notifier.dart';
import 'package:cloudsbin/shared/enums/app_enums.dart';

class _Scripted {
  const _Scripted(this.status, this.body, {this.headers = const {}});

  final int status;
  final Map<String, dynamic> body;
  final Map<String, List<String>> headers;
}

class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(List<_Scripted> script) : _script = Queue.of(script);

  final Queue<_Scripted> _script;
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    final next = _script.removeFirst();
    return ResponseBody.fromString(
      jsonEncode(next.body),
      next.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        ...next.headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// In-memory secure storage — never touches the platform channel.
class _MemoryStorage extends SecureStorage {
  _MemoryStorage() : super(const FlutterSecureStorage());

  @override
  Future<String?> readAccessToken(TokenKeys keys) async => null;

  @override
  Future<String?> readRefreshToken(TokenKeys keys) async => null;
}

/// A container wired to a scripted Dio adapter through the real
/// [ServerRepository] + [ApiError] pipeline, so the power call is exercised
/// exactly as production runs it (headers, Retry-After, error codes).
ProviderContainer _container(List<_Scripted> script) {
  final client = ApiClient(storage: _MemoryStorage(), appVersion: '1.0.0');
  client.dio.httpClientAdapter = _ScriptedAdapter(<_Scripted>[
    ...script,
    // Tail response so the scheduled detail refresh never starves the queue.
    const _Scripted(200, {'id': 7, 'status': 'active'}),
  ]);
  final container = ProviderContainer(overrides: [
    apiClientProvider.overrideWithValue(client),
    // Resolve the one-shot refresh immediately: it runs as a timer event
    // after the assertions below (microtasks first), and is guarded against
    // a disposed container either way.
    powerRefreshDelayProvider.overrideWith((_) => Duration.zero),
  ]);
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('PowerActionNotifier', () {
    test('stop on active server → success, status becomes stopping', () async {
      final c = _container([
        const _Scripted(200, {
          'action': 'stop',
          'status': 'stopping',
          'server_id': 7,
        }),
      ]);

      final state = await c
          .read(powerActionProvider(7).notifier)
          .perform(PowerAction.stop);

      expect(state.phase, PowerActionPhase.success);
      expect(state.response?.action, 'stop');
      expect(state.response?.status, 'stopping');
      expect(state.response?.serverId, 7);
      expect(c.read(serverStatusOverrideProvider(7)), ServerStatus.stopping);
    });

    test('start on stopped server → success, status becomes booting', () async {
      final c = _container([
        const _Scripted(200, {
          'action': 'start',
          'status': 'booting',
          'server_id': 7,
        }),
      ]);

      final state = await c
          .read(powerActionProvider(7).notifier)
          .perform(PowerAction.start);

      expect(state.phase, PowerActionPhase.success);
      expect(state.response?.status, 'booting');
      expect(c.read(serverStatusOverrideProvider(7)), ServerStatus.booting);
    });

    test('reboot on active server → success, status becomes rebooting',
        () async {
      final c = _container([
        const _Scripted(200, {
          'action': 'reboot',
          'status': 'rebooting',
          'server_id': 7,
        }),
      ]);

      final state = await c
          .read(powerActionProvider(7).notifier)
          .perform(PowerAction.reboot);

      expect(state.phase, PowerActionPhase.success);
      expect(state.response?.status, 'rebooting');
      expect(c.read(serverStatusOverrideProvider(7)), ServerStatus.rebooting);
    });

    test('409 SERVER_NOT_ACTIVE → error state, status unchanged', () async {
      final c = _container([
        const _Scripted(409, {
          'error': 'Stop needs an active server.',
          'code': 'SERVER_NOT_ACTIVE',
          'request_id': 'req-409',
        }),
      ]);
      // A prior optimistic value must survive the failed call.
      c.read(serverStatusOverrideProvider(7).notifier).state =
          ServerStatus.provisioning;

      final state = await c
          .read(powerActionProvider(7).notifier)
          .perform(PowerAction.stop);

      expect(state.phase, PowerActionPhase.error);
      expect(state.error?.code, 'SERVER_NOT_ACTIVE');
      expect(state.error?.statusCode, 409);
      expect(c.read(serverStatusOverrideProvider(7)),
          ServerStatus.provisioning);
    });

    test('429 → error state with retryAfter populated', () async {
      final c = _container([
        _Scripted(
          429,
          const {
            'error': 'Too many power actions.',
            'code': 'RATE_LIMITED',
            'request_id': 'req-429',
          },
          headers: const {'retry-after': ['30']},
        ),
      ]);

      final state = await c
          .read(powerActionProvider(7).notifier)
          .perform(PowerAction.reboot);

      expect(state.phase, PowerActionPhase.error);
      expect(state.error?.code, 'RATE_LIMITED');
      expect(state.error?.retryAfterSeconds, 30);
      expect(c.read(serverStatusOverrideProvider(7)), isNull);
    });
  });
}
