import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/data/auth_repository.dart';
import 'package:cloudsbin/features/servers/data/models/credential_reveal.dart';
import 'package:cloudsbin/features/servers/data/models/server_detail.dart';
import 'package:cloudsbin/features/servers/data/server_repository.dart';
import 'package:cloudsbin/features/servers/presentation/credentials_screen.dart';
import 'package:cloudsbin/shared/enums/app_enums.dart';

/// Reauth always succeeds so the reveal flow proceeds without a real backend.
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

/// ServerRepository with `detail` + `credentialsReveal` stubbed out.
class _FakeServerRepository extends ServerRepository {
  _FakeServerRepository(this._reveal)
      : super(ApiClient(
          storage: SecureStorage(const FlutterSecureStorage()),
          appVersion: '1.0.0',
        ));

  final CredentialReveal _reveal;

  @override
  Future<ServerDetail> detail(int serverId) async => ServerDetail(
        id: serverId,
        name: 'demo-1',
        status: ServerStatus.active,
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

  @override
  Future<CredentialReveal> credentialsReveal({
    required int serverId,
    required String reauthToken,
    AuthType authType = AuthType.password,
  }) async =>
      _reveal;
}

/// Pumps the credentials screen and walks through the re-auth sheet so the
/// credential view is rendered.
///
/// Uses fixed-duration pumps (not [WidgetTester.pumpAndSettle]) because the
/// screen's loading spinner animates indefinitely while the re-auth sheet is
/// open, so `pumpAndSettle` would time out.
Future<void> _pumpAndReveal(
  WidgetTester tester,
  CredentialReveal reveal,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
        serverRepositoryProvider
            .overrideWithValue(_FakeServerRepository(reveal)),
      ],
      child: const MaterialApp(home: CredentialsScreen(serverId: 7)),
    ),
  );

  // Let the post-frame callback open the re-auth sheet, then its slide-in.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));

  expect(find.text('Confirm'), findsOneWidget);
  await tester.enterText(find.byType(TextFormField), 'correct-horse');
  await tester.tap(find.text('Confirm'));

  // Sheet pops, credentials resolve, and the card fades/slides in.
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  group('CredentialsScreen connection details', () {
    testWidgets('rdp auth_type → shows RDP details, not SSH', (tester) async {
      await _pumpAndReveal(
        tester,
        const CredentialReveal(
          authType: AuthType.rdp,
          credential: 'Sup3rSecret!',
          ipAddress: '203.0.113.10',
        ),
      );

      expect(find.text('RDP (Remote Desktop)'), findsOneWidget);
      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('3389'), findsOneWidget);
      expect(find.text('Copy RDP connection'), findsOneWidget);

      expect(find.text('SSH (Secure Shell)'), findsNothing);
      expect(find.text('root'), findsNothing);
    });

    testWidgets('password auth_type → shows SSH details, not RDP',
        (tester) async {
      await _pumpAndReveal(
        tester,
        const CredentialReveal(
          authType: AuthType.password,
          credential: 'Sup3rSecret!',
          ipAddress: '203.0.113.10',
        ),
      );

      expect(find.text('SSH (Secure Shell)'), findsOneWidget);
      expect(find.text('root'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
      expect(find.text('Copy SSH connection'), findsOneWidget);

      expect(find.text('RDP (Remote Desktop)'), findsNothing);
      expect(find.text('Administrator'), findsNothing);
    });
  });
}
