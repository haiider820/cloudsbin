import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/presentation/verify_email_screen.dart';

import '../../helpers/fakes.dart';

late MemorySecureStorage _storage;
late ScriptedAdapter _adapter;

const String _token =
    'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';

Future<void> _pumpVerify(
  WidgetTester tester,
  List<ScriptedResponse> script, {
  String token = _token,
}) async {
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
      child: MaterialApp(home: VerifyEmailScreen(token: token)),
    ),
  );
  // postFrameCallback -> _verify() -> dio request.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 50));
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  group('VerifyEmailScreen', () {
    testWidgets('200 verified:true shows success and a login button',
        (tester) async {
      await _pumpVerify(tester, [
        ScriptedResponse(200, const {'verified': true}),
      ]);

      expect(find.text('Email verified! You can now sign in.'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Go to Login'), findsOneWidget);
      expect(_adapter.calls, 1);
      expect((_adapter.requests.single.data as Map)['token'], _token);

      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('410 TOKEN_EXPIRED shows the expired message', (tester) async {
      await _pumpVerify(tester, [
        ScriptedResponse(410, const {
          'error': 'This link has expired.',
          'code': 'TOKEN_EXPIRED',
          'request_id': 'req-410',
        }),
      ]);

      expect(find.text('This link has expired.'), findsOneWidget);
      expect(
        find.widgetWithText(
          FilledButton,
          'Request a new verification email',
        ),
        findsOneWidget,
      );

      await tester.pump(const Duration(seconds: 2));
    });

    testWidgets('404 TOKEN_INVALID shows the invalid-link message',
        (tester) async {
      await _pumpVerify(tester, [
        ScriptedResponse(404, const {
          'error': 'Invalid verification link.',
          'code': 'TOKEN_INVALID',
          'request_id': 'req-404',
        }),
      ]);

      expect(find.text('Invalid verification link.'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Go to Login'), findsOneWidget);

      await tester.pump(const Duration(seconds: 2));
    });
  });
}
