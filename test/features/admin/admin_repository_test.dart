import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_auth_repository.dart';

import '../../helpers/fakes.dart';

void main() {
  late MemorySecureStorage storage;
  late ApiClient client;
  late AdminAuthRepository repo;

  ScriptedAdapter script(List<ScriptedResponse> responses) {
    final adapter = ScriptedAdapter(responses);
    client.dio.httpClientAdapter = adapter;
    return adapter;
  }

  setUp(() {
    storage = MemorySecureStorage();
    client = ApiClient(
      storage: storage,
      appVersion: '1.0.0',
      tokenKeys: TokenKeys.admin,
    );
    repo = AdminAuthRepository(client, storage);
  });

  group('AdminAuthRepository', () {
    test('login sends the device payload and stores only admin tokens',
        () async {
      final adapter = script(const [
        ScriptedResponse(
          200,
          {'access_token': 'admin-a', 'refresh_token': 'admin-r'},
        ),
      ]);

      await repo.login(
        email: 'root@cloudsbin.io',
        password: 'pw',
        deviceId: 'dev-42',
        platform: 'android',
        appVersion: '2.1.0',
      );

      final request = adapter.requests.single;
      expect(request.uri.path, '/api/v1/admin/auth/login');
      // Dio serialises nested freezed objects at encode time — mirror the
      // wire payload with a JSON round-trip.
      final body = jsonDecode(jsonEncode(request.data)) as Map<String, dynamic>;
      expect(body['email'], 'root@cloudsbin.io');
      final device = body['device'] as Map<String, dynamic>;
      expect(device['id'], 'dev-42');
      expect(device['platform'], 'android');
      expect(device['app_version'], '2.1.0');

      expect(storage.values['admin_access_token'], 'admin-a');
      expect(storage.values['admin_refresh_token'], 'admin-r');
      expect(storage.values['access_token'], isNull);
      expect(storage.values['refresh_token'], isNull);
    });

    test('logout clears only the admin keys, user tokens survive', () async {
      storage.values
        ..['admin_access_token'] = 'aa'
        ..['admin_refresh_token'] = 'ar'
        ..['access_token'] = 'ua'
        ..['refresh_token'] = 'ur';
      final adapter = script(const [
        ScriptedResponse(200, {'logged_out': true}),
      ]);

      await repo.logout();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/auth/logout');
      expect(storage.values['admin_access_token'], isNull);
      expect(storage.values['admin_refresh_token'], isNull);
      expect(storage.values['access_token'], 'ua');
      expect(storage.values['refresh_token'], 'ur');
    });

    test('logoutAll clears only the admin keys', () async {
      storage.values
        ..['admin_access_token'] = 'aa'
        ..['admin_refresh_token'] = 'ar'
        ..['access_token'] = 'ua'
        ..['refresh_token'] = 'ur';
      final adapter = script(const [
        ScriptedResponse(200, {'revoked': 3}),
      ]);

      await repo.logoutAll();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/auth/logout-all');
      expect(storage.values['admin_access_token'], isNull);
      expect(storage.values['access_token'], 'ua');
    });

    test('getProfile hits /admin/me and parses AdminProfile', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'id': 7,
          'email': 'root@cloudsbin.io',
          'role': 'admin',
          'created_at': '2026-01-05T10:00:00Z',
          'referral_code': null,
        }),
      ]);

      final profile = await repo.getProfile();

      expect(adapter.requests.single.uri.path, '/api/v1/admin/me');
      expect(profile.id, 7);
      expect(profile.email, 'root@cloudsbin.io');
      expect(profile.role, 'admin');
      expect(profile.createdAt, isNotNull);
      expect(profile.referralCode, isNull);
    });

    test('getSessions hits admin sessions path and parses items', () async {
      final adapter = script(const [
        ScriptedResponse(200, {
          'items': [
            {
              'id': 228,
              'device_name': 'Pixel 8',
              'platform': 'android',
              'app_version': '1.0.0',
              'last_used_at': '2026-10-16T10:04:05Z',
              'last_ip': '127.0.0.1',
              'created_at': '2026-10-16T10:04:05Z',
              'current': true,
            },
            {
              'id': 229,
              'device_name': 'iPhone 15',
              'platform': 'ios',
              'app_version': '1.0.0',
              'last_used_at': '2026-10-15T09:00:00Z',
              'last_ip': '198.51.100.9',
              'created_at': '2026-10-15T09:00:00Z',
              'current': false,
            },
          ],
          'page': 1,
          'per_page': 25,
          'total': 2,
          'has_more': false,
        }),
      ]);

      final paged = await repo.getSessions();

      expect(
        adapter.requests.single.uri.path,
        '/api/v1/admin/auth/sessions',
      );
      expect(paged.items, hasLength(2));
      expect(paged.items.first.id, 228);
      expect(paged.items.first.current, isTrue);
      expect(paged.items.first.lastUsedAt, isNotNull);
      expect(paged.items.last.platform, 'ios');
      expect(paged.items.last.current, isFalse);
      expect(paged.total, 2);
    });

    test('revokeSession posts session_id to the admin revoke endpoint',
        () async {
      final adapter = script(const [
        ScriptedResponse(200, {'revoked': true}),
      ]);

      final revoked = await repo.revokeSession(42);

      expect(revoked, isTrue);
      final request = adapter.requests.single;
      expect(
        request.uri.path,
        '/api/v1/admin/auth/sessions-revoke',
      );
      expect(request.data!['session_id'], 42);
    });
  });
}
