import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'app_button.dart';

/// Branded confirmation dialog. Returns true when the user confirms.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool danger = false,
  IconData icon = Icons.help_outline,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: (danger ? AppColors.danger : AppColors.accent)
              .withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 30,
          color: danger ? AppColors.danger : AppColors.accent,
        ),
      ),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTypography.bodySecondary,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: cancelLabel,
                variant: AppButtonVariant.secondary,
                dense: true,
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: confirmLabel,
                variant:
                    danger ? AppButtonVariant.danger : AppButtonVariant.primary,
                dense: true,
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Branded info dialog with a single dismiss action.
Future<void> infoDialog(
  BuildContext context, {
  required String title,
  required String message,
  String actionLabel = 'Got it',
  IconData icon = Icons.info_outline,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 30, color: AppColors.accent),
      ),
      title: Text(title, textAlign: TextAlign.center),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTypography.bodySecondary,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppButton(
          label: actionLabel,
          dense: true,
          fullWidth: false,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    ),
  );
}
