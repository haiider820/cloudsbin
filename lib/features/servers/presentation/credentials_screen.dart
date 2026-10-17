import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/reauth_sheet.dart';
import '../data/models/credential_reveal.dart';
import '../data/server_repository.dart';

/// Reveals stored credentials — requires a fresh re-auth grant (§6.20).
class CredentialsScreen extends ConsumerStatefulWidget {
  const CredentialsScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends ConsumerState<CredentialsScreen> {
  bool _busy = false;
  bool _obscure = true;
  bool _awaitingConfirm = false;
  CredentialReveal? _credential;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
  }

  Future<void> _reveal() async {
    final grant = await showReauthSheet(context);
    if (!mounted) return;
    if (grant == null) {
      setState(() => _awaitingConfirm = true);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _awaitingConfirm = false;
    });
    try {
      final reveal = await ref.read(serverRepositoryProvider).credentialsReveal(
            serverId: widget.serverId,
            reauthToken: grant,
          );
      if (!mounted) return;
      setState(() => _credential = reveal);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
      // 403 REAUTH_REQUIRED should not normally happen (we always pre-mint).
      if (e.code == 'REAUTH_REQUIRED') {
        showErrorSnackBar(context, e);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = const ApiError(
            code: 'CLIENT_ERROR',
            message: 'Something went wrong. Please try again.',
          ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _copy(String label, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (mounted) showInfoSnackBar(context, '$label copied.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credentials'),
        actions: [
          IconButton(
            tooltip: 'Regenerate',
            onPressed: () =>
                context.go(Routes.serverRegeneratePath(widget.serverId)),
            icon: const Icon(Icons.autorenew),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_busy) {
      return const AppLoadingView(message: 'Revealing credentials…');
    }
    if (_error != null) {
      final error = _error!;
      return AppErrorView(
        message: error.userMessage,
        retryLabel: error.code == 'NO_CREDENTIALS' ? 'Regenerate' : 'Retry',
        onRetry: error.code == 'NO_CREDENTIALS'
            ? () => context.go(
                Routes.serverRegeneratePath(widget.serverId))
            : _reveal,
      );
    }
    if (_credential != null) {
      return _CredentialView(
        credential: _credential!,
        obscure: _obscure,
        onToggleObscure: () => setState(() => _obscure = !_obscure),
        onCopy: _copy,
        onRegenerate: () =>
            context.go(Routes.serverRegeneratePath(widget.serverId)),
      );
    }
    if (_awaitingConfirm) {
      return AppEmptyState(
        icon: Icons.lock_outline,
        title: 'Confirmation required to reveal credentials.',
        actionLabel: 'Confirm password',
        onAction: _reveal,
      );
    }
    return const AppLoadingView(message: 'Revealing credentials…');
  }
}

class _CredentialView extends StatelessWidget {
  const _CredentialView({
    required this.credential,
    required this.obscure,
    required this.onToggleObscure,
    required this.onCopy,
    required this.onRegenerate,
  });

  final CredentialReveal credential;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final Future<void> Function(String label, String value) onCopy;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    final value = credential.credential ?? '';
    final masked = obscure ? '••••••••••' : value;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Server credentials',
                icon: Icons.key_outlined,
              ),
              const SizedBox(height: AppSpacing.xs),
              InfoRow(
                label: 'IP address',
                value: credential.ipAddress ?? '—',
                mono: true,
                trailing: credential.ipAddress == null
                    ? null
                    : IconButton(
                        tooltip: 'Copy',
                        visualDensity: VisualDensity.compact,
                        icon: const Icon(
                          Icons.copy,
                          size: 18,
                          color: AppColors.textMuted,
                        ),
                        onPressed: () =>
                            onCopy('IP address', credential.ipAddress!),
                      ),
              ),
              InfoRow(
                label: 'Auth type',
                value: credential.authType.raw,
              ),
              const Divider(color: AppColors.line, height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Password',
                          style: AppTypography.bodySecondary,
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        SelectableText(
                          masked,
                          style: AppTypography.mono.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: obscure ? 'Show' : 'Hide',
                    icon: Icon(
                      obscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.textMuted,
                    ),
                    onPressed: onToggleObscure,
                  ),
                  IconButton(
                    tooltip: 'Copy',
                    icon: const Icon(
                      Icons.copy,
                      color: AppColors.textMuted,
                    ),
                    onPressed: value.isEmpty
                        ? null
                        : () => onCopy('Password', value),
                  ),
                ],
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Regenerate password',
          icon: Icons.autorenew,
          variant: AppButtonVariant.secondary,
          onPressed: onRegenerate,
        ),
      ],
    );
  }
}
