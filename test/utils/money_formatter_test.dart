import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/shared/utils/money_formatter.dart';

/// Money formatter contract (FLUTTER_API_GUIDE §5).
void main() {
  group('MoneyFormatter', () {
    test('fromCents divides by 100 and formats USD', () {
      expect(MoneyFormatter.fromCents(575), r'$5.75');
      expect(MoneyFormatter.fromCents(0), r'$0.00');
      expect(MoneyFormatter.fromCents(100000), r'$1,000.00');
    });

    test('fromCentsOr returns placeholder on null', () {
      expect(MoneyFormatter.fromCentsOr(null), '—');
      expect(MoneyFormatter.fromCentsOr(99), r'$0.99');
    });

    test('usdString shows DECIMAL strings verbatim', () {
      expect(MoneyFormatter.usdString('84.00'), r'$84.00');
      expect(MoneyFormatter.usdString('0.00'), r'$0.00');
      expect(MoneyFormatter.usdString(null), '—');
      expect(MoneyFormatter.usdString(''), '—');
    });

    test('crypto amounts are shown verbatim with the symbol', () {
      expect(MoneyFormatter.crypto('0.00008621', 'BTC'), '0.00008621 BTC');
      expect(MoneyFormatter.crypto('8.442150', null), '8.442150');
      expect(MoneyFormatter.crypto(null, 'BTC'), '—');
    });

    test('usdPkrRate renders whole units with thousands separators', () {
      expect(MoneyFormatter.usdPkrRate(83280.01), '83,280');
      expect(MoneyFormatter.usdPkrRate(null), '—');
    });
  });
}
