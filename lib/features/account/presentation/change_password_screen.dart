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
import '../../../shared/widgets/error_snackbar.dart';
import '../../auth/data/auth_repository.dart';

/// Self-service password change — `POST /auth/password-change`.
///
/// Requires the current password; the backend rejects a wrong one with
/// 403 `FORBIDDEN`. On success the screen pops back to the profile.
class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _submitting = false;
  String? _formError;
  String? _currentError;
  String? _newError;
  String? _confirmError;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _formError = null;
      _currentError = null;
      _newError = null;
      _confirmError = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).changePassword(
            currentPassword: _currentController.text,
            password: _newController.text,
            passwordConfirm: _confirmController.text,
          );
      if (!mounted) return;
      showInfoSnackBar(context, 'Password changed successfully.');
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(Routes.profile);
      }
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        switch (e.code) {
          case 'FORBIDDEN':
            _currentError = 'Current password is incorrect.';
          case 'RATE_LIMITED':
            final n = e.retryAfterSeconds;
            _formError = n != null
                ? 'Too many attempts. Wait ${n}s.'
                : 'Too many attempts. Please try again later.';
          case 'VALIDATION_FAILED':
            final msg = e.message.toLowerCase();
            if (msg.contains('current')) {
              _currentError = e.message;
            } else if (msg.contains('confirm')) {
              _confirmError = e.message;
            } else if (msg.contains('password')) {
              _newError = e.message;
            } else {
              _formError = e.message;
            }
          default:
            _formError = e.userMessage;
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _formError = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Change password')),
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
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
                      'Update your password',
                      textAlign: TextAlign.center,
                      style: AppTypography.headline,
                    ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Confirm your current password, then choose a new one.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySecondary,
                    ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xl),
                    if (_formError != null) ...[
                      _ErrorBanner(message: _formError!)
                          .animate()
                          .fadeIn(duration: 250.ms),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    AppTextField(
                      controller: _currentController,
                      label: 'Current password',
                      hint: 'Your current password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      toggleObscure: true,
                      textInputAction: TextInputAction.next,
                      errorText: _currentError,
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Current password is required'
                          : null,
                    ).animate().fadeIn(delay: 180.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _newController,
                      label: 'New password',
                      hint: 'At least 8 characters',
                      prefixIcon: Icons.lock_reset_outlined,
                      obscureText: true,
                      toggleObscure: true,
                      textInputAction: TextInputAction.next,
                      errorText: _newError,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'New password is required';
                        }
                        if (v.length < 8) {
                          return 'Must be at least 8 characters';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 220.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _confirmController,
                      label: 'Confirm new password',
                      hint: 'Repeat your new password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      toggleObscure: true,
                      textInputAction: TextInputAction.done,
                      errorText: _confirmError,
                      onFieldSubmitted: (_) => _submitting ? null : _submit(),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please confirm your new password';
                        }
                        if (v != _newController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 260.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Change Password',
                      icon: Icons.check_outlined,
                      loading: _submitting,
                      onPressed: _submitting ? null : _submit,
                    ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
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
