import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/hero_header.dart';
import '../data/auth_repository.dart';
import '../data/auth_session.dart';
import '../../admin/data/admin_auth_repository.dart';
import '../../account/data/account_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
      final deviceId = await storage.getOrCreateDeviceId();
      final response = await ref.read(authRepositoryProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            deviceId: deviceId,
            platform: _platform,
            appVersion: ref.read(appVersionProvider),
          );
      if (!mounted) return;

      // Resolve the role (the login response may omit `user`; fall back to
      // /me). Admins must never land in the user app as an "admin user".
      String role = response.user?.role ?? '';
      if (role.isEmpty) {
        try {
          final me = await ref.read(accountRepositoryProvider).me();
          role = me.role;
        } catch (_) {
          role = 'user';
        }
      }

      final email = response.user?.email ?? _emailController.text.trim();

      if (role == 'admin') {
        // Upgrade to the admin audience: drop any user-audience tokens so
        // the admin is not also signed in as a "user", then mint admin
        // tokens and route to the admin portal.
        final adminDeviceId =
            await storage.getOrCreateDeviceId(TokenKeys.admin);
        try {
          await ref.read(adminAuthRepositoryProvider).login(
                email: _emailController.text.trim(),
                password: _passwordController.text,
                deviceId: adminDeviceId,
                platform: _platform,
                appVersion: ref.read(appVersionProvider),
              );
        } on ApiError catch (e) {
          if (!mounted) return;
          setState(() {
            if (e.code == 'AUTH_REQUIRED') {
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
              _formError = e.userMessage;
            }
          });
          return;
        }
        await storage.clearTokens(TokenKeys.user);
        await ref.read(sessionProvider.notifier).logoutLocal();
        if (!mounted) return;
        ref.read(adminSessionProvider.notifier).markAuthenticated(email: email);
        context.go(Routes.adminDashboard);
        return;
      }

      ref.read(sessionProvider.notifier).markAuthenticated(email: email);
      // The router redirect reacts to the session change.
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        if (e.code == 'AUTH_REQUIRED') {
          _formError = e.message;
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
          _formError = e.userMessage;
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
            // Ambient glow.
            const Positioned(
              top: -70,
              right: -50,
              child: _Glow(color: AppColors.glowCyan, size: 220),
            ),
            const Positioned(
              top: 60,
              left: -70,
              child: _Glow(color: AppColors.glowViolet, size: 180),
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
                        const Center(
                              child: BrandMark(size: 84),
                            )
                            .animate()
                            .fadeIn(duration: 350.ms)
                            .slideY(begin: 0.15, end: 0, duration: 350.ms),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          'Welcome back',
                          textAlign: TextAlign.center,
                          style: AppTypography.display,
                        )
                            .animate()
                            .fadeIn(delay: 80.ms, duration: 300.ms),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Sign in to manage your servers',
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
                          controller: _emailController,
                          label: 'Email',
                          hint: 'you@example.com',
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
                          hint: 'Your password',
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
                          label: 'Sign in',
                          loading: _submitting,
                          onPressed: _submit,
                          icon: Icons.login_outlined,
                        )
                            .animate()
                            .fadeIn(delay: 320.ms, duration: 300.ms),
                        const SizedBox(height: AppSpacing.xs),
                        Align(
                          alignment: Alignment.center,
                          child: AppButton(
                            label: 'Forgot password?',
                            variant: AppButtonVariant.ghost,
                            fullWidth: false,
                            onPressed: _submitting
                                ? null
                                : () => context.go(Routes.forgotPassword),
                          ),
                        ).animate().fadeIn(delay: 380.ms, duration: 300.ms),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppTypography.bodySecondary,
                            ),
                            AppButton(
                              label: 'Sign up',
                              variant: AppButtonVariant.ghost,
                              fullWidth: false,
                              dense: true,
                              onPressed: _submitting
                                  ? null
                                  : () => context.go(Routes.register),
                            ),
                          ],
                        ).animate().fadeIn(delay: 440.ms, duration: 300.ms),
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
          colors: [color, Colors.transparent],
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
