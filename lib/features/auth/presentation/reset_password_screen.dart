import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../data/auth_repository.dart';

/// Deep-link landing screen for `.../reset-password?token=...`.
///
/// Collects a new password and consumes the single-use reset token. Expired,
/// used or invalid tokens swap the form for a terminal message pointing back
/// at "forgot password".
class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _submitting = false;
  bool _done = false;
  String? _error;
  String? _terminalMessage;

  Timer? _navigateTimer;

  @override
  void dispose() {
    _navigateTimer?.cancel();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _error = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).resetPassword(
            token: widget.token,
            password: _passwordController.text,
            passwordConfirm: _confirmController.text,
          );
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _done = true;
      });
      _navigateTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) context.go(Routes.login);
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        switch (e.code) {
          case 'TOKEN_EXPIRED':
            _terminalMessage = 'This reset link has expired.';
          case 'TOKEN_USED':
            _terminalMessage = 'This reset link has already been used.';
          case 'TOKEN_INVALID':
            _terminalMessage = 'Invalid reset link.';
          default:
            _error = e.userMessage;
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _error = 'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Reset password')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.xl,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: _content(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    if (_terminalMessage != null) {
      return _Terminal(
        message: _terminalMessage!,
        onRequestNew: () => context.go(Routes.forgotPassword),
      );
    }
    if (_done) {
      return _Terminal(
        icon: Icons.check_circle_outline,
        iconColor: AppColors.success,
        message: 'Password reset! You can now sign in.',
        buttonLabel: 'Go to Login',
        onRequestNew: () => context.go(Routes.login),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: const Icon(
                Icons.lock_reset_outlined,
                size: 34,
                color: AppColors.accent,
              ),
            ),
          ).animate().fadeIn(duration: 350.ms),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Set new password',
            textAlign: TextAlign.center,
            style: AppTypography.headline,
          ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Choose a strong password you have not used before.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySecondary,
          ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
          const SizedBox(height: AppSpacing.xl),
          if (_error != null) ...[
            _ErrorBanner(message: _error!)
                .animate()
                .fadeIn(duration: 250.ms),
            const SizedBox(height: AppSpacing.md),
          ],
          AppTextField(
            controller: _passwordController,
            label: 'New password',
            hint: 'At least 8 characters',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            toggleObscure: true,
            textInputAction: TextInputAction.next,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Password is required';
              if (v.length < 8) return 'Must be at least 8 characters';
              return null;
            },
          ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _confirmController,
            label: 'Confirm password',
            hint: 'Repeat your password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            toggleObscure: true,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submit(),
            validator: (v) {
              if (v == null || v.isEmpty) {
                return 'Please confirm your password';
              }
              if (v != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ).animate().fadeIn(delay: 240.ms, duration: 300.ms),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Reset Password',
            loading: _submitting,
            onPressed: _submit,
            icon: Icons.lock_reset_outlined,
          ).animate().fadeIn(delay: 280.ms, duration: 300.ms),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.center,
            child: AppButton(
              label: 'Back to Login',
              variant: AppButtonVariant.ghost,
              fullWidth: false,
              onPressed:
                  _submitting ? null : () => context.go(Routes.login),
            ),
          ).animate().fadeIn(delay: 320.ms, duration: 300.ms),
        ],
      ),
    );
  }
}

class _Terminal extends StatelessWidget {
  const _Terminal({
    required this.message,
    required this.onRequestNew,
    this.icon = Icons.link_off_outlined,
    this.iconColor = AppColors.danger,
    this.buttonLabel = 'Request a new link',
  });

  final String message;
  final VoidCallback onRequestNew;
  final IconData icon;
  final Color iconColor;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 46, color: iconColor),
          ),
        ).animate().fadeIn(duration: 300.ms),
        const SizedBox(height: AppSpacing.lg),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.headline,
        ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: buttonLabel,
          onPressed: onRequestNew,
        ).animate().fadeIn(delay: 160.ms, duration: 300.ms),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.dangerBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.dangerFg, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.bodySecondary
                  .copyWith(color: AppColors.dangerFg),
            ),
          ),
        ],
      ),
    );
  }
}
