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
import '../../../shared/widgets/hero_header.dart';
import '../data/auth_repository.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _acceptTerms = false;
  bool _submitting = false;
  String? _formError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _formError = null);
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (!_acceptTerms) {
      setState(() => _formError = 'You must accept the terms to continue.');
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(authRepositoryProvider).register(
            fullName: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            passwordConfirm: _confirmController.text,
            acceptTerms: _acceptTerms,
          );
      if (!mounted) return;
      context.go(
        Routes.emailVerificationSentPath(_emailController.text.trim()),
      );
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _formError = e.userMessage);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Create account')),
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
                    const Center(
                          child: BrandMark(size: 68),
                        )
                        .animate()
                        .fadeIn(duration: 350.ms)
                        .slideY(begin: 0.15, end: 0, duration: 350.ms),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Create your account',
                      textAlign: TextAlign.center,
                      style: AppTypography.headline,
                    )
                        .animate()
                        .fadeIn(delay: 80.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Spin up servers in minutes',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySecondary,
                    )
                        .animate()
                        .fadeIn(delay: 140.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.xl),
                    if (_formError != null) ...[
                      _ErrorBanner(message: _formError!)
                          .animate()
                          .fadeIn(duration: 250.ms),
                      const SizedBox(height: AppSpacing.md),
                    ],
                    AppTextField(
                      controller: _nameController,
                      label: 'Full name',
                      hint: 'Ada Lovelace',
                      prefixIcon: Icons.person_outline,
                      textInputAction: TextInputAction.next,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Full name is required'
                          : null,
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, duration: 300.ms),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'you@example.com',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return 'Email is required';
                        if (!value.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: 240.ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, duration: 300.ms),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'At least 8 characters',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      toggleObscure: true,
                      textInputAction: TextInputAction.next,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        if (v.length < 8) {
                          return 'Must be at least 8 characters';
                        }
                        return null;
                      },
                    )
                        .animate()
                        .fadeIn(delay: 280.ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, duration: 300.ms),
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
                    )
                        .animate()
                        .fadeIn(delay: 320.ms, duration: 300.ms)
                        .slideY(begin: 0.08, end: 0, duration: 300.ms),
                    const SizedBox(height: AppSpacing.sm),
                    _TermsRow(
                      value: _acceptTerms,
                      onChanged: (v) =>
                          setState(() => _acceptTerms = v ?? false),
                    ).animate().fadeIn(delay: 360.ms, duration: 300.ms),
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Create account',
                      loading: _submitting,
                      onPressed: _submit,
                      icon: Icons.person_add_outlined,
                    ).animate().fadeIn(delay: 400.ms, duration: 300.ms),
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
                    ).animate().fadeIn(delay: 440.ms, duration: 300.ms),
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

class _TermsRow extends StatelessWidget {
  const _TermsRow({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.accent,
              checkColor: AppColors.onAccent,
              side: const BorderSide(color: AppColors.textMuted, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Expanded(
              child: Text(
                'I accept the Terms of Service',
                style: AppTypography.bodySecondary,
              ),
            ),
          ],
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
