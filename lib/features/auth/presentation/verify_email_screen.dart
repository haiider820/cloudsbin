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
import '../data/auth_repository.dart';

/// Outcome of consuming the verification token.
enum _VerifyState { loading, success, expired, used, invalid, error }

/// Deep-link landing screen for `.../verify-email?token=...`.
///
/// Auto-submits [AuthRepository.verifyEmail] on open and renders the result;
/// there is no manual "verify" button.
class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key, required this.token});

  final String token;

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  _VerifyState _state = _VerifyState.loading;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _verify());
  }

  Future<void> _verify() async {
    if (widget.token.isEmpty) {
      setState(() => _state = _VerifyState.invalid);
      return;
    }
    setState(() => _state = _VerifyState.loading);
    try {
      await ref.read(authRepositoryProvider).verifyEmail(widget.token);
      if (!mounted) return;
      setState(() => _state = _VerifyState.success);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _state = _stateFor(e));
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = _VerifyState.error);
    }
  }

  _VerifyState _stateFor(ApiError e) {
    switch (e.code) {
      case 'TOKEN_EXPIRED':
        return _VerifyState.expired;
      case 'TOKEN_USED':
        return _VerifyState.used;
      case 'TOKEN_INVALID':
        return _VerifyState.invalid;
      default:
        return _VerifyState.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Email verification')),
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
    switch (_state) {
      case _VerifyState.loading:
        return Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Verifying your email...',
              textAlign: TextAlign.center,
              style: AppTypography.bodySecondary,
            ),
          ],
        ).animate().fadeIn(duration: 250.ms);
      case _VerifyState.success:
        return _Result(
          icon: Icons.check_circle_outline,
          iconColor: AppColors.success,
          message: 'Email verified! You can now sign in.',
          buttonLabel: 'Go to Login',
          onPressed: () => context.go(Routes.login),
        );
      case _VerifyState.expired:
        return _Result(
          icon: Icons.timer_off_outlined,
          iconColor: AppColors.warning,
          message: 'This link has expired.',
          detail: 'Request a new verification email to try again.',
          buttonLabel: 'Request a new verification email',
          onPressed: () => context.go(Routes.login),
        );
      case _VerifyState.used:
        return _Result(
          icon: Icons.verified_outlined,
          iconColor: AppColors.info,
          message: 'Already verified.',
          buttonLabel: 'Go to Login',
          onPressed: () => context.go(Routes.login),
        );
      case _VerifyState.invalid:
        return _Result(
          icon: Icons.link_off_outlined,
          iconColor: AppColors.danger,
          message: 'Invalid verification link.',
          buttonLabel: 'Go to Login',
          onPressed: () => context.go(Routes.login),
        );
      case _VerifyState.error:
        return _Result(
          icon: Icons.cloud_off_outlined,
          iconColor: AppColors.warning,
          message: 'Something went wrong.',
          detail: 'We could not verify your email right now. Please try again.',
          buttonLabel: 'Try again',
          onPressed: _verify,
          secondaryLabel: 'Go to Login',
          onSecondary: () => context.go(Routes.login),
        );
    }
  }
}

class _Result extends StatelessWidget {
  const _Result({
    required this.icon,
    required this.iconColor,
    required this.message,
    required this.buttonLabel,
    required this.onPressed,
    this.detail,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final Color iconColor;
  final String message;
  final String? detail;
  final String buttonLabel;
  final VoidCallback onPressed;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

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
        ).animate().fadeIn(duration: 300.ms).scale(
              begin: const Offset(0.85, 0.85),
              end: const Offset(1, 1),
              duration: 300.ms,
            ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.headline,
        ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
        if (detail != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            detail!,
            textAlign: TextAlign.center,
            style: AppTypography.bodySecondary,
          ).animate().fadeIn(delay: 140.ms, duration: 300.ms),
        ],
        const SizedBox(height: AppSpacing.xl),
        AppButton(label: buttonLabel, onPressed: onPressed)
            .animate()
            .fadeIn(delay: 200.ms, duration: 300.ms),
        if (secondaryLabel != null && onSecondary != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.center,
            child: AppButton(
              label: secondaryLabel!,
              variant: AppButtonVariant.ghost,
              fullWidth: false,
              onPressed: onSecondary,
            ),
          ).animate().fadeIn(delay: 260.ms, duration: 300.ms),
        ],
      ],
    );
  }
}
