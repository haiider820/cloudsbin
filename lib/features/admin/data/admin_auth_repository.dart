import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/api/response_parser.dart';
import '../../../core/router/routes.dart';
import '../../../core/router/app_router.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../shared/models/paged.dart';
import '../../auth/data/auth_session.dart';
import '../../auth/data/models/device_info.dart';
import '../../auth/data/models/login_request.dart';
import 'models/admin_profile.dart';
import 'models/admin_session.dart';

/// Admin audience auth (§5.1–§5.3). Tokens use the admin secure-storage keys
/// and are never shared with the user audience.
class AdminAuthRepository {
  AdminAuthRepository(this._client, this._storage);

  final ApiClient _client;
  final SecureStorage _storage;

  /// `POST /admin/auth/login` with the same `device` contract as the user
  /// login. Tokens land exclusively under the admin keys.
  Future<void> login({
    required String email,
    required String password,
    required String deviceId,
    required String platform,
    String? deviceName,
    String? appVersion,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'admin/auth/login',
        data: LoginRequest(
          email: email,
          password: password,
          device: DeviceInfo(
            id: deviceId,
            name: deviceName,
            platform: platform,
            appVersion: appVersion,
          ),
        ).toJson(),
      );
      final data = parseResponse(response, (json) => json);
      final access = data['access_token']?.toString();
      if (access == null || access.isEmpty) {
        throw const ApiError(
          code: 'SERVER_ERROR',
          message: 'No access token returned.',
        );
      }
      await _storage.writeTokens(
        TokenKeys.admin,
        accessToken: access,
        refreshToken: data['refresh_token']?.toString() ?? '',
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/me`.
  Future<AdminProfile> getProfile() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('admin/me');
      return parseResponse(response, AdminProfile.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /admin/auth/sessions` → paged list of active admin sessions.
  Future<Paged<AdminSession>> getSessions() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('admin/auth/sessions');
      return parseResponse(
        response,
        (json) => Paged.fromJson<AdminSession>(json, AdminSession.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/auth/reauth {"password"}` — mints a single-use step-up grant
  /// for the dangerous admin mutations (approve/reject, wallet adjust, force
  /// destroy). The grant is returned to the caller and never stored.
  Future<String> reauth(String password) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'admin/auth/reauth',
        data: {'password': password},
      );
      final token = response.data?['reauth_token']?.toString();
      if (token == null || token.isEmpty) {
        throw const ApiError(
          code: 'SERVER_ERROR',
          message: 'No re-auth token returned.',
        );
      }
      return token;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /admin/auth/sessions-revoke {"session_id"}` → `{"revoked": true}`.
  Future<bool> revokeSession(int sessionId) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'admin/auth/sessions-revoke',
        data: {'session_id': sessionId},
      );
      return response.data?['revoked'] == true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<void> logout() async {
    try {
      await _client.dio.post<Map<String, dynamic>>('admin/auth/logout');
    } on DioException catch (_) {
      // Local logout must succeed even if the API call fails.
    } finally {
      await _storage.clearTokens(TokenKeys.admin);
    }
  }

  Future<void> logoutAll() async {
    try {
      await _client.dio.post<Map<String, dynamic>>('admin/auth/logout-all');
    } on DioException catch (_) {
      // Local logout must succeed even if the API call fails.
    } finally {
      await _storage.clearTokens(TokenKeys.admin);
    }
  }
}

/// Separate Dio client for the admin audience: admin token keys and refresh
/// via `admin/auth/refresh` (ApiClient picks the path from the token keys).
final adminApiClientProvider = Provider<ApiClient>((ref) {
  final client = ApiClient(
    storage: ref.watch(secureStorageProvider),
    appVersion: ref.watch(appVersionProvider),
    tokenKeys: TokenKeys.admin,
  );
  client.onSessionExpired = () {
    ref.read(adminSessionProvider.notifier).logoutLocal().then((_) {
      try {
        ref.read(routerProvider).go(Routes.login);
      } catch (_) {
        // Router may not be ready during tests; ignore.
      }
    });
  };
  return client;
});

final adminAuthRepositoryProvider = Provider<AdminAuthRepository>(
  (ref) => AdminAuthRepository(
    ref.watch(adminApiClientProvider),
    ref.watch(secureStorageProvider),
  ),
);
