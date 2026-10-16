import 'package:flutter/material.dart';

/// Filled button that swaps its child for a spinner while [loading] is true
/// and blocks taps in that state.
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.loading = false,
    this.icon,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool loading;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: loading ? null : onPressed,
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[icon!, const SizedBox(width: 8)],
                child,
              ],
            ),
    );
  }
}
