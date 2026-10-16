import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/secure_storage.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Base URL. Injected at build time:
/// `flutter build apk --dart-define=API_BASE_URL=https://host/api/v1`.
/// Defaults to the live production backend.
const String apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'https://cloudsbin.duckdns.org/api/v1',
);

/// Ensures the base URL ends with a single `/` so relative endpoint paths
/// (`auth/login`) join correctly — Dio concatenates the two literally, so
/// without this every request would hit `/api/v1auth/login` and 404.
String _normalizeBaseUrl(String baseUrl) =>
    baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';

/// App version reported via `X-App-Version` (compared to `min_app_version`).
/// Overridden in [main] with the real value from package_info_plus.
final appVersionProvider = Provider<String>((ref) => '1.0.0');

/// Configured Dio wrapper for one API audience.
class ApiClient {
  ApiClient({
    required SecureStorage storage,
    required String appVersion,
    TokenKeys tokenKeys = TokenKeys.user,
    String baseUrl = apiBaseUrl,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: _normalizeBaseUrl(baseUrl),
            headers: {'X-App-Version': appVersion},
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
          ),
        ) {
    _refreshClient = Dio(
      BaseOptions(
        baseUrl: _normalizeBaseUrl(baseUrl),
        headers: {'X-App-Version': appVersion},
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.add(LoggingInterceptor());
    dio.interceptors.add(
      AuthInterceptor(
        storage: storage,
        tokenKeys: tokenKeys,
        client: dio,
        refreshClient: _refreshClient,
        refreshPath: tokenKeys == TokenKeys.admin
            ? 'admin/auth/refresh'
            : 'auth/refresh',
        onSessionExpired: () => onSessionExpired?.call(),
      ),
    );
  }

  final Dio dio;
  late final Dio _refreshClient;

  /// Set once at bootstrap so the interceptor can bounce the app to login on
  /// an unrecoverable 401 without core depending on the auth feature.
  VoidCallback? onSessionExpired;
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    storage: ref.watch(secureStorageProvider),
    appVersion: ref.watch(appVersionProvider),
  );
});
