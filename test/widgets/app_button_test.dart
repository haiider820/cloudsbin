import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/shared/widgets/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('ghost button lays out inside a Row (infinite-width regression)',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                AppButton(
                  label: 'Sign up',
                  variant: AppButtonVariant.ghost,
                  fullWidth: false,
                  dense: true,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Sign up'), findsOneWidget);
    });

    testWidgets('full-width button spans its bounded parent', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton(label: 'Sign in', onPressed: () {}),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      final size = tester
          .getSize(find.widgetWithText(FilledButton, 'Sign in'));
      // Default test surface is 800 wide minus the 16px padding on both sides.
      expect(size.width, greaterThan(700));
      expect(size.height, greaterThanOrEqualTo(54));
    });

    testWidgets('variants map to the expected Material buttons',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppButton(label: 'Primary', onPressed: () {}),
                AppButton(
                  label: 'Secondary',
                  variant: AppButtonVariant.secondary,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Danger',
                  variant: AppButtonVariant.danger,
                  onPressed: () {},
                ),
                AppButton(
                  label: 'Ghost',
                  variant: AppButtonVariant.ghost,
                  fullWidth: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.widgetWithText(FilledButton, 'Primary'), findsOneWidget);
      expect(find.widgetWithText(OutlinedButton, 'Secondary'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Danger'), findsOneWidget);
      expect(find.widgetWithText(TextButton, 'Ghost'), findsOneWidget);
    });

    testWidgets('loading disables the button and shows a spinner',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(label: 'Sign in', loading: true, onPressed: () {}),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });
  });
}
