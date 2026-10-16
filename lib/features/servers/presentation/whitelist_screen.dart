import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove IP'),
        content: Text('Remove ${ip.ipCidr ?? 'this rule'} from the whitelist?'),
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
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: 'Could not load whitelist',
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
              leading: const Icon(Icons.lock_outline),
              title: const Text('Access port'),
              trailing: Text(
                data.accessPort?.toString() ?? '—',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (data.ips.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: EmptyState(
                icon: Icons.shield_outlined,
                title: 'No whitelist entries',
                message: 'Add an IP or CIDR to restrict access.',
              ),
            )
          else
            Card(
              child: Column(
                children: [
                  for (final ip in data.ips) _IpTile(ip: ip, onRemove: _remove),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _IpTile extends StatelessWidget {
  const _IpTile({required this.ip, required this.onRemove});

  final WhitelistIp ip;
  final void Function(WhitelistIp) onRemove;

  @override
  Widget build(BuildContext context) {
    final subtitle = <String>[
      if (ip.description != null && ip.description!.isNotEmpty) ip.description!,
      if (ip.port != null) 'port ${ip.port}',
      if (ip.createdAt != null)
        DateFormatter.isoToLocal(ip.createdAt!.toIso8601String()),
    ].join(' · ');
    return ListTile(
      leading: const Icon(Icons.language),
      title: Text(ip.ipCidr ?? '—'),
      subtitle: subtitle.isEmpty ? null : Text(subtitle),
      trailing: IconButton(
        tooltip: 'Remove',
        icon: const Icon(Icons.delete_outline),
        onPressed: () => onRemove(ip),
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
          _cidrError = e.message.isNotEmpty ? e.message : 'Invalid IP or CIDR.';
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
          TextField(
            controller: _cidrController,
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'IP or CIDR',
              hintText: '203.0.113.10/32',
              errorText: _cidrError,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
              labelText: 'Label (optional)',
            ),
          ),
        ],
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
