import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/data/auth_session.dart';
import 'package:cloudsbin/features/auth/presentation/login_screen.dart';

import '../helpers/fakes.dart';

const _loginOk = <String, dynamic>{
  'access_token': 'demo-access-token',
  'access_expires_at': '2026-10-16T10:19:07Z',
  'refresh_token': 'demo-refresh-token',
  'refresh_expires_at': '2026-11-15T10:04:07Z',
};

late MemorySecureStorage _storage;
late ScriptedAdapter _adapter;

Future<void> _pumpLogin(
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
      child: const MaterialApp(home: LoginScreen()),
    ),
  );
  // Let the entrance animations land so taps hit the settled layout.
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _submit(WidgetTester tester) async {
  await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
  await tester.pump();
}

void main() {
  group('LoginScreen', () {
    testWidgets('empty submit shows both field errors without a request',
        (tester) async {
      await _pumpLogin(tester, const []);

      await _submit(tester);

      expect(find.text('Email is required'), findsOneWidget);
      expect(find.text('Password is required'), findsOneWidget);
      expect(_adapter.calls, 0);
    });

    testWidgets('malformed email fails validation client-side', (tester) async {
      await _pumpLogin(tester, const []);

      await tester.enterText(find.byType(TextFormField).first, 'nope');
      await _submit(tester);

      expect(find.text('Enter a valid email'), findsOneWidget);
      expect(_adapter.calls, 0);
    });

    testWidgets('AUTH_REQUIRED 401 surfaces the server message in the banner',
        (tester) async {
      await _pumpLogin(tester, [
        ScriptedResponse(401, const {
          'error': 'Invalid email or password.',
          'code': 'AUTH_REQUIRED',
          'request_id': 'req-401',
        }),
      ]);

      await tester.enterText(
        find.byType(TextFormField).first,
        'user@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, 'wrongpass');
      await _submit(tester);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));

      expect(find.text('Invalid email or password.'), findsOneWidget);
      expect(_adapter.calls, 1);
      expect(_storage.values['access_token'], isNull);

      final container = ProviderScope.containerOf(
        tester.element(find.byType(LoginScreen)),
      );
      expect(
        container.read(sessionProvider).status,
        isNot(SessionStatus.authenticated),
      );
      // Flush the banner's flutter_animate delay timer before teardown.
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('valid credentials store tokens and mark the session live',
        (tester) async {
      final ok = ScriptedResponse(200, _loginOk, gate: Completer<void>());
      await _pumpLogin(tester, [ok]);

      await tester.enterText(
        find.byType(TextFormField).first,
        'user@example.com ',
      );
      await tester.enterText(find.byType(TextFormField).last, 'hunter2!');
      await _submit(tester);
      // dio's interceptor queue parks until fake time elapses — an
      // elapsing pump is what actually dispatches the request.
      await tester.pump(const Duration(milliseconds: 50));

      // Request in flight: button spins, exactly one call issued.
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(_adapter.calls, 1);
      expect(
        (_adapter.requests.single.data as Map)['email'],
        'user@example.com',
      );

      ok.gate!.complete();
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      final container = ProviderScope.containerOf(
        tester.element(find.byType(LoginScreen)),
      );
      expect(
        container.read(sessionProvider).status,
        SessionStatus.authenticated,
      );
      expect(container.read(sessionProvider).email, 'user@example.com');
      expect(_storage.values['access_token'], 'demo-access-token');
      expect(_storage.values['refresh_token'], 'demo-refresh-token');
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
