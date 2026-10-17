import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/data/auth_repository.dart';
import 'package:cloudsbin/features/servers/data/models/server_actions.dart';
import 'package:cloudsbin/features/servers/data/server_repository.dart';
import 'package:cloudsbin/features/servers/presentation/destroy_screen.dart';
import 'package:cloudsbin/shared/widgets/app_state_widgets.dart';

/// Re-auth always succeeds so the flow reaches the destroy call itself.
class _FakeAuthRepository extends AuthRepository {
  _FakeAuthRepository()
      : super(
          ApiClient(
            storage: SecureStorage(const FlutterSecureStorage()),
            appVersion: '1.0.0',
          ),
          SecureStorage(const FlutterSecureStorage()),
        );

  @override
  Future<String> reauth(String password) async => 'grant-abc-123';
}

/// `destroy` parks on [gate] then throws a *non-ApiError* failure, emulating a
/// raw client-side crash that the old code let escape (spinner hung forever).
class _FakeServerRepository extends ServerRepository {
  _FakeServerRepository(this.gate)
      : super(ApiClient(
          storage: SecureStorage(const FlutterSecureStorage()),
          appVersion: '1.0.0',
        ));

  final Completer<void> gate;

  @override
  Future<DestroyResult> destroy({
    required int serverId,
    required String reauthToken,
  }) async {
    await gate.future;
    throw StateError('unexpected client failure');
  }
}

void main() {
  testWidgets(
      'destroy: non-ApiError failure clears the spinner and shows an error view',
      (tester) async {
    final gate = Completer<void>();
    tester.view.physicalSize = const Size(420, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
          serverRepositoryProvider
              .overrideWithValue(_FakeServerRepository(gate)),
        ],
        child: const MaterialApp(home: DestroyScreen(serverId: 7)),
      ),
    );
    await tester.pumpAndSettle();

    // Re-auth sheet → enter password → Confirm.
    expect(find.text('Confirm your password'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'hunter2!');
    await tester.tap(find.text('Confirm'));
    await tester.pumpAndSettle();

    // Confirmation dialog → Destroy.
    expect(find.text('Destroy this server?'), findsWidgets);
    await tester.tap(find.text('Destroy'));
    await tester.pump();

    // Request in flight while the gate is open.
    expect(find.byType(AppLoadingView), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();

    // The failure surfaced as an error view; nothing is stuck loading.
    expect(find.byType(AppLoadingView), findsNothing);
    expect(find.byType(AppErrorView), findsOneWidget);
    expect(
      find.text('Something went wrong. Please try again.'),
      findsOneWidget,
    );
  });
}
