import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/enums/app_enums.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove rule'),
        content: Text(
          'Remove ${rule.protocol?.raw ?? 'rule'} '
          '${rule.portStart ?? ''}${rule.portEnd != null && rule.portEnd != rule.portStart ? '-${rule.portEnd}' : ''}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

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
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: 'Could not load firewall',
        message: _error!.userMessage,
        action: FilledButton(onPressed: _load, child: const Text('Retry')),
      );
    }
    final data = _data;
    if (data == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_ethernet),
              title: const Text('Access port'),
              subtitle: const Text('Rules covering this port are rejected'),
              trailing: Text(
                data.accessPort?.toString() ?? '—',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (data.rules.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: EmptyState(
                icon: Icons.local_fire_department_outlined,
                title: 'No custom rules',
                message: 'Only inbound rules can be managed.',
              ),
            )
          else
            Card(
              child: Column(
                children: [
                  for (final rule in data.rules)
                    _RuleTile(rule: rule, onRemove: _remove),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Outbound rules are not supported by the API '
                  '(they are rejected with 400 DIRECTION_NOT_SUPPORTED).',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RuleTile extends StatelessWidget {
  const _RuleTile({required this.rule, required this.onRemove});

  final FirewallRule rule;
  final void Function(FirewallRule) onRemove;

  @override
  Widget build(BuildContext context) {
    final portRange = rule.portStart == null
        ? '—'
        : (rule.portEnd != null && rule.portEnd != rule.portStart)
            ? '${rule.portStart}-${rule.portEnd}'
            : '${rule.portStart}';
    final subtitle = <String>[
      '${rule.direction?.raw ?? 'inbound'} · ${rule.protocol?.raw ?? 'tcp'} · port $portRange',
      if (rule.ipCidr != null && rule.ipCidr!.isNotEmpty) rule.ipCidr!,
      if (rule.description != null && rule.description!.isNotEmpty)
        rule.description!,
      if (rule.createdAt != null)
        DateFormatter.isoToLocal(rule.createdAt!.toIso8601String()),
    ].join('\n');
    return ListTile(
      leading: const Icon(Icons.rule),
      title: Text('${rule.protocol?.raw.toUpperCase() ?? ''} $portRange'.trim()),
      subtitle: Text(subtitle),
      isThreeLine: true,
      trailing: IconButton(
        tooltip: 'Remove',
        icon: const Icon(Icons.delete_outline),
        onPressed: () => onRemove(rule),
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
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(height: 12),
            ],
            DropdownButtonFormField<FirewallProtocol>(
              initialValue: _protocol,
              decoration: const InputDecoration(labelText: 'Protocol'),
              items: const [
                DropdownMenuItem(value: FirewallProtocol.tcp, child: Text('TCP')),
                DropdownMenuItem(value: FirewallProtocol.udp, child: Text('UDP')),
              ],
              onChanged: (value) =>
                  setState(() => _protocol = value ?? FirewallProtocol.tcp),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _portStartController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Port start',
                      errorText: _portError,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _portEndController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Port end',
                      hintText: 'optional',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sourceController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Source CIDR',
                hintText: '198.51.100.0/24',
                errorText: _sourceError,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.lock_outline, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Direction: inbound (outbound is disabled)',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _submitting ? null : () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submitting ? null : _submit,
          child: _submitting
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Add'),
        ),
      ],
    );
  }
}
