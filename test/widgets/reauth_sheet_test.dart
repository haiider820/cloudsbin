import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/api/api_error.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/data/auth_repository.dart';
import 'package:cloudsbin/shared/widgets/reauth_sheet.dart';

/// Fake repository: real constructor with inert instances, `reauth`
/// overridden so no network or secure storage is touched.
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
  Future<String> reauth(String password) async {
    if (password == 'boom') {
      throw StateError('unexpected client failure');
    }
    if (password == 'correct-horse') return 'grant-abc-123';
    throw const ApiError(code: 'FORBIDDEN', message: 'Forbidden');
  }
}

/// Pumps a host app, opens the sheet, and returns the sheet's future plus a
/// dismiss helper.
Future<Future<String?>> _openSheet(WidgetTester tester) async {
  late Future<String?> sheetFuture;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(_FakeAuthRepository()),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () {
                sheetFuture = showReauthSheet(context);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pumpAndSettle();
  expect(find.byType(ReauthSheet), findsOneWidget);
  return sheetFuture;
}

Future<void> _dismiss(WidgetTester tester) async {
  Navigator.of(tester.element(find.byType(ReauthSheet))).pop();
  await tester.pumpAndSettle();
}

void main() {
  group('ReauthSheet', () {
    testWidgets('empty password shows a validation error', (tester) async {
      final future = await _openSheet(tester);
      await tester.tap(find.text('Confirm'));
      await tester.pump();
      expect(find.text('Password is required.'), findsOneWidget);
      await _dismiss(tester);
      expect(await future, isNull);
    });

    testWidgets('wrong password shows an invalid-password error',
        (tester) async {
      final future = await _openSheet(tester);
      await tester.enterText(find.byType(TextFormField), 'wrong-password');
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid password.'), findsOneWidget);
      await _dismiss(tester);
      expect(await future, isNull);
    });

    testWidgets('correct password pops the grant', (tester) async {
      final future = await _openSheet(tester);
      await tester.enterText(find.byType(TextFormField), 'correct-horse');
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(await future, 'grant-abc-123');
      expect(find.byType(ReauthSheet), findsNothing);
    });

    testWidgets(
        'non-ApiError failure shows a generic error and clears the spinner',
        (tester) async {
      final future = await _openSheet(tester);
      await tester.enterText(find.byType(TextFormField), 'boom');
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();
      expect(find.text('Something went wrong. Try again.'), findsOneWidget);
      // Loading must have been cleared so the sheet is still usable.
      expect(find.byType(ReauthSheet), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      await _dismiss(tester);
      expect(await future, isNull);
    });
  });
}
