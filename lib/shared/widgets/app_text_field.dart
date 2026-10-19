import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Branded text field with a floating label above, validation styling and
/// an optional built-in password visibility toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.toggleObscure = false,
    this.onFieldSubmitted,
    this.onChanged,
    this.autofillHints,
    this.maxLines = 1,
    this.enabled = true,
    this.errorText,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool toggleObscure;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final int maxLines;
  final bool enabled;
  final String? errorText;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final showToggle = widget.toggleObscure && widget.obscureText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText && _obscured,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          autofillHints: widget.autofillHints,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: widget.errorText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 20),
            suffixIcon: showToggle
                ? IconButton(
                    icon: Icon(
                      _obscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _obscured = !_obscured),
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}
