import 'package:flutter/material.dart';

import '../../core/api/api_error.dart';
import '../../core/theme/app_colors.dart';

/// Global transient-error display via [ScaffoldMessenger].
///
/// Never shows raw Dart errors — every object is normalised through
/// [ApiError.userMessage].
void showErrorSnackBar(BuildContext context, Object error) {
  final message = error is ApiError ? error.userMessage : error.toString();
  _show(context, message, isError: true);
}

void showInfoSnackBar(BuildContext context, String message) {
  _show(context, message, isError: false);
}

void _show(BuildContext context, String message, {required bool isError}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              size: 20,
              color: isError ? AppColors.danger : AppColors.success,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError ? AppColors.dangerBg : AppColors.bg3,
      ),
    );
}
