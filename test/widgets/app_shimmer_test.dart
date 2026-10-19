import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/shared/widgets/app_state_widgets.dart';

void main() {
  group('AppShimmer', () {
    testWidgets('clamps to fit a short bounded slot (overflow regression)',
        (tester) async {
      // 5 x (92 + 12) = 520px requested in a 415px slot previously overflowed
      // by 105px (RenderFlex bottom overflow seen on device).
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 415,
              child: AppShimmer(itemCount: 5, itemHeight: 92),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(AppShimmer)).height,
          lessThanOrEqualTo(415));
      await tester.pump(const Duration(milliseconds: 300));
    });

    testWidgets('renders the requested item count when unconstrained',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [AppShimmer(itemCount: 3, itemHeight: 40)],
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      // Three 40px placeholders plus their 12px gaps.
      expect(tester.getSize(find.byType(AppShimmer)).height, 3 * 40 + 3 * 12);
      await tester.pump(const Duration(milliseconds: 300));
    });
  });
}
