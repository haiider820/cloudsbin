import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_auth_repository.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_orders_screen.dart';

import '../../helpers/fakes.dart';

ApiClient _client(ScriptedAdapter adapter) {
  final client = ApiClient(
    storage: MemorySecureStorage(),
    appVersion: '1.0.0',
    tokenKeys: TokenKeys.admin,
  );
  client.dio.httpClientAdapter = adapter;
  return client;
}

const _page = {
  'items': [
    {
      'id': 66,
      'user_id': 32,
      'user_email': 'haiider820@gmail.com',
      'status': 'pending',
      'plan_name': 'basic',
      'total_cents': 55,
      'has_receipt': false,
      'created_at': '2026-10-19T07:53:00Z',
    },
  ],
  'page': 1,
  'per_page': 20,
  'total': 1,
  'has_more': false,
};

void main() {
  testWidgets('approve failure shows the error and does not crash',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final adapter = ScriptedAdapter(const [
      ScriptedResponse(200, _page),
      ScriptedResponse(400, {
        'error': 'Order cannot be approved.',
        'code': 'INVALID_STATE',
      }),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminOrdersScreen()),
      ),
    );
    await tester.pump();
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('Approve'), findsOneWidget);
    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();

    // Confirm the prompt with an empty note.
    await tester.tap(find.text('Approve').last);
    await tester.pump();
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Order cannot be approved'), findsOneWidget);
  });

  testWidgets('REAUTH_REQUIRED prompts for the admin password then retries',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final adapter = ScriptedAdapter(const [
      ScriptedResponse(200, _page),
      ScriptedResponse(403, {
        'error': 'Please confirm your password to continue.',
        'code': 'REAUTH_REQUIRED',
      }),
      ScriptedResponse(200, {'message': 'Order approved.'}),
      ScriptedResponse(200, _page),
    ]);
    final reauthAdapter = ScriptedAdapter(const [
      ScriptedResponse(200, {'reauth_token': 'grant-abc'}),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
          adminAuthRepositoryProvider.overrideWithValue(
            AdminAuthRepository(_client(reauthAdapter), MemorySecureStorage()),
          ),
        ],
        child: const MaterialApp(home: AdminOrdersScreen()),
      ),
    );
    await tester.pump();
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    await tester.tap(find.text('Approve'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Approve').last);
    await tester.pump();
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // The 403 step-up response opened the password sheet instead of a snackbar.
    expect(find.text('Confirm your password'), findsOneWidget);
    await tester.enterText(find.byType(TextField).last, 'hostadmin');
    await tester.tap(find.text('Confirm'));
    await tester.pump();
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Order #66 approved'), findsOneWidget);

    final approvals = adapter.requests
        .where((r) => r.uri.path.endsWith('/admin/orders/approve'))
        .toList();
    expect(approvals, hasLength(2));
    expect(approvals.first.headers['X-Reauth-Token'], isNull);
    expect(approvals.last.headers['X-Reauth-Token'], 'grant-abc');
    expect(reauthAdapter.requests.single.data!['password'], 'hostadmin');
  });
}
