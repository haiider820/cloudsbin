import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Audience-scoped secure-storage key names.
///
/// Tokens for the user app and the admin app live under separate keys so a
/// single install can hold both audiences without cross-contamination.
class TokenKeys {
  const TokenKeys({required this.access, required this.refresh});

  final String access;
  final String refresh;

  static const TokenKeys user = TokenKeys(
    access: 'access_token',
    refresh: 'refresh_token',
  );

  static const TokenKeys admin = TokenKeys(
    access: 'admin_access_token',
    refresh: 'admin_refresh_token',
  );
}

/// Wrapper around [FlutterSecureStorage].
///
/// Security rules (see FLUTTER_API_GUIDE §2–3):
///   * Tokens live ONLY here — never SharedPreferences / memory singletons.
///   * Never log token values.
///   * Re-auth grants are never stored (single-call use only).
class SecureStorage {
  SecureStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const String _deviceIdKey = 'device_id';

  Future<String?> readAccessToken(TokenKeys keys) => _storage.read(key: keys.access);

  Future<String?> readRefreshToken(TokenKeys keys) => _storage.read(key: keys.refresh);

  Future<void> writeTokens(
    TokenKeys keys, {
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: keys.access, value: accessToken);
    await _storage.write(key: keys.refresh, value: refreshToken);
  }

  Future<void> clearTokens(TokenKeys keys) async {
    await _storage.delete(key: keys.access);
    await _storage.delete(key: keys.refresh);
  }

  /// Returns the stable per-install device UUID, generating + persisting one
  /// on first call. Matches `device.id` (stable install UUID) in §2.2.
  Future<String> getOrCreateDeviceId() async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final created = const Uuid().v4();
    await _storage.write(key: _deviceIdKey, value: created);
    return created;
  }
}

final secureStorageProvider = Provider<SecureStorage>(
  (ref) => SecureStorage(const FlutterSecureStorage()),
);
