import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/interceptors/auth_interceptor.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';

class _Scripted {
  const _Scripted(this.status, this.body);

  final int status;
  final Map<String, dynamic> body;
}

class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(List<_Scripted> script)
      : _script = Queue.of(script);

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
      headers: {Headers.contentTypeHeader: [Headers.jsonContentType]},
    );
  }

  @override
  void close({bool force = false}) {}
}

/// In-memory secure storage — never touches the platform channel.
class _MemoryStorage extends SecureStorage {
  _MemoryStorage() : super(const FlutterSecureStorage());

  final Map<String, String> _values = {
    'access_token': 'old-access',
    'refresh_token': 'old-refresh',
  };

  @override
  Future<String?> readAccessToken(TokenKeys keys) async => _values[keys.access];

  @override
  Future<String?> readRefreshToken(TokenKeys keys) async =>
      _values[keys.refresh];

  @override
  Future<void> writeTokens(
    TokenKeys keys, {
    required String accessToken,
    required String refreshToken,
  }) async {
    _values[keys.access] = accessToken;
    _values[keys.refresh] = refreshToken;
  }

  @override
  Future<void> clearTokens(TokenKeys keys) async {
    _values.remove(keys.access);
    _values.remove(keys.refresh);
  }
}

class _Harness {
  _Harness({
    required List<_Scripted> clientScript,
    required List<_Scripted> refreshScript,
  })  : storage = _MemoryStorage(),
        client = Dio(),
        refreshClient = Dio() {
    client.httpClientAdapter = _ScriptedAdapter(clientScript);
    refreshClient.httpClientAdapter = _ScriptedAdapter(refreshScript);
    interceptor = AuthInterceptor(
      storage: storage,
      tokenKeys: TokenKeys.user,
      client: client,
      refreshClient: refreshClient,
      onSessionExpired: () => expiredCalls++,
    );
    client.interceptors.add(interceptor);
  }

  final _MemoryStorage storage;
  final Dio client;
  final Dio refreshClient;
  late final AuthInterceptor interceptor;
  int expiredCalls = 0;

  Future<Response<dynamic>> get(String path) => client.get(path);
}

const _refreshOk = _Scripted(200, {
  'access_token': 'new-access',
  'refresh_token': 'new-refresh',
  'retried': false,
});

void main() {
  group('AuthInterceptor', () {
    test('TOKEN_EXPIRED refreshes once and retries', () async {
      final h = _Harness(
        clientScript: [
          const _Scripted(401, {'code': 'TOKEN_EXPIRED', 'message': 'expired'}),
          const _Scripted(200, {'ok': true}),
        ],
        refreshScript: [_refreshOk],
      );

      final response = await h.get('/servers/list');

      expect(response.statusCode, 200);
      expect(response.data['ok'], isTrue);
      expect(await h.storage.readAccessToken(TokenKeys.user), 'new-access');
      expect(await h.storage.readRefreshToken(TokenKeys.user), 'new-refresh');
      expect(h.expiredCalls, 0);
      expect((h.refreshClient.httpClientAdapter as _ScriptedAdapter).calls, 1);
    });

    test('SESSION_REVOKED clears tokens and bounces without refresh',
        () async {
      final h = _Harness(
        clientScript: [
          const _Scripted(401, {'code': 'SESSION_REVOKED', 'message': 'gone'}),
        ],
        refreshScript: const [],
      );

      await expectLater(h.get('/servers/list'), throwsA(isA<DioException>()));

      expect(await h.storage.readAccessToken(TokenKeys.user), isNull);
      expect(await h.storage.readRefreshToken(TokenKeys.user), isNull);
      expect(h.expiredCalls, 1);
      expect((h.refreshClient.httpClientAdapter as _ScriptedAdapter).calls, 0);
    });

    test('second 401 after refresh does not loop', () async {
      final h = _Harness(
        clientScript: [
          const _Scripted(401, {'code': 'TOKEN_EXPIRED', 'message': 'expired'}),
          const _Scripted(401, {'code': 'TOKEN_EXPIRED', 'message': 'again'}),
        ],
        refreshScript: [_refreshOk],
      );

      await expectLater(h.get('/servers/list'), throwsA(isA<DioException>()));

      expect(h.expiredCalls, 1);
      expect((h.refreshClient.httpClientAdapter as _ScriptedAdapter).calls, 1);
      expect((h.client.httpClientAdapter as _ScriptedAdapter).calls, 2);
    });

    test('failed refresh clears tokens and bounces', () async {
      final h = _Harness(
        clientScript: [
          const _Scripted(401, {'code': 'TOKEN_EXPIRED', 'message': 'expired'}),
        ],
        refreshScript: [
          const _Scripted(401, {'code': 'SESSION_REVOKED', 'message': 'gone'}),
        ],
      );

      await expectLater(h.get('/servers/list'), throwsA(isA<DioException>()));

      expect(await h.storage.readAccessToken(TokenKeys.user), isNull);
      expect(h.expiredCalls, 1);
    });

    test('non-401 errors pass through untouched', () async {
      final h = _Harness(
        clientScript: [
          const _Scripted(500, {'code': 'SERVER_ERROR', 'message': 'boom'}),
        ],
        refreshScript: const [],
      );

      await expectLater(h.get('/servers/list'), throwsA(isA<DioException>()));

      expect(await h.storage.readAccessToken(TokenKeys.user), 'old-access');
      expect(h.expiredCalls, 0);
      expect((h.refreshClient.httpClientAdapter as _ScriptedAdapter).calls, 0);
    });
  });
}
