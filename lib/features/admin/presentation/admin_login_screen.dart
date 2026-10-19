import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';

/// Admin sign-in (§5.1) — its own entrance: purple admin identity, no
/// user-app chrome. Errors land inline with the spec's exact wording, and
/// the login carries the admin-audience device id.
class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitting = false;
  String? _formError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _platform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
      default:
        return 'android';
    }
  }

  Future<void> _submit() async {
    setState(() {
      _formError = null;
      _emailError = null;
      _passwordError = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      final storage = ref.read(secureStorageProvider);
      final deviceId = await storage.getOrCreateDeviceId(TokenKeys.admin);
      await ref.read(adminAuthRepositoryProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            deviceId: deviceId,
            platform: _platform,
            appVersion: ref.read(appVersionProvider),
          );
      if (!mounted) return;
      ref.read(adminSessionProvider.notifier).markAuthenticated(
            email: _emailController.text.trim(),
          );
      // The router redirect reacts to the session change.
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        if (e.statusCode == 401 || e.code == 'AUTH_REQUIRED') {
          _formError = 'Invalid email or password.';
        } else if (e.code == 'RATE_LIMITED') {
          final n = e.retryAfterSeconds;
          _formError = n != null
              ? 'Too many attempts. Try again in ${n}s.'
              : e.userMessage;
        } else if (e.code == 'VALIDATION_FAILED') {
          final msg = e.message.toLowerCase();
          if (msg.contains('email')) {
            _emailError = e.message;
          } else if (msg.contains('password')) {
            _passwordError = e.message;
          } else {
            _formError = e.message;
          }
        } else {
          _formError = e.message;
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() =>
          _formError = 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -70,
              right: -50,
              child: _Glow(color: AppColors.adminAccent, size: 220),
            ),
            const Positioned(
              top: 90,
              left: -70,
              child: _Glow(color: AppColors.adminAccent, size: 170),
            ),
            Center(
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
                        const Center(child: _ShieldIcon())
                            .animate()
                            .fadeIn(duration: 350.ms)
                            .slideY(begin: 0.15, end: 0, duration: 350.ms),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'Admin Portal',
                          textAlign: TextAlign.center,
                          style: AppTypography.display,
                        )
                            .animate()
                            .fadeIn(delay: 80.ms, duration: 300.ms),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'CloudsBin Administration',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodySecondary
                              .copyWith(color: AppColors.adminAccentLight),
                        )
                            .animate()
                            .fadeIn(delay: 140.ms, duration: 300.ms),
                        const SizedBox(height: AppSpacing.lg),
                        _RestrictedStripe()
                            .animate(delay: 160.ms)
                            .fadeIn(duration: 300.ms),
                        const SizedBox(height: AppSpacing.lg),
                        if (_formError != null) ...[
                          _ErrorBanner(message: _formError!)
                              .animate()
                              .fadeIn(duration: 250.ms),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        AppTextField(
                          controller: _emailController,
                          label: 'Admin email',
                          hint: 'admin@example.com',
                          prefixIcon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          textInputAction: TextInputAction.next,
                          errorText: _emailError,
                          validator: (value) {
                            final v = value?.trim() ?? '';
                            if (v.isEmpty) return 'Email is required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 300.ms)
                            .slideY(begin: 0.08, end: 0, duration: 300.ms),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Your admin password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          toggleObscure: true,
                          autofillHints: const [AutofillHints.password],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          errorText: _passwordError,
                          validator: (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Password is required'
                                  : null,
                        )
                            .animate()
                            .fadeIn(delay: 260.ms, duration: 300.ms)
                            .slideY(begin: 0.08, end: 0, duration: 300.ms),
                        const SizedBox(height: AppSpacing.lg),
                        AppButton(
                          label: 'Sign In to Admin',
                          icon: Icons.admin_panel_settings_outlined,
                          color: AppColors.adminAccent,
                          loading: _submitting,
                          onPressed: _submit,
                        )
                            .animate()
                            .fadeIn(delay: 320.ms, duration: 300.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShieldIcon extends StatelessWidget {
  const _ShieldIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 84,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.adminAccent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.adminAccent.withValues(alpha: 0.45),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(
        Icons.admin_panel_settings_outlined,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}

class _RestrictedStripe extends StatelessWidget {
  const _RestrictedStripe();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.adminAccent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.adminAccent.withValues(alpha: 0.45),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock_outline,
            size: 18,
            color: AppColors.adminAccentLight,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Restricted area — administrator credentials only. '
              'Stored separately from the user app.',
              style: AppTypography.caption.copyWith(
                color: AppColors.adminAccentLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.35), Colors.transparent],
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
