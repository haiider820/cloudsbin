import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_users_screen.dart';

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

Future<void> _pump(WidgetTester tester) async {
  await tester.pump();
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _tallSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(420, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

const _page = {
  'items': [
    {
      'id': 900152,
      'email': 'demo-user@cloudsbin.local',
      'role': 'user',
      'wallet_balance_usd': '84.00',
      'server_count': 3,
      'is_active': true,
      'last_login_at': '2026-10-16T10:04:05Z',
      'created_at': '2026-10-12T08:18:39Z',
    },
    {
      'id': 900154,
      'email': 'banned@example.com',
      'role': 'admin',
      'wallet_balance_usd': '0.00',
      'server_count': 0,
      'is_active': false,
      'last_login_at': '2026-09-01T07:45:00Z',
    },
  ],
  'page': 1,
  'per_page': 20,
  'total': 2,
  'has_more': false,
};

void main() {
  testWidgets('renders the user list with role + status pills', (tester) async {
    await _tallSurface(tester);
    final adapter = ScriptedAdapter(const [ScriptedResponse(200, _page)]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminUsersScreen()),
      ),
    );
    await _pump(tester);

    expect(adapter.requests.single.uri.path, '/api/v1/admin/users');
    expect(adapter.requests.single.uri.queryParameters['per_page'], '20');

    expect(find.text('demo-user@cloudsbin.local'), findsOneWidget);
    expect(find.text('banned@example.com'), findsOneWidget);
    expect(find.text('84.00'), findsOneWidget);
    expect(find.text('User'), findsOneWidget);
    expect(find.text('Admin'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Banned'), findsOneWidget);
    expect(find.textContaining('Last login:'), findsNWidgets(2));
  });

  testWidgets('submitting a search refetches with the search query',
      (tester) async {
    await _tallSurface(tester);
    final adapter = ScriptedAdapter(const [
      ScriptedResponse(200, _page),
      ScriptedResponse(200, {
        'items': [],
        'page': 1,
        'per_page': 20,
        'total': 0,
        'has_more': false,
      }),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminUsersScreen()),
      ),
    );
    await _pump(tester);

    await tester.enterText(find.byType(TextFormField), 'sara');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await _pump(tester);

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.last.uri.queryParameters['search'], 'sara');
    expect(find.text('No users found'), findsOneWidget);
  });
}
