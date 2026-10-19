import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_notifications_screen.dart';

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

void main() {
  testWidgets('fits a 360x812 phone when history fails (no overflow)',
      (tester) async {
    // TECNO CL6: 1080x2436 physical @ 480dpi -> 360x812 logical.
    await tester.binding.setSurfaceSize(const Size(360, 812));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final adapter = ScriptedAdapter(const [
      ScriptedResponse(500, {
        'error': 'Could not load notification history.',
        'code': 'DB_ERROR',
      }),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          adminRepositoryProvider
              .overrideWithValue(AdminRepository(_client(adapter))),
        ],
        child: const MaterialApp(home: AdminNotificationsScreen()),
      ),
    );
    await tester.pump();
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(tester.takeException(), isNull);
    expect(find.text('Something went wrong'), findsOneWidget);
  });
}
