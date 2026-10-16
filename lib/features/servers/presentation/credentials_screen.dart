import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
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
      setState(() {
        _credential = reveal;
        _busy = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _busy = false;
      });
      // 403 REAUTH_REQUIRED should not normally happen (we always pre-mint).
      if (e.code == 'REAUTH_REQUIRED') {
        showErrorSnackBar(context, e);
      }
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
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _ErrorView(
        error: _error!,
        onRetry: _reveal,
        onRegenerate: () =>
            context.go(Routes.serverRegeneratePath(widget.serverId)),
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
    return _ConfirmPrompt(
      awaitingConfirm: _awaitingConfirm,
      onConfirm: _reveal,
    );
  }
}

class _ConfirmPrompt extends StatelessWidget {
  const _ConfirmPrompt({required this.awaitingConfirm, required this.onConfirm});

  final bool awaitingConfirm;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              awaitingConfirm
                  ? 'Confirmation required to reveal credentials.'
                  : 'Revealing credentials…',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onConfirm,
              icon: const Icon(Icons.lock_open),
              label: const Text('Confirm password'),
            ),
          ],
        ),
      ),
    );
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
    final theme = Theme.of(context);
    final value = credential.credential ?? '';
    final masked = obscure ? '••••••••••' : value;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Row(
                  label: 'IP address',
                  value: credential.ipAddress ?? '—',
                  onCopy: credential.ipAddress == null
                      ? null
                      : () => onCopy('IP address', credential.ipAddress!),
                ),
                _Row(
                  label: 'Auth type',
                  value: credential.authType.raw,
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: theme.colorScheme.outline),
                          ),
                          const SizedBox(height: 4),
                          SelectableText(
                            masked,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: obscure ? 'Show' : 'Hide',
                      icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: onToggleObscure,
                    ),
                    IconButton(
                      tooltip: 'Copy',
                      icon: const Icon(Icons.copy),
                      onPressed: value.isEmpty ? null : () => onCopy('Password', value),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: onRegenerate,
          icon: const Icon(Icons.autorenew),
          label: const Text('Regenerate password'),
        ),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.error,
    required this.onRetry,
    required this.onRegenerate,
  });

  final ApiError error;
  final VoidCallback onRetry;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(error.userMessage, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (error.code == 'NO_CREDENTIALS')
                  FilledButton(
                    onPressed: onRegenerate,
                    child: const Text('Regenerate'),
                  )
                else
                  FilledButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.onCopy});

  final String label;
  final String value;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyMedium)),
          if (onCopy != null)
            IconButton(
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.copy, size: 18),
              onPressed: onCopy,
            ),
        ],
      ),
    );
  }
}
