import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';

/// Phase 11 — admin sign-in (§5.1).
///
/// Distinct admin identity: BrandMark + "Admin Console" eyebrow, a
/// restricted-area warning stripe, the separate-token notice, and branded
/// credential fields. Logic (provider, API call, error path) is unchanged
/// from the original.
class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref.read(adminAuthRepositoryProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      await ref.read(adminSessionProvider.notifier).refresh();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildIdentityHeader(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildRestrictedStripe(),
                  const SizedBox(height: AppSpacing.sm),
                  _buildTokenNotice(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityHeader() {
    return Column(
      children: [
        const BrandMark(size: 72),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'ADMIN CONSOLE',
          textAlign: TextAlign.center,
          style: AppTypography.sectionEyebrow,
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text(
          'Admin sign in',
          textAlign: TextAlign.center,
          style: AppTypography.headline,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Sign in with your administrator credentials to continue.',
          textAlign: TextAlign.center,
          style: AppTypography.bodySecondary,
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(
          begin: 0.06,
          end: 0,
          curve: Curves.easeOut,
        );
  }

  Widget _buildRestrictedStripe() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.pendingBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.pendingFg.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            size: 18,
            color: AppColors.pendingFg,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Restricted area — admin credentials only.',
              style: AppTypography.caption.copyWith(
                color: AppColors.pendingFg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ).animate(delay: 80.ms).fadeIn(duration: 400.ms).slideY(
          begin: 0.06,
          end: 0,
          curve: Curves.easeOut,
        );
  }

  Widget _buildTokenNotice() {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 20,
            color: AppColors.info,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'This is the admin audience, not the user app. '
              'Admin tokens are stored separately and never shared.',
              style: AppTypography.bodySecondary,
            ),
          ),
        ],
      ),
    ).animate(delay: 140.ms).fadeIn(duration: 400.ms).slideY(
          begin: 0.06,
          end: 0,
          curve: Curves.easeOut,
        );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: _emailController,
          label: 'Admin email',
          hint: 'admin@example.com',
          prefixIcon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.username],
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Your admin password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          toggleObscure: true,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.password],
          onFieldSubmitted: (_) => _submit(),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Sign in as admin',
          icon: Icons.admin_panel_settings_outlined,
          loading: _submitting,
          onPressed: _submit,
        ),
      ],
    ).animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(
          begin: 0.06,
          end: 0,
          curve: Curves.easeOut,
        );
  }
}
