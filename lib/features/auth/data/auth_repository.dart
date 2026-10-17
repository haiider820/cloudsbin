import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/storage/secure_storage.dart';
import 'models/auth_user.dart';
import 'models/device_info.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';
import 'models/message_response.dart';
import 'models/register_request.dart';
import 'models/token_pair.dart';

/// Auth operations for the user audience (§6.1–6.9).
class AuthRepository {
  AuthRepository(this._client, this._storage);

  final ApiClient _client;
  final SecureStorage _storage;

  Future<LoginResponse> login({
    required String email,
    required String password,
    required String deviceId,
    required String platform,
    String? deviceName,
    String? appVersion,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/login',
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
      final parsed = LoginResponse.fromJson(response.data!);
      await _storage.writeTokens(
        TokenKeys.user,
        accessToken: parsed.accessToken,
        refreshToken: parsed.refreshToken,
      );
      return parsed;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<MessageResponse> register({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirm,
    bool acceptTerms = true,
    String? referralCode,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/register',
        data: RegisterRequest(
          fullName: fullName,
          email: email,
          password: password,
          passwordConfirm: passwordConfirm,
          acceptTerms: acceptTerms,
          ref: referralCode,
        ).toJson(),
      );
      return MessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Always answers the neutral 202 message (§2.8, §6.8).
  Future<MessageResponse> forgotPassword(String email) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/password-forgot',
        data: {'email': email},
      );
      return MessageResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Best-effort re-request of the verification email.
  ///
  /// The v1 contract re-triggers the verification mail by re-hitting
  /// `auth/register`; the caller always treats this as "sent" (neutral
  /// messaging, never reveals whether the address exists).
  Future<void> resendVerificationEmail(String email) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'auth/register',
        data: {'email': email},
      );
    } on DioException {
      // Intentionally swallowed: resend always reports success to the user.
    }
  }

  /// Consumes an email-verification token from a deep link.
  ///
  /// 200 means the address is now verified; 404/410 throw an [ApiError] with
  /// `TOKEN_INVALID`, `TOKEN_EXPIRED` or `TOKEN_USED`.
  Future<void> verifyEmail(String token) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'auth/verify-email',
        data: {'token': token},
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Consumes a password-reset token from a deep link and sets a new password.
  ///
  /// 200 means the password was reset; 400/404/410 throw an [ApiError].
  Future<void> resetPassword({
    required String token,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      await _client.dio.post<Map<String, dynamic>>(
        'auth/password-reset',
        data: {
          'token': token,
          'password': password,
          'password_confirm': passwordConfirm,
        },
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<void> logout() async {
    try {
      await _client.dio.post<Map<String, dynamic>>('auth/logout');
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<int> logoutAll() async {
    try {
      final response =
          await _client.dio.post<Map<String, dynamic>>('auth/logout-all');
      return (response.data?['revoked'] as num?)?.toInt() ?? 0;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Explicit refresh (the interceptor already auto-refreshes on 401).
  Future<TokenPair> refresh() async {
    final refreshToken = await _storage.readRefreshToken(TokenKeys.user);
    if (refreshToken == null) {
      throw const ApiError(code: 'SESSION_REVOKED', message: 'No refresh token.');
    }
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/refresh',
        data: {'refresh_token': refreshToken},
      );
      final pair = TokenPair.fromJson(response.data!);
      await _storage.writeTokens(
        TokenKeys.user,
        accessToken: pair.accessToken,
        refreshToken: pair.refreshToken,
      );
      return pair;
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Mints a single-use re-auth grant for dangerous actions (§3).
  /// The grant is returned to the caller and never stored.
  Future<String> reauth(String password) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'auth/reauth',
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

  /// `GET /me` (§6.9).
  Future<AuthUser> me() async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>('me');
      return AuthUser.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(secureStorageProvider),
  );
});
