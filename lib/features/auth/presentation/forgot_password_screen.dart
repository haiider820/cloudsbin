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
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../data/auth_repository.dart';

/// Password recovery — **stub**.
///
/// The v1 API has no reset endpoint: `POST auth/password-forgot` always
/// answers a neutral 202 and sends no mail (§2.8). The screen shows that
/// neutral message and nothing else.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _submitting = false;
  String? _message;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _message = null;
      _error = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .forgotPassword(_emailController.text.trim());
      if (!mounted) return;
      // Neutral copy: never reveals whether the address is registered.
      setState(() => _message = 'If that email is registered, you\'ll receive '
          'a password reset link shortly. Check your inbox and spam folder.');
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e.userMessage);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Forgot password')),
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
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color:
                            AppColors.accent.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(AppRadius.lg),
                      ),
                      child: const Icon(
                        Icons.mark_email_read_outlined,
                        size: 34,
                        color: AppColors.accent,
                      ),
                    )
                        .animate()
                        .fadeIn(duration: 350.ms)
                        .slideY(begin: 0.15, end: 0, duration: 350.ms),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Reset your password',
                      textAlign: TextAlign.center,
                      style: AppTypography.headline,
                    ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xs),
                    // NOTE: stub — no actual email is sent (no reset endpoint
                    // exists in v1; the API always returns a neutral 202).
                    Text(
                      'Enter your email and we will send reset instructions if '
                      'the address is registered.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySecondary,
                    ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xl),
                    if (_error != null) ...[
                      _MessageBanner(
                        message: _error!,
                        icon: Icons.error_outline,
                        background: AppColors.dangerBg,
                        foreground: AppColors.dangerFg,
                        border: AppColors.danger.withValues(alpha: 0.35),
                      ).animate().fadeIn(duration: 250.ms),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    if (_message != null) ...[
                      AppCard(
                        gradientBorder: true,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: AppColors.success,
                              size: 22,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                _message!,
                                style: AppTypography.bodySecondary.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 250.ms),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Email is required';
                        if (!value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, duration: 300.ms),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Send reset instructions',
                      loading: _submitting,
                      onPressed: _submit,
                      icon: Icons.send_outlined,
                    ).animate().fadeIn(delay: 260.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xs),
                    Align(
                      alignment: Alignment.center,
                      child: AppButton(
                        label: 'Back to sign in',
                        variant: AppButtonVariant.ghost,
                        fullWidth: false,
                        onPressed:
                            _submitting ? null : () => context.go(Routes.login),
                      ),
                    ).animate().fadeIn(delay: 320.ms, duration: 300.ms),
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

class _MessageBanner extends StatelessWidget {
  const _MessageBanner({
    required this.message,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.border,
  });

  final String message;
  final IconData icon;
  final Color background;
  final Color foreground;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, color: foreground, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style:
                  AppTypography.bodySecondary.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
