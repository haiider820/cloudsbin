import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/api/response_parser.dart';
import '../../../shared/models/paged.dart';
import 'models/auth_session_info.dart';
import 'models/user_profile.dart';

/// Account operations: profile, sessions, logout (§2.6–6.9).
class AccountRepository {
  AccountRepository(this._client);

  final ApiClient _client;

  Future<UserProfile> me() async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>('me');
      return parseResponse(response, UserProfile.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<Paged<AuthSessionInfo>> sessions() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('auth/sessions');
      return parseResponse(
        response,
        (json) => Paged.fromJson<AuthSessionInfo>(json, AuthSessionInfo.fromJson),
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /auth/sessions-revoke {"session_id"}` → `{"revoked": true}`.
  /// Idempotent: revoking an already-revoked owned session answers 200 again.
  Future<bool> revokeSession(int sessionId) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/sessions-revoke',
        data: {'session_id': sessionId},
      );
      return response.data?['revoked'] == true;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /auth/logout` → `{"logged_out": true}`. The token dies
  /// immediately; callers must clear local storage too.
  Future<void> logout() async {
    try {
      await _client.dio.post<Map<String, dynamic>>('auth/logout');
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /auth/logout-all` → `{"revoked": N}` — every session in this
  /// audience, including the current one.
  Future<int> logoutAll() async {
    try {
      final response =
          await _client.dio.post<Map<String, dynamic>>('auth/logout-all');
      final revoked = response.data?['revoked'];
      return revoked is int ? revoked : 0;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepository(ref.watch(apiClientProvider)),
);
