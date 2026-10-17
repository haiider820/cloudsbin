import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

/// Audience-scoped secure-storage key names.
///
/// Tokens for the user app and the admin app live under separate keys so a
/// single install can hold both audiences without cross-contamination.
class TokenKeys {
  const TokenKeys({
    required this.access,
    required this.refresh,
    required this.device,
  });

  final String access;
  final String refresh;

  /// Per-audience stable install UUID key, so an admin login never reuses
  /// the user app's `device_id` entry (and vice versa).
  final String device;

  static const TokenKeys user = TokenKeys(
    access: 'access_token',
    refresh: 'refresh_token',
    device: 'device_id',
  );

  static const TokenKeys admin = TokenKeys(
    access: 'admin_access_token',
    refresh: 'admin_refresh_token',
    device: 'admin_device_id',
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

  /// Returns the stable per-install device UUID for the given audience,
  /// generating + persisting one on first call. Matches `device.id` (stable
  /// install UUID) in §2.2. Defaults to the user audience's `device_id`.
  Future<String> getOrCreateDeviceId([TokenKeys keys = TokenKeys.user]) async {
    final existing = await _storage.read(key: keys.device);
    if (existing != null && existing.isNotEmpty) return existing;
    final created = const Uuid().v4();
    await _storage.write(key: keys.device, value: created);
    return created;
  }
}

final secureStorageProvider = Provider<SecureStorage>(
  (ref) => SecureStorage(const FlutterSecureStorage()),
);
