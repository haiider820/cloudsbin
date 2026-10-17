import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/presentation/reset_password_screen.dart';

import '../../helpers/fakes.dart';

late MemorySecureStorage _storage;
late ScriptedAdapter _adapter;

GoRouter _router() => GoRouter(
      initialLocation: '/reset-password?token=tk',
      routes: [
        GoRoute(
          path: '/reset-password',
          builder: (context, state) => ResetPasswordScreen(
            token: state.uri.queryParameters['token'] ?? '',
          ),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('LOGIN_PAGE'))),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) =>
              const Scaffold(body: Center(child: Text('FORGOT_PAGE'))),
        ),
      ],
    );

Future<void> _pumpReset(
  WidgetTester tester,
  List<ScriptedResponse> script,
) async {
  _storage = MemorySecureStorage();
  final client = ApiClient(storage: _storage, appVersion: '1.0.0')
    ..dio.httpClientAdapter = ScriptedAdapter(script);
  _adapter = client.dio.httpClientAdapter as ScriptedAdapter;
  tester.view.physicalSize = const Size(420, 1600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(_storage),
        apiClientProvider.overrideWithValue(client),
      ],
      child: MaterialApp.router(routerConfig: _router()),
    ),
  );
  await tester.pump(const Duration(milliseconds: 800));
}

Future<void> _fill(
  WidgetTester tester, {
  required String password,
  required String confirm,
}) async {
  await tester.enterText(find.byType(TextFormField).first, password);
  await tester.enterText(find.byType(TextFormField).last, confirm);
}

Future<void> _tapReset(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(FilledButton, 'Reset Password'));
  await tester.pump();
}

void main() {
  group('ResetPasswordScreen', () {
    testWidgets('empty password fails validation without a request',
        (tester) async {
      await _pumpReset(tester, const []);

      await _tapReset(tester);

      expect(find.text('Password is required'), findsOneWidget);
      expect(_adapter.calls, 0);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('mismatched passwords fail validation without a request',
        (tester) async {
      await _pumpReset(tester, const []);

      await _fill(tester, password: 'password123', confirm: 'different123');
      await _tapReset(tester);

      expect(find.text('Passwords do not match'), findsOneWidget);
      expect(_adapter.calls, 0);
      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('200 reset:true shows success then navigates to login',
        (tester) async {
      await _pumpReset(tester, [
        ScriptedResponse(200, const {'reset': true}),
      ]);

      await _fill(tester, password: 'password123', confirm: 'password123');
      await _tapReset(tester);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Password reset! You can now sign in.'), findsOneWidget);
      expect(_adapter.calls, 1);
      expect(
        (_adapter.requests.single.data as Map)['password_confirm'],
        'password123',
      );

      // Success auto-navigates after 2 seconds.
      await tester.pump(const Duration(seconds: 2));
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('LOGIN_PAGE'), findsOneWidget);
    });

    testWidgets('410 TOKEN_EXPIRED shows expired message + request-link button',
        (tester) async {
      await _pumpReset(tester, [
        ScriptedResponse(410, const {
          'error': 'This reset link has expired.',
          'code': 'TOKEN_EXPIRED',
          'request_id': 'req-410',
        }),
      ]);

      await _fill(tester, password: 'password123', confirm: 'password123');
      await _tapReset(tester);
      await tester.pump(const Duration(milliseconds: 50));
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('This reset link has expired.'), findsOneWidget);
      expect(
        find.widgetWithText(FilledButton, 'Request a new link'),
        findsOneWidget,
      );
      await tester.pump(const Duration(seconds: 2));
    });
  });
}
