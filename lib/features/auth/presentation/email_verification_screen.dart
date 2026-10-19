import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/demo/demo_mode.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/auth_repository.dart';

/// "Check your email" screen shown right after a successful registration.
///
/// The user leaves the app, taps the verification link in their inbox, and the
/// deep link opens [VerifyEmailScreen] (see the app-level deep-link handler).
/// This screen never polls and never reveals whether the address exists.
class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  static const int _cooldownSeconds = 60;

  Timer? _cooldownTimer;
  int _secondsLeft = 0;
  bool _sending = false;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    setState(() => _secondsLeft = _cooldownSeconds);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) timer.cancel();
    });
  }

  Future<void> _resend() async {
    if (_sending || _secondsLeft > 0) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .resendVerificationEmail(widget.email);
      if (!mounted) return;
      // Neutral confirmation regardless of the backend outcome.
      showInfoSnackBar(context, 'Email sent');
      _startCooldown();
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _openEmailApp() async {
    final uri = Uri(scheme: 'mailto');
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened && mounted) {
        showErrorMessageSnackBar(
          context,
          'No email app found on this device.',
        );
      }
    } catch (_) {
      if (mounted) {
        showErrorMessageSnackBar(context, 'Could not open your email app.');
      }
    }
  }

  void _openDemoVerification() {
    context.push(Routes.verifyEmailPath('demo-verify-token'));
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email.isEmpty ? 'your email address' : widget.email;
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Verify your email')),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mark_email_unread_outlined,
                        size: 46,
                        color: AppColors.accent,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 350.ms)
                      .slideY(begin: 0.15, end: 0, duration: 350.ms),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Check your email',
                    textAlign: TextAlign.center,
                    style: AppTypography.headline,
                  ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'We sent a verification link to $email. Click the link in '
                    'the email to verify your account.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySecondary,
                  ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(
                    label: 'Open Email App',
                    icon: Icons.open_in_new,
                    onPressed: _openEmailApp,
                  ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
                  const SizedBox(height: AppSpacing.sm),
                  AppButton(
                    label: _secondsLeft > 0
                        ? 'Resend Email (${_secondsLeft}s)'
                        : 'Resend Email',
                    variant: AppButtonVariant.secondary,
                    icon: Icons.send_outlined,
                    loading: _sending,
                    onPressed:
                        (_sending || _secondsLeft > 0) ? null : _resend,
                  ).animate().fadeIn(delay: 240.ms, duration: 300.ms),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    "Didn't get it? Check your spam folder.",
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySecondary
                        .copyWith(color: AppColors.textMuted),
                  ).animate().fadeIn(delay: 280.ms, duration: 300.ms),
                  const SizedBox(height: AppSpacing.lg),
                  Align(
                    alignment: Alignment.center,
                    child: AppButton(
                      label: 'Back to Login',
                      variant: AppButtonVariant.ghost,
                      fullWidth: false,
                      onPressed: () => context.go(Routes.login),
                    ),
                  ).animate().fadeIn(delay: 320.ms, duration: 300.ms),
                  if (kDemoMode) ...[
                    const SizedBox(height: AppSpacing.lg),
                    AppButton(
                      label: 'Demo: Tap to simulate verification',
                      variant: AppButtonVariant.secondary,
                      onPressed: _openDemoVerification,
                    ).animate().fadeIn(delay: 360.ms, duration: 300.ms),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
