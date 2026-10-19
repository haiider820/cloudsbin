import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../storage/secure_storage.dart';
import 'logging_interceptor.dart';

/// Attaches `Authorization: Bearer <access_token>` and implements the
/// 401 recovery contract from FLUTTER_API_GUIDE §2.5:
///
///   * `TOKEN_EXPIRED`  → `POST auth/refresh` once → store new pair →
///                        retry the original request exactly once.
///   * `AUTH_REQUIRED`  → clear tokens + bounce to login (no retry).
///   * `SESSION_REVOKED`→ clear tokens + bounce to login (refresh is useless).
///
/// A per-request flag guards against recursive refresh attempts, and a
/// [QueuedInterceptor] serialises resolution so concurrent 401s trigger a
/// single refresh.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureStorage storage,
    required TokenKeys tokenKeys,
    required Dio client,
    required Dio refreshClient,
    this.refreshPath = 'auth/refresh',
    this.onSessionExpired,
  })  : _storage = storage,
        _tokenKeys = tokenKeys,
        _client = client,
        _refreshClient = refreshClient;

  final SecureStorage _storage;
  final TokenKeys _tokenKeys;
  final Dio _client;
  final Dio _refreshClient;
  final String refreshPath;
  final VoidCallback? onSessionExpired;

  static const String _retriedFlag = '_auth_retried';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.headers.containsKey('Authorization')) {
      final token = await _storage.readAccessToken(_tokenKeys);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    if (response?.statusCode != 401) {
      return handler.next(err);
    }

    final code = _errorCode(response?.data);

    switch (code) {
      case 'TOKEN_EXPIRED':
        final alreadyRetried = err.requestOptions.extra[_retriedFlag] == true;
        if (alreadyRetried) {
          await _handleUnrecoverable();
          return handler.next(err);
        }
        final refreshed = await _tryRefresh();
        if (refreshed == null) {
          await _handleUnrecoverable();
          return handler.next(err);
        }
        try {
          final retried = await _retry(err.requestOptions, refreshed.accessToken);
          return handler.resolve(retried);
        } on DioException catch (retryErr) {
          // The retried request failed again: surface it, but if it is another
          // 401 the session is dead.
          if (retryErr.response?.statusCode == 401) {
            await _handleUnrecoverable();
          }
          return handler.next(retryErr);
        }
      case 'AUTH_REQUIRED':
      case 'SESSION_REVOKED':
        await _handleUnrecoverable();
        return handler.next(err);
      default:
        return handler.next(err);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions options, String accessToken) async {
    options.extra[_retriedFlag] = true;
    options.headers['Authorization'] = 'Bearer $accessToken';
    // Retry on a bare Dio, not [_client]: re-entering this QueuedInterceptor
    // would serialize the retried request's onError behind this very onError
    // on the error queue, deadlocking forever when the retry also 401s.
    // The adapter is shared so DEMO mode and tests keep working; the retry
    // client is intentionally never closed because the adapter is shared.
    final retryClient = Dio(_client.options)
      ..httpClientAdapter = _client.httpClientAdapter
      ..interceptors.add(LoggingInterceptor());
    return retryClient.fetch<dynamic>(options);
  }

  /// Returns the new access token, or null when refresh is impossible.
  Future<_RefreshedTokens?> _tryRefresh() async {
    final refreshToken = await _storage.readRefreshToken(_tokenKeys);
    if (refreshToken == null || refreshToken.isEmpty) return null;
    try {
      final res = await _refreshClient.post<Map<String, dynamic>>(
        refreshPath,
        data: {'refresh_token': refreshToken},
      );
      final data = res.data;
      if (res.statusCode != 200 || data == null) return null;
      final access = data['access_token']?.toString();
      final refresh = data['refresh_token']?.toString();
      if (access == null || refresh == null) return null;
      await _storage.writeTokens(
        _tokenKeys,
        accessToken: access,
        refreshToken: refresh,
      );
      return _RefreshedTokens(accessToken: access);
    } on DioException {
      return null;
    }
  }

  Future<void> _handleUnrecoverable() async {
    await _storage.clearTokens(_tokenKeys);
    onSessionExpired?.call();
  }

  static String? _errorCode(dynamic data) {
    if (data is Map) return data['code']?.toString();
    return null;
  }
}

class _RefreshedTokens {
  const _RefreshedTokens({required this.accessToken});

  final String accessToken;
}
