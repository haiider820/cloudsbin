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

  /// Cached re-auth grant. Kept across a benign `409 SERVER_NOT_ACTIVE`
  /// (the backend no longer consumes the grant on failure), so a retry does
  /// not force the user to re-enter their password. Cleared on success and on
  /// a `403 REAUTH_REQUIRED` (grant consumed/expired).
  String? _grant;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
  }

  Future<void> _reveal() async {
    var grant = _grant;
    if (grant == null) {
      final entered = await showReauthSheet(context);
      if (!mounted) return;
      if (entered == null) {
        setState(() => _awaitingConfirm = true);
        return;
      }
      grant = entered;
      _grant = entered;
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
      setState(() {
        _credential = reveal;
        _grant = null;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
      // 403 REAUTH_REQUIRED: the grant was consumed/expired — drop it so the
      // next attempt asks for the password again.
      if (e.code == 'REAUTH_REQUIRED') {
        _grant = null;
        showErrorSnackBar(context, e);
      }
      // 409 SERVER_NOT_ACTIVE: the server is not active yet. The reauth grant
      // is NOT consumed, so keep it cached and let the user retry after
      // starting the server — no password re-entry needed.
      if (e.code == 'SERVER_NOT_ACTIVE') {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Server not active'),
            content: const Text(
              'Server must be active to reveal credentials. '
              'Start the server first, then try again.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
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
        serverId: widget.serverId,
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

class _CredentialView extends ConsumerWidget {
  const _CredentialView({
    required this.serverId,
    required this.credential,
    required this.obscure,
    required this.onToggleObscure,
    required this.onCopy,
    required this.onRegenerate,
  });

  final int serverId;
  final CredentialReveal credential;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final Future<void> Function(String label, String value) onCopy;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final host = credential.ipAddress ?? '';
    final detail = ref.watch(serverDetailProvider(serverId)).valueOrNull;
    final osLower = detail?.os?.toLowerCase() ?? '';
    // RDP when the server advertises it (auth_type) or its OS is Windows;
    // AWS Windows plans expose RDP on 3389, not SSH.
    final isRdp =
        credential.authType.raw == 'rdp' || osLower.contains('windows');
    // `access_port` is the SSH port; Windows/RDP always listens on 3389.
    final port = isRdp ? 3389 : (detail?.accessPort ?? 22);
    final username = isRdp ? 'Administrator' : 'root';

    final value = credential.credential ?? '';
    final masked = obscure ? '••••••••••' : value;
    final connectionLabel = isRdp ? 'RDP connection' : 'SSH connection';

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                title: 'Server credentials',
                icon: isRdp ? Icons.desktop_windows_outlined : Icons.key_outlined,
              ),
              const SizedBox(height: AppSpacing.xs),
              InfoRow(
                label: 'Connection',
                value: isRdp ? 'RDP (Remote Desktop)' : 'SSH (Secure Shell)',
              ),
              InfoRow(label: 'Host', value: host.isEmpty ? '—' : host, mono: true),
              InfoRow(label: 'Username', value: username, mono: true),
              InfoRow(label: 'Port', value: port.toString(), mono: true),
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
                      obscure ? Icons.visibility_off : Icons.visibility,
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
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: 'Copy $connectionLabel',
                icon: Icons.copy_all_outlined,
                variant: AppButtonVariant.secondary,
                dense: true,
                onPressed: host.isEmpty
                    ? null
                    : () {
                        // RDP string is `host:port`; SSH is a ready-to-run
                        // `ssh user@host -p port` command.
                        final text = isRdp
                            ? '$host:$port'
                            : 'ssh $username@$host -p $port';
                        onCopy(connectionLabel, text);
                      },
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
