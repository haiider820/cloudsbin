import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_auth_repository.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_dashboard_screen.dart';

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

/// Pump the dashboard and let both the profile and stats futures resolve.
/// Fixed-duration pumps (not `pumpAndSettle`) because the shimmer + entrance
/// animations keep ticking while data loads.
Future<void> _pump(WidgetTester tester) async {
  await tester.pump();
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Phone-tall surface so the compact 800x600 default can't clip the
/// dashboard / shimmer layout.
Future<void> _tallSurface(WidgetTester tester) async {
  await tester.binding.setSurfaceSize(const Size(420, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
}

void main() {
  testWidgets('renders profile, real counters and every nav entry',
      (tester) async {
    await _tallSurface(tester);
    final profileClient = _client(ScriptedAdapter(const [
      ScriptedResponse(200, {
        'id': 7,
        'email': 'root@cloudsbin.io',
        'role': 'admin',
        'created_at': '2026-01-05T10:00:00Z',
      }),
    ]));
    final statsClient = _client(ScriptedAdapter(const [
      ScriptedResponse(200, {
        'users': {'total': 150, 'new_today': 3, 'new_this_month': 45},
        'servers': {'total': 89, 'active': 67},
        'orders': {'pending': 5},
        'revenue': {'this_month_usd': '1250.00'},
        'tickets': {'open': 8, 'unread': 3},
        'topups': {'pending_count': 2},
      }),
    ]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminAuthRepositoryProvider.overrideWithValue(
            AdminAuthRepository(profileClient, MemorySecureStorage()),
          ),
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(statsClient)),
        ],
        child: const MaterialApp(home: AdminDashboardScreen()),
      ),
    );
    await _pump(tester);

    expect(find.text('root@cloudsbin.io'), findsOneWidget);
    expect(find.text('ADMIN'), findsOneWidget);

    // Stats cards driven by the live /admin/dashboard payload.
    expect(find.text('OVERVIEW'), findsOneWidget);
    expect(find.text('150'), findsOneWidget);
    expect(find.text('89'), findsOneWidget);
    expect(find.text('Pending orders'), findsOneWidget);
    expect(find.text('Revenue (mo)'), findsOneWidget);
    expect(find.text(r'$1,250.00'), findsOneWidget);

    // Quick-action badges for the three review queues.
    expect(find.text('NEEDS REVIEW'), findsOneWidget);
    expect(find.text('5'), findsWidgets); // pending-order stat + badge
    expect(find.text('2'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);

    // Full management navigation.
    expect(find.text('MANAGE'), findsOneWidget);
    expect(find.text('Orders'), findsWidgets);
    expect(find.text('Top-ups'), findsWidgets);
    expect(find.text('Withdrawals'), findsOneWidget);
    expect(find.text('Support'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Users'), findsWidgets);
    expect(find.text('Servers'), findsWidgets);
  });

  testWidgets('shows a retry banner when stats fail to load', (tester) async {
    await _tallSurface(tester);
    final profileClient = _client(ScriptedAdapter(const [
      ScriptedResponse(200, {'id': 7, 'email': 'root@cloudsbin.io', 'role': 'admin'}),
    ]));
    final statsClient = _client(ScriptedAdapter(const [
      ScriptedResponse(500, {'code': 'SERVER_ERROR', 'message': 'boom'}),
    ]));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminAuthRepositoryProvider.overrideWithValue(
            AdminAuthRepository(profileClient, MemorySecureStorage()),
          ),
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(statsClient)),
        ],
        child: const MaterialApp(home: AdminDashboardScreen()),
      ),
    );
    await _pump(tester);

    expect(find.text('Could not load platform stats.'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}
