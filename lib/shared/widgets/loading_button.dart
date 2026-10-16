import 'package:flutter/material.dart';

import 'app_button.dart';

/// Filled button that swaps its child for a spinner while [loading] is true
/// and blocks taps in that state.
///
/// API preserved — now rendered through the branded [AppButton].
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
    final label = child is Text ? (child as Text).data ?? '' : '';
    return AppButton(
      label: label.isEmpty ? 'Continue' : label,
      onPressed: onPressed,
      loading: loading,
      icon: icon is Icon ? (icon as Icon).icon : null,
    );
  }
}
