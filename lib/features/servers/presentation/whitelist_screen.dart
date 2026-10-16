import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/models/ip_whitelist.dart';
import '../data/server_repository.dart';

/// IP whitelist management (§6.23–6.25).
class WhitelistScreen extends ConsumerStatefulWidget {
  const WhitelistScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<WhitelistScreen> createState() => _WhitelistScreenState();
}

class _WhitelistScreenState extends ConsumerState<WhitelistScreen> {
  IpWhitelistResponse? _data;
  ApiError? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data =
          await ref.read(serverRepositoryProvider).ipWhitelist(widget.serverId);
      if (!mounted) return;
      setState(() => _data = data);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _showAddDialog() async {
    final added = await showDialog<bool>(
      context: context,
      builder: (_) => _AddIpDialog(serverId: widget.serverId),
    );
    if (added == true) _load();
  }

  Future<void> _remove(WhitelistIp ip) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Remove IP',
      message: 'Remove ${ip.ipCidr ?? 'this rule'} from the whitelist?',
      confirmLabel: 'Remove',
      danger: true,
      icon: Icons.delete_outline,
    );
    if (!confirmed) return;

    try {
      await ref.read(serverRepositoryProvider).ipWhitelistRemove(
            serverId: widget.serverId,
            ruleId: ip.id,
          );
      if (mounted) showInfoSnackBar(context, 'IP removed.');
    } on ApiError catch (e) {
      // A rule that is already gone (404) is effectively removed.
      if (e.code != 'NOT_FOUND' && mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP whitelist'),
        actions: [
          IconButton(
            tooltip: 'Add IP',
            onPressed: _showAddDialog,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading && _data == null && _error == null) {
      return const AppLoadingView(message: 'Loading whitelist…');
    }
    if (_error != null) {
      return AppErrorView(
        title: 'Could not load whitelist',
        message: _error!.userMessage,
        retryLabel: 'Retry',
        onRetry: _load,
      );
    }
    final data = _data;
    if (data == null) return const SizedBox.shrink();

    return RefreshIndicator(
      color: AppColors.accent,
      backgroundColor: AppColors.bg2,
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Text(
                    'Access port',
                    style: AppTypography.title,
                  ),
                ),
                Text(
                  data.accessPort?.toString() ?? '—',
                  style:
                      AppTypography.mono.copyWith(fontSize: 16),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(
            title: 'Whitelisted IPs',
            icon: Icons.shield_outlined,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (data.ips.isEmpty)
            const AppEmptyState(
              icon: Icons.shield_outlined,
              title: 'No whitelist entries',
              message: 'Add an IP or CIDR to restrict access.',
            )
          else
            for (final ip in data.ips) ...[
              _IpCard(ip: ip, onRemove: _remove)
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _IpCard extends StatelessWidget {
  const _IpCard({required this.ip, required this.onRemove});

  final WhitelistIp ip;
  final void Function(WhitelistIp) onRemove;

  @override
  Widget build(BuildContext context) {
    final meta = <String>[
      if (ip.description != null && ip.description!.isNotEmpty)
        ip.description!,
      if (ip.port != null) 'port ${ip.port}',
      if (ip.createdAt != null)
        DateFormatter.isoToLocal(ip.createdAt!.toIso8601String()),
    ].join(' · ');
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.language,
              size: 20,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ip.ipCidr ?? '—',
                  style: AppTypography.mono,
                ),
                if (meta.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(meta, style: AppTypography.caption),
                ],
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remove',
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.danger,
            ),
            onPressed: () => onRemove(ip),
          ),
        ],
      ),
    );
  }
}

class _AddIpDialog extends ConsumerStatefulWidget {
  const _AddIpDialog({required this.serverId});

  final int serverId;

  @override
  ConsumerState<_AddIpDialog> createState() => _AddIpDialogState();
}

class _AddIpDialogState extends ConsumerState<_AddIpDialog> {
  final _cidrController = TextEditingController();
  final _labelController = TextEditingController();
  bool _submitting = false;
  String? _cidrError;

  @override
  void dispose() {
    _cidrController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final cidr = _cidrController.text.trim();
    if (cidr.isEmpty) {
      setState(() => _cidrError = 'Enter an IP or CIDR.');
      return;
    }
    setState(() {
      _submitting = true;
      _cidrError = null;
    });
    try {
      await ref.read(serverRepositoryProvider).ipWhitelistAdd(
            serverId: widget.serverId,
            cidrOrIp: cidr,
            label: _labelController.text.trim(),
          );
      if (mounted) Navigator.pop(context, true);
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.code == 'INVALID_CIDR') {
        setState(() {
          _cidrError =
              e.message.isNotEmpty ? e.message : 'Invalid IP or CIDR.';
          _submitting = false;
        });
      } else if (e.code == 'ALREADY_EXISTS') {
        // Treat as success (§6.24).
        showInfoSnackBar(context, 'That IP is already whitelisted.');
        Navigator.pop(context, true);
      } else {
        setState(() => _submitting = false);
        showErrorSnackBar(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add IP'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: _cidrController,
            label: 'IP or CIDR',
            hint: '203.0.113.10/32',
            keyboardType: TextInputType.text,
            errorText: _cidrError,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _labelController,
            label: 'Label (optional)',
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Cancel',
                variant: AppButtonVariant.secondary,
                dense: true,
                onPressed:
                    _submitting ? null : () => Navigator.pop(context, false),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: 'Add',
                dense: true,
                loading: _submitting,
                onPressed: _submitting ? null : _submit,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
