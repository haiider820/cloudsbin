import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/enums/app_enums.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/models/firewall.dart';
import '../data/server_repository.dart';

/// Firewall management (§6.27–6.29) — inbound rules only.
class FirewallScreen extends ConsumerStatefulWidget {
  const FirewallScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<FirewallScreen> createState() => _FirewallScreenState();
}

class _FirewallScreenState extends ConsumerState<FirewallScreen> {
  FirewallResponse? _data;
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
          await ref.read(serverRepositoryProvider).firewall(widget.serverId);
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
      builder: (_) => _AddRuleDialog(serverId: widget.serverId),
    );
    if (added == true) _load();
  }

  Future<void> _remove(FirewallRule rule) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Remove rule',
      message: 'Remove ${rule.protocol?.raw ?? 'rule'} '
          '${rule.portStart ?? ''}${rule.portEnd != null && rule.portEnd != rule.portStart ? '-${rule.portEnd}' : ''}?',
      confirmLabel: 'Remove',
      danger: true,
      icon: Icons.delete_outline,
    );
    if (!confirmed) return;

    try {
      await ref.read(serverRepositoryProvider).firewallRemove(
            serverId: widget.serverId,
            ruleId: rule.id,
          );
      if (mounted) showInfoSnackBar(context, 'Rule removed.');
    } on ApiError catch (e) {
      if (e.code != 'NOT_FOUND' && mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firewall'),
        actions: [
          IconButton(
            tooltip: 'Add rule',
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
      return const AppLoadingView(message: 'Loading firewall…');
    }
    if (_error != null) {
      return AppErrorView(
        title: 'Could not load firewall',
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
                    Icons.settings_ethernet,
                    size: 20,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Access port',
                        style: AppTypography.title,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Rules covering this port are rejected',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                Text(
                  data.accessPort?.toString() ?? '—',
                  style: AppTypography.mono.copyWith(fontSize: 16),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(
            title: 'Inbound rules',
            icon: Icons.local_fire_department_outlined,
          ),
          const SizedBox(height: AppSpacing.sm),
          if (data.rules.isEmpty)
            const AppEmptyState(
              icon: Icons.local_fire_department_outlined,
              title: 'No custom rules',
              message: 'Only inbound rules can be managed.',
            )
          else
            for (final rule in data.rules) ...[
              _RuleCard(rule: rule, onRemove: _remove)
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.sm),
            ],
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Outbound rules are not supported by the API '
                    '(they are rejected with 400 DIRECTION_NOT_SUPPORTED).',
                    style: AppTypography.caption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({required this.rule, required this.onRemove});

  final FirewallRule rule;
  final void Function(FirewallRule) onRemove;

  @override
  Widget build(BuildContext context) {
    final portRange = rule.portStart == null
        ? '—'
        : (rule.portEnd != null && rule.portEnd != rule.portStart)
            ? '${rule.portStart}-${rule.portEnd}'
            : '${rule.portStart}';
    final meta = <String>[
      '${rule.direction?.raw ?? 'inbound'} · ${rule.protocol?.raw ?? 'tcp'} · port $portRange',
      if (rule.ipCidr != null && rule.ipCidr!.isNotEmpty) rule.ipCidr!,
      if (rule.description != null && rule.description!.isNotEmpty)
        rule.description!,
      if (rule.createdAt != null)
        DateFormatter.isoToLocal(rule.createdAt!.toIso8601String()),
    ].join('\n');
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.rule,
              size: 20,
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${rule.protocol?.raw.toUpperCase() ?? ''} $portRange'
                      .trim(),
                  style: AppTypography.mono,
                ),
                const SizedBox(height: 2),
                Text(meta, style: AppTypography.caption),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Remove',
            icon: const Icon(
              Icons.delete_outline,
              color: AppColors.danger,
            ),
            onPressed: () => onRemove(rule),
          ),
        ],
      ),
    );
  }
}

class _AddRuleDialog extends ConsumerStatefulWidget {
  const _AddRuleDialog({required this.serverId});

  final int serverId;

  @override
  ConsumerState<_AddRuleDialog> createState() => _AddRuleDialogState();
}

class _AddRuleDialogState extends ConsumerState<_AddRuleDialog> {
  final _portStartController = TextEditingController();
  final _portEndController = TextEditingController();
  final _sourceController = TextEditingController();
  final _descriptionController = TextEditingController();

  FirewallProtocol _protocol = FirewallProtocol.tcp;
  bool _submitting = false;
  String? _portError;
  String? _sourceError;
  String? _formError;

  @override
  void dispose() {
    _portStartController.dispose();
    _portEndController.dispose();
    _sourceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final portStart = int.tryParse(_portStartController.text.trim());
    final portEnd = int.tryParse(_portEndController.text.trim());
    if (portStart == null || portStart <= 0) {
      setState(() => _portError = 'Enter a valid port.');
      return;
    }
    setState(() {
      _submitting = true;
      _portError = null;
      _sourceError = null;
      _formError = null;
    });
    try {
      await ref.read(serverRepositoryProvider).firewallAdd(
            serverId: widget.serverId,
            protocol: _protocol,
            portStart: portStart,
            portEnd: portEnd,
            sourceCidr: _sourceController.text.trim(),
            description: _descriptionController.text.trim(),
          );
      if (mounted) Navigator.pop(context, true);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      switch (e.code) {
        case 'ACCESS_PORT_CONFLICT':
          setState(() => _formError = e.message);
        case 'ALREADY_OPEN':
          setState(() => _formError = e.message);
        case 'INVALID_CIDR':
          setState(() => _sourceError = e.message);
        case 'DIRECTION_NOT_SUPPORTED':
          setState(() => _formError = e.message);
        default:
          showErrorSnackBar(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add inbound rule'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_formError != null) ...[
              Text(
                _formError!,
                style: const TextStyle(color: AppColors.danger),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            DropdownButtonFormField<FirewallProtocol>(
              initialValue: _protocol,
              decoration: const InputDecoration(labelText: 'Protocol'),
              items: const [
                DropdownMenuItem(
                    value: FirewallProtocol.tcp, child: Text('TCP')),
                DropdownMenuItem(
                    value: FirewallProtocol.udp, child: Text('UDP')),
              ],
              onChanged: (value) =>
                  setState(() => _protocol = value ?? FirewallProtocol.tcp),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _portStartController,
                    label: 'Port start',
                    keyboardType: TextInputType.number,
                    errorText: _portError,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppTextField(
                    controller: _portEndController,
                    label: 'Port end',
                    hint: 'optional',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _sourceController,
              label: 'Source CIDR',
              hint: '198.51.100.0/24',
              keyboardType: TextInputType.text,
              errorText: _sourceError,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppTextField(
              controller: _descriptionController,
              label: 'Description (optional)',
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'Direction: inbound (outbound is disabled)',
                    style: AppTypography.caption,
                  ),
                ),
              ],
            ),
          ],
        ),
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
