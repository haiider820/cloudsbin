import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_tickets_screen.dart';

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

const _openPage = {
  'items': [
    {
      'id': 501,
      'user_id': 900152,
      'user_email': 'demo-user@cloudsbin.local',
      'subject': 'Cannot SSH into my server',
      'status': 'open',
      'priority': 'urgent',
      'last_reply_at': '2026-10-16T10:30:00Z',
      'unread_count': 2,
      'created_at': '2026-10-16T09:00:00Z',
    },
  ],
  'page': 1,
  'per_page': 20,
  'total': 1,
  'has_more': false,
};

const _closedPage = {
  'items': [
    {
      'id': 503,
      'user_id': 900156,
      'user_email': 'bilal@example.com',
      'subject': 'Upgrade plan',
      'status': 'closed',
      'priority': 'low',
      'last_reply_at': '2026-10-14T11:00:00Z',
      'unread_count': 0,
      'created_at': '2026-10-13T08:00:00Z',
    },
  ],
  'page': 1,
  'per_page': 20,
  'total': 1,
  'has_more': false,
};

void main() {
  testWidgets('defaults to the open queue and renders status + priority',
      (tester) async {
    await _tallSurface(tester);
    final adapter = ScriptedAdapter(const [ScriptedResponse(200, _openPage)]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminTicketsScreen()),
      ),
    );
    await _pump(tester);

    expect(adapter.requests.single.uri.path, '/api/v1/admin/tickets');
    expect(adapter.requests.single.uri.queryParameters['status'], 'open');

    expect(find.text('Cannot SSH into my server'), findsOneWidget);
    // 'Open' appears on the selected filter chip and the status pill.
    expect(find.text('Open'), findsNWidgets(2));
    expect(find.text('Urgent'), findsOneWidget);
    expect(find.text('demo-user@cloudsbin.local'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.textContaining('Last reply:'), findsOneWidget);
  });

  testWidgets('selecting the Closed filter refetches that status',
      (tester) async {
    await _tallSurface(tester);
    final adapter = ScriptedAdapter(const [
      ScriptedResponse(200, _openPage),
      ScriptedResponse(200, _closedPage),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminTicketsScreen()),
      ),
    );
    await _pump(tester);

    await tester.tap(find.text('Closed'));
    await _pump(tester);

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.last.uri.queryParameters['status'], 'closed');
    expect(find.text('Upgrade plan'), findsOneWidget);
    // Chip + status pill both read "Closed" once the closed queue loads.
    expect(find.text('Closed'), findsNWidgets(2));
    expect(find.text('Low'), findsOneWidget);
  });
}
