import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/servers/data/models/power_action.dart';
import 'package:cloudsbin/features/servers/data/models/power_response.dart';
import 'package:cloudsbin/features/servers/data/models/server_detail.dart';
import 'package:cloudsbin/features/servers/data/server_repository.dart';
import 'package:cloudsbin/features/servers/presentation/server_detail_screen.dart';
import 'package:cloudsbin/shared/enums/app_enums.dart';

/// ServerRepository with the two calls this screen needs stubbed out.
class _FakeServerRepository extends ServerRepository {
  _FakeServerRepository()
      : super(ApiClient(
          storage: SecureStorage(const FlutterSecureStorage()),
          appVersion: '1.0.0',
        ));

  ServerDetail? fixture;
  Completer<PowerResponse>? gate;
  int powerCalls = 0;

  @override
  Future<ServerDetail> detail(int serverId) async => fixture!;

  @override
  Future<PowerResponse> powerAction({
    required int serverId,
    required PowerAction action,
  }) {
    powerCalls++;
    final pending = gate;
    if (pending != null) return pending.future;
    return Future<PowerResponse>.value(PowerResponse(
      action: action.name,
      status: switch (action) {
        PowerAction.stop => 'stopping',
        PowerAction.start => 'booting',
        PowerAction.reboot => 'rebooting',
      },
      serverId: serverId,
    ));
  }
}

ServerDetail _fixture(ServerStatus status) => ServerDetail(
      id: 7,
      name: 'demo-1',
      status: status,
      ipAddress: '203.0.113.10',
      accessPort: 22,
      planName: 'nano',
      region: 'us-east',
      os: 'ubuntu-24.04',
      vcpu: 2,
      ramGb: 1.0,
      ssdGb: 25,
      progress: 100,
    );

Future<_FakeServerRepository> _pumpDetail(
  WidgetTester tester,
  ServerStatus status,
) async {
  final repo = _FakeServerRepository()..fixture = _fixture(status);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [serverRepositoryProvider.overrideWithValue(repo)],
      child: const MaterialApp(home: ServerDetailScreen(serverId: 7)),
    ),
  );
  await tester.pumpAndSettle();
  return repo;
}

void main() {
  group('ServerDetailScreen power actions', () {
    testWidgets('active server → Stop and Reboot enabled, Start disabled',
        (tester) async {
      await _pumpDetail(tester, ServerStatus.active);

      final stop = tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Stop'));
      final start = tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Start'));
      final reboot = tester
          .widget<OutlinedButton>(find.widgetWithText(OutlinedButton, 'Reboot'));

      expect(stop.onPressed, isNotNull);
      expect(start.onPressed, isNull);
      expect(reboot.onPressed, isNotNull);
    });

    testWidgets('stopped server → Start enabled, Stop and Reboot disabled',
        (tester) async {
      await _pumpDetail(tester, ServerStatus.stopped);

      final stop = tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Stop'));
      final start = tester
          .widget<FilledButton>(find.widgetWithText(FilledButton, 'Start'));
      final reboot = tester
          .widget<OutlinedButton>(find.widgetWithText(OutlinedButton, 'Reboot'));

      expect(stop.onPressed, isNull);
      expect(start.onPressed, isNotNull);
      expect(reboot.onPressed, isNull);
    });

    testWidgets('destroyed server → Power section not rendered',
        (tester) async {
      await _pumpDetail(tester, ServerStatus.destroyed);

      expect(find.text('POWER'), findsNothing);
      expect(find.byIcon(Icons.power_settings_new), findsNothing);
      expect(find.text('Stop'), findsNothing);
    });

    testWidgets('tapping Stop opens the confirmation dialog', (tester) async {
      await _pumpDetail(tester, ServerStatus.active);

      final stop = find.widgetWithText(FilledButton, 'Stop');
      await tester.ensureVisible(stop);
      await tester.pumpAndSettle();
      await tester.tap(stop);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Stop server?'), findsOneWidget);
      expect(find.text('It will become unreachable until started again.'),
          findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Stop Server'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('confirming Stop → loading state in the tapped button',
        (tester) async {
      final repo = await _pumpDetail(tester, ServerStatus.active);
      repo.gate = Completer<PowerResponse>();

      final stop = find.widgetWithText(FilledButton, 'Stop');
      await tester.ensureVisible(stop);
      await tester.pumpAndSettle();
      await tester.tap(stop);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Stop Server'));
      await tester.pump();

      // Spinner lives only in the tapped button; the others stay disabled.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(repo.powerCalls, 1);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Start'))
            .onPressed,
        isNull,
      );
      expect(
        tester
            .widget<OutlinedButton>(find.widgetWithText(OutlinedButton, 'Reboot'))
            .onPressed,
        isNull,
      );

      // Complete the call → optimistic status shows in the power card…
      repo.gate!.complete(PowerResponse(
        action: 'stop',
        status: 'stopping',
        serverId: 7,
      ));
      await tester.pump();
      expect(find.text('Stopping...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // …then the single scheduled refresh (3s) lands and clears it.
      await tester.pump(const Duration(seconds: 3));
      await tester.pump();
      await tester.pump();
      expect(find.text('Stopping...'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Stop'))
            .onPressed,
        isNotNull,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
