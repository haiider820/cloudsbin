import 'package:intl/intl.dart';

/// Date helpers implementing the two formats in FLUTTER_API_GUIDE §5.
///
///   * Everywhere except crypto: ISO-8601 UTC `2026-10-16T10:19:07Z` —
///     parse with [DateTime.parse], display in local time.
///   * Crypto only: `2026-10-16 15:04:10` (no `Z`, no `T`, no timezone) —
///     parse with [parseDbUtc], assuming the value is UTC.
class DateFormatter {
  DateFormatter._();

  static final DateFormat _local = DateFormat('d MMM yyyy, HH:mm');
  static final DateFormat _localSeconds = DateFormat('d MMM yyyy, HH:mm:ss');

  /// ISO-8601 (`...Z` or with offset). Returns null on failure.
  static DateTime? parseIsoUtc(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final parsed = DateTime.tryParse(raw);
    return parsed?.toUtc();
  }

  /// Crypto `Y-m-d H:i:s` (no timezone → assumed UTC). Returns null on failure.
  static DateTime? parseDbUtc(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    final normalised = raw.contains('T') ? raw : raw.replaceFirst(' ', 'T');
    final parsed = DateTime.tryParse(normalised);
    if (parsed == null) return null;
    // `Y-m-d H:i:s` carries no zone; DateTime.tryParse treats it as local,
    // so re-attach UTC explicitly.
    return raw.endsWith('Z') ? parsed.toUtc() : DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
      parsed.hour,
      parsed.minute,
      parsed.second,
    );
  }

  /// ISO-8601 → local display.
  static String isoToLocal(String? raw, {String placeholder = '—'}) {
    final dt = parseIsoUtc(raw);
    if (dt == null) return placeholder;
    return _local.format(dt.toLocal());
  }

  /// Crypto `Y-m-d H:i:s` → local display.
  static String dbToLocal(String? raw, {String placeholder = '—'}) {
    final dt = parseDbUtc(raw);
    if (dt == null) return placeholder;
    return _local.format(dt.toLocal());
  }

  /// `1799` seconds → `"29:59"` / `"1:02:03"`.
  static String countdown(int totalSeconds) {
    final seconds = totalSeconds < 0 ? 0 : totalSeconds;
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final mm = m.toString().padLeft(2, '0');
    final ss = s.toString().padLeft(2, '0');
    return h > 0 ? '$h:$mm:$ss' : '$mm:$ss';
  }

  /// Seconds until [utc] from now; negative when past.
  static int secondsUntil(DateTime? utc) {
    if (utc == null) return 0;
    return utc.difference(DateTime.now().toUtc()).inSeconds;
  }

  /// Full local timestamp including seconds (useful for setting/audit rows).
  static String isoToLocalFull(String? raw, {String placeholder = '—'}) {
    final dt = parseIsoUtc(raw);
    if (dt == null) return placeholder;
    return _localSeconds.format(dt.toLocal());
  }
}
