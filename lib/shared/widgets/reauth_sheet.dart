import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/api/api_error.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../features/auth/data/auth_repository.dart';
import 'app_button.dart';
import 'app_text_field.dart';

/// Password bottom-sheet that mints a single-use re-auth grant (§3).
///
/// Returns the grant string on success, or null when dismissed.
/// The grant is NEVER stored — the caller uses it for exactly one call and
/// discards it.
///
/// Restyled with the brand theme. Copy strings are contract — the widget
/// test asserts 'Confirm', 'Password is required.' and 'Invalid password.'.
Future<String?> showReauthSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const ReauthSheet(),
  );
}

class ReauthSheet extends ConsumerStatefulWidget {
  const ReauthSheet({super.key});

  @override
  ConsumerState<ReauthSheet> createState() => _ReauthSheetState();
}

class _ReauthSheetState extends ConsumerState<ReauthSheet> {
  final _passwordController = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final password = _passwordController.text;
    if (password.isEmpty) {
      setState(() => _error = 'Password is required.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final grant = await ref.read(authRepositoryProvider).reauth(password);
      if (!mounted) return;
      Navigator.of(context).pop(grant);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        // 403 FORBIDDEN = wrong password (§3).
        _error = e.code == 'FORBIDDEN' ? 'Invalid password.' : e.userMessage;
        _submitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.lg,
        bottom: AppSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: AppColors.brandGradient,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(Icons.lock_outline,
                    size: 22, color: AppColors.onAccent),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Expanded(
                child: Text(
                  'Confirm your password',
                  style: AppTypography.title,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: _submitting
                    ? null
                    : () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'This action needs a recent password confirmation. Your grant is used once and never stored.',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter your account password',
            prefixIcon: Icons.password_outlined,
            obscureText: true,
            toggleObscure: true,
            errorText: _error,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submitting ? null : _submit(),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Confirm',
            loading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
