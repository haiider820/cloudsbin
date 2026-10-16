import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/storage/secure_storage.dart';
import '../../auth/data/auth_session.dart';

/// Admin audience auth (§5.1–§5.3). Tokens use the admin secure-storage keys
/// and are never shared with the user audience.
class AdminAuthRepository {
  AdminAuthRepository(this._client, this._storage);

  final ApiClient _client;
  final SecureStorage _storage;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await _client.dio.post<Map<String, dynamic>>('admin/auth/login',
              data: {'email': email, 'password': password});
      await _storage.writeTokens(
        TokenKeys.admin,
        accessToken: response.data!['access_token'] as String,
        refreshToken: (response.data!['refresh_token'] as String?) ?? '',
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<Map<String, dynamic>> me() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('admin/me');
      return response.data!;
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
  client.onSessionExpired =
      () => ref.read(adminSessionProvider.notifier).logoutLocal();
  return client;
});

final adminAuthRepositoryProvider = Provider<AdminAuthRepository>(
  (ref) => AdminAuthRepository(
    ref.watch(adminApiClientProvider),
    ref.watch(secureStorageProvider),
  ),
);
