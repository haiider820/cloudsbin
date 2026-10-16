import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/status_chip.dart';
import '../data/models/server_detail.dart';
import '../data/server_repository.dart';

class ServerDetailScreen extends ConsumerStatefulWidget {
  const ServerDetailScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<ServerDetailScreen> createState() => _ServerDetailScreenState();
}

class _ServerDetailScreenState extends ConsumerState<ServerDetailScreen> {
  bool _refreshing = false;

  Future<void> _sync() async {
    setState(() => _refreshing = true);
    try {
      await ref.read(serverRepositoryProvider).refresh(widget.serverId);
      ref.invalidate(serverDetailProvider(widget.serverId));
      if (mounted) showInfoSnackBar(context, 'Synced with provider.');
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(serverDetailProvider(widget.serverId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Server'),
        actions: [
          IconButton(
            tooltip: 'Sync with provider',
            onPressed: _refreshing ? null : _sync,
            icon: _refreshing
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.sync),
          ),
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyState(
          icon: Icons.error_outline,
          title: 'Could not load server',
          message: error is ApiError ? error.userMessage : 'Unexpected error.',
          action: FilledButton(
            onPressed: () => ref.invalidate(serverDetailProvider(widget.serverId)),
            child: const Text('Retry'),
          ),
        ),
        data: (server) => _DetailBody(server: server),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.server});

  final ServerDetail server;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bandwidth = server.bandwidth;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        server.name?.isNotEmpty == true
                            ? server.name!
                            : 'Server #${server.id}',
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    StatusChip(status: server.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text('ID ${server.id}', style: theme.textTheme.bodySmall),
                const Divider(height: 24),
                _InfoRow(label: 'IP address', value: server.ipAddress ?? 'No IP'),
                _InfoRow(label: 'Access port', value: server.accessPort?.toString()),
                _InfoRow(label: 'Plan', value: server.planName),
                _InfoRow(label: 'Region', value: server.region),
                _InfoRow(label: 'Operating system', value: server.os),
                _InfoRow(
                  label: 'Specs',
                  value: _specs(server),
                ),
                _InfoRow(
                  label: 'Created',
                  value: DateFormatter.isoToLocal(server.createdAt?.toIso8601String()),
                ),
                _InfoRow(
                  label: 'Activated',
                  value: DateFormatter.isoToLocal(server.activatedAt?.toIso8601String()),
                ),
                if (server.destroyedAt != null)
                  _InfoRow(
                    label: 'Destroyed',
                    value: DateFormatter.isoToLocal(server.destroyedAt?.toIso8601String()),
                  ),
              ],
            ),
          ),
        ),
        if (!server.status.isActive) ...[
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Provisioning', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: ((server.progress ?? 0) / 100).clamp(0, 1),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${server.stage ?? 'Working'}'
                    '${server.progress != null ? ' · ${server.progress}%' : ''}'
                    '${server.etaSeconds != null ? ' · ETA ~${DateFormatter.countdown(server.etaSeconds!)}' : ''}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bandwidth', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                if (bandwidth == null)
                  Text(
                    'No bandwidth data available yet.',
                    style: theme.textTheme.bodySmall,
                  )
                else ...[
                  _InfoRow(label: 'In', value: _gb(bandwidth.inGb)),
                  _InfoRow(label: 'Out', value: _gb(bandwidth.outGb)),
                  _InfoRow(label: 'Total', value: _gb(bandwidth.totalGb)),
                  _InfoRow(
                    label: 'Resets on day',
                    value: bandwidth.resetDay?.toString(),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ActionsGrid(serverId: server.id),
      ],
    );
  }

  static String? _specs(ServerDetail server) {
    final parts = <String>[];
    if (server.vcpu != null) parts.add('${server.vcpu} vCPU');
    if (server.ramGb != null) parts.add('${server.ramGb} GB RAM');
    if (server.ssdGb != null) parts.add('${server.ssdGb} GB SSD');
    return parts.isEmpty ? null : parts.join(' · ');
  }

  static String? _gb(double? value) => value == null ? null : '$value GB';
}

class _ActionsGrid extends StatelessWidget {
  const _ActionsGrid({required this.serverId});

  final int serverId;

  @override
  Widget build(BuildContext context) {
    final items = <(IconData, String, String)>[
      (Icons.bar_chart, 'Usage', Routes.serverUsagePath(serverId)),
      (Icons.shield_outlined, 'IP whitelist', Routes.serverWhitelistPath(serverId)),
      (Icons.local_fire_department_outlined, 'Firewall', Routes.serverFirewallPath(serverId)),
      (Icons.key_outlined, 'Credentials', Routes.serverCredentialsPath(serverId)),
      (Icons.settings_ethernet, 'Access port', Routes.serverAccessPortPath(serverId)),
      (Icons.delete_outline, 'Destroy', Routes.serverDestroyPath(serverId)),
    ];
    return Card(
      child: Column(
        children: [
          for (final (icon, label, route) in items)
            ListTile(
              leading: Icon(icon),
              title: Text(label),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go(route),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          Expanded(
            child: Text(
              (value == null || value!.isEmpty) ? '—' : value!,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
