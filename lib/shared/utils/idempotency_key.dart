import 'package:uuid/uuid.dart';

/// Idempotency-Key generation (FLUTTER_API_GUIDE §1).
///
///   * 8–80 chars, charset `[A-Za-z0-9._:-]`.
///   * uuid7-based, trimmed to 36 chars, lowercase — safe chars only.
///   * Generated once per logical operation and reused on retry; never
///     logged or cached beyond the operation.
class IdempotencyKey {
  IdempotencyKey._();

  static const Uuid _uuid = Uuid();

  static final RegExp _allowed = RegExp(r'^[A-Za-z0-9._:-]{8,80}$');

  /// Returns a fresh, valid key. UUIDv7 is time-ordered which aids server-side
  /// ordering, and its 36-char form fits the 8–80 bound exactly.
  static String generate() {
    final key = _uuid.v7().toLowerCase();
    return key.length > 80 ? key.substring(0, 80) : key;
  }

  /// True when [key] satisfies the API's format rules.
  static bool isValid(String key) => _allowed.hasMatch(key);
}
