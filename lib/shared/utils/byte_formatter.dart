/// Byte-size → human display. The usage endpoint reports raw bytes; the UI
/// shows GB (1 GiB = 1024^3) — display only, never used for arithmetic.
class ByteFormatter {
  ByteFormatter._();

  static const int _gib = 1024 * 1024 * 1024;

  static double gbValue(int? bytes) => bytes == null ? 0 : bytes / _gib;

  static String toGb(int? bytes, {String placeholder = '—', int decimals = 2}) {
    if (bytes == null) return placeholder;
    return '${gbValue(bytes).toStringAsFixed(decimals)} GB';
  }
}
