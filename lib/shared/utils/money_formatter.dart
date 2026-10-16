import 'package:intl/intl.dart';

/// Money helpers implementing FLUTTER_API_GUIDE §5 exactly.
///
///   * `*_cents` ints → divide by 100 → `$X.XX` (USD).
///   * `*_usd` DECIMAL strings (`"84.00"`) → shown verbatim / parsed for
///     display only. Never do arithmetic to derive prices.
///   * `price_display` → already formatted by the server; show as-is.
///   * crypto amounts (strings) → show verbatim next to the asset symbol.
///   * `usd_pkr_rate` number → thousands separators, no decimals.
class MoneyFormatter {
  MoneyFormatter._();

  static final NumberFormat _usd = NumberFormat.currency(
    symbol: r'$',
    decimalDigits: 2,
  );

  static final NumberFormat _usdPkr = NumberFormat.decimalPattern();

  /// `350` → `$3.50`.
  static String fromCents(int cents) => _usd.format(cents / 100);

  /// Nullable cents: returns [placeholder] when null.
  static String fromCentsOr(int? cents, {String placeholder = '—'}) =>
      cents == null ? placeholder : fromCents(cents);

  /// `"84.00"` → `"$84.00"`. Passes the string through parsing for display
  /// only (no arithmetic). Returns [placeholder] on null/parse failure.
  static String usdString(String? value, {String placeholder = '—'}) {
    if (value == null || value.isEmpty) return placeholder;
    final parsed = double.tryParse(value);
    if (parsed == null) return value; // show verbatim if not numeric
    return _usd.format(parsed);
  }

  /// `price_display` / server-formatted strings — shown verbatim.
  static String raw(String? value, {String placeholder = '—'}) =>
      (value == null || value.isEmpty) ? placeholder : value;

  /// `83280.01` → `"83,280"` (no decimals).
  static String usdPkrRate(num? rate, {String placeholder = '—'}) {
    if (rate == null) return placeholder;
    return _usdPkr.format(rate.round());
  }

  /// Crypto amount string + symbol, e.g. `"8.442150 TRC20"` → shown verbatim.
  static String crypto(String? amount, String? symbol) {
    if (amount == null || amount.isEmpty) return '—';
    return symbol == null || symbol.isEmpty ? amount : '$amount $symbol';
  }
}
