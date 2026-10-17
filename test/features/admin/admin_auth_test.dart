import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/interceptors/auth_interceptor.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/auth/data/auth_session.dart';

import '../../helpers/fakes.dart';

class _Harness {
  _Harness({
    required List<ScriptedResponse> clientScript,
    required List<ScriptedResponse> refreshScript,
    void Function()? onSessionExpired,
    MemorySecureStorage? storage,
  })  : storage = storage ?? MemorySecureStorage(),
        client = Dio(BaseOptions(baseUrl: 'https://api.test/')),
        refreshClient = Dio(BaseOptions(baseUrl: 'https://api.test/')) {
    this.storage.values
      ..putIfAbsent('admin_access_token', () => 'old-access')
      ..putIfAbsent('admin_refresh_token', () => 'old-refresh');
    client.httpClientAdapter = ScriptedAdapter(clientScript);
    refreshClient.httpClientAdapter = ScriptedAdapter(refreshScript);
    interceptor = AuthInterceptor(
      storage: this.storage,
      tokenKeys: TokenKeys.admin,
      client: client,
      refreshClient: refreshClient,
      refreshPath: 'admin/auth/refresh',
      onSessionExpired: () {
        expiredCalls++;
        onSessionExpired?.call();
      },
    );
    client.interceptors.add(interceptor);
  }

  final MemorySecureStorage storage;
  final Dio client;
  final Dio refreshClient;
  late final AuthInterceptor interceptor;
  int expiredCalls = 0;

  Future<Response<dynamic>> get(String path) => client.get(path);

  ScriptedAdapter get clientAdapter =>
      client.httpClientAdapter as ScriptedAdapter;

  ScriptedAdapter get refreshAdapter =>
      refreshClient.httpClientAdapter as ScriptedAdapter;
}

const _refreshOk = ScriptedResponse(200, {
  'access_token': 'new-access',
  'refresh_token': 'new-refresh',
});

void main() {
  group('admin AuthInterceptor (TokenKeys.admin)', () {
    test('attaches the admin access token and refreshes via '
        'admin/auth/refresh, leaving user tokens untouched', () async {
      final h = _Harness(
        clientScript: [
          const ScriptedResponse(
            401,
            {'code': 'TOKEN_EXPIRED', 'message': 'expired'},
          ),
          const ScriptedResponse(200, {'ok': true}),
        ],
        refreshScript: [_refreshOk],
      );
      h.storage.values
        ..['access_token'] = 'user-access'
        ..['refresh_token'] = 'user-refresh';

      final response = await h.get('/admin/me');

      expect(response.statusCode, 200);
      // Original request + exactly one retry after the refresh.
      expect(h.clientAdapter.requests, hasLength(2));
      // Refresh went through the admin path — never `auth/refresh`.
      expect(h.refreshAdapter.requests.single.uri.path, '/admin/auth/refresh');
      expect(h.storage.values['admin_access_token'], 'new-access');
      expect(h.storage.values['admin_refresh_token'], 'new-refresh');
      // User audience untouched.
      expect(h.storage.values['access_token'], 'user-access');
      expect(h.storage.values['refresh_token'], 'user-refresh');
      expect(h.expiredCalls, 0);
    });

    test('attaches the admin access token as Bearer', () async {
      final h = _Harness(
        clientScript: const [ScriptedResponse(200, {'ok': true})],
        refreshScript: const [],
      );

      await h.get('/admin/me');

      // No 401 → no retry, so the recorded options still carry the token
      // the interceptor attached from the admin keys.
      expect(
        h.clientAdapter.requests.single.headers['Authorization'],
        'Bearer old-access',
      );
    });

    test('failed admin refresh clears admin keys only and fires '
        'onSessionExpired', () async {
      final h = _Harness(
        clientScript: [
          const ScriptedResponse(
            401,
            {'code': 'TOKEN_EXPIRED', 'message': 'expired'},
          ),
        ],
        refreshScript: [
          const ScriptedResponse(
            401,
            {'code': 'SESSION_REVOKED', 'message': 'gone'},
          ),
        ],
      );
      h.storage.values
        ..['access_token'] = 'user-access'
        ..['refresh_token'] = 'user-refresh';

      await expectLater(h.get('/admin/me'), throwsA(isA<DioException>()));

      expect(h.storage.values['admin_access_token'], isNull);
      expect(h.storage.values['admin_refresh_token'], isNull);
      expect(h.expiredCalls, 1);
      // User audience untouched by the admin failure.
      expect(h.storage.values['access_token'], 'user-access');
      expect(h.storage.values['refresh_token'], 'user-refresh');
    });

    test('SESSION_REVOKED drives the admin session to unauthenticated '
        '(router then sends /admin routes to /admin/login)', () async {
      final container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWithValue(MemorySecureStorage()),
        ],
      );
      addTearDown(container.dispose);
      final storage = container.read(secureStorageProvider) as MemorySecureStorage;
      storage.values
        ..['access_token'] = 'user-access'
        ..['refresh_token'] = 'user-refresh';
      container
          .read(adminSessionProvider.notifier)
          .markAuthenticated(email: 'root@cloudsbin.io');
      expect(
        container.read(adminSessionProvider).status,
        SessionStatus.authenticated,
      );

      // Exactly the wiring of `adminApiClientProvider`: the interceptor's
      // expiry callback flips the real AdminSessionNotifier.
      final h = _Harness(
        clientScript: [
          const ScriptedResponse(
            401,
            {'code': 'SESSION_REVOKED', 'message': 'gone'},
          ),
        ],
        refreshScript: const [],
        storage: storage,
        onSessionExpired: () =>
            container.read(adminSessionProvider.notifier).logoutLocal(),
      );

      await expectLater(h.get('/admin/me'), throwsA(isA<DioException>()));
      // Drain the unawaited logoutLocal() microtasks before asserting.
      await Future<void>.delayed(Duration.zero);

      expect(h.expiredCalls, 1);
      expect(
        container.read(adminSessionProvider).status,
        SessionStatus.unauthenticated,
      );
      expect(storage.values['admin_access_token'], isNull);
      expect(storage.values['admin_refresh_token'], isNull);
      // User tokens never touched by an admin-session revocation.
      expect(storage.values['access_token'], 'user-access');
      expect(storage.values['refresh_token'], 'user-refresh');
    });

    test('non-401 admin errors pass through untouched', () async {
      final h = _Harness(
        clientScript: [
          const ScriptedResponse(
            500,
            {'code': 'SERVER_ERROR', 'message': 'boom'},
          ),
        ],
        refreshScript: const [],
      );

      await expectLater(h.get('/admin/me'), throwsA(isA<DioException>()));

      expect(h.storage.values['admin_access_token'], 'old-access');
      expect(h.expiredCalls, 0);
      expect(h.refreshAdapter.requests, isEmpty);
    });
  });
}
