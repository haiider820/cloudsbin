import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/shared/utils/date_formatter.dart';

/// Date formatter contract (FLUTTER_API_GUIDE §5).
void main() {
  group('DateFormatter', () {
    test('parseIsoUtc handles ISO-8601 UTC', () {
      final parsed = DateFormatter.parseIsoUtc('2026-10-16T10:19:07Z');
      expect(parsed, DateTime.utc(2026, 10, 16, 10, 19, 7));
    });

    test('parseIsoUtc returns null on bad input', () {
      expect(DateFormatter.parseIsoUtc(null), isNull);
      expect(DateFormatter.parseIsoUtc('not-a-date'), isNull);
    });

    test('parseDbUtc treats Y-m-d H:i:s as UTC', () {
      final parsed = DateFormatter.parseDbUtc('2026-10-16 15:04:10');
      expect(parsed, DateTime.utc(2026, 10, 16, 15, 4, 10));
    });

    test('parseDbUtc returns null on bad input', () {
      expect(DateFormatter.parseDbUtc(null), isNull);
      expect(DateFormatter.parseDbUtc('garbage'), isNull);
    });

    test('countdown formats mm:ss and h:mm:ss', () {
      expect(DateFormatter.countdown(1799), '29:59');
      expect(DateFormatter.countdown(60), '01:00');
      expect(DateFormatter.countdown(3723), '1:02:03');
      expect(DateFormatter.countdown(0), '00:00');
      expect(DateFormatter.countdown(-5), '00:00');
    });

    test('isoToLocal returns placeholder on failure', () {
      expect(DateFormatter.isoToLocal(null), '—');
      expect(DateFormatter.dbToLocal('bad'), '—');
    });
  });
}
