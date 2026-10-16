import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/shared/utils/idempotency_key.dart';

/// Idempotency-Key contract (FLUTTER_API_GUIDE §1).
void main() {
  group('IdempotencyKey', () {
    test('generated keys are valid', () {
      final key = IdempotencyKey.generate();
      expect(IdempotencyKey.isValid(key), isTrue);
    });

    test('generated keys respect the 8–80 char bound', () {
      for (var i = 0; i < 20; i++) {
        final key = IdempotencyKey.generate();
        expect(key.length, inInclusiveRange(8, 80));
      }
    });

    test('generated keys are unique', () {
      final keys = List.generate(50, (_) => IdempotencyKey.generate()).toSet();
      expect(keys.length, 50);
    });

    test('isValid rejects bad keys', () {
      expect(IdempotencyKey.isValid('short'), isFalse);
      expect(IdempotencyKey.isValid('has space in it 123456'), isFalse);
      expect(IdempotencyKey.isValid('bad/char/path.1234567890'), isFalse);
      expect(IdempotencyKey.isValid('a' * 81), isFalse);
    });
  });
}
