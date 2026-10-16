import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../../../shared/widgets/status_chip.dart';
import '../data/models/server_summary.dart';
import '../data/server_repository.dart';

class ServerListScreen extends ConsumerWidget {
  const ServerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Servers')),
      body: PaginatedList<ServerSummary>(
        fetcher: (page) => ref.read(serverRepositoryProvider).list(page: page),
        emptyState: const EmptyState(
          icon: Icons.dns_outlined,
          title: 'No servers yet',
          message: 'Create your first server from the catalog.',
        ),
        itemBuilder: (context, server) => _ServerCard(server: server),
      ),
    );
  }
}

class _ServerCard extends StatelessWidget {
  const _ServerCard({required this.server});

  final ServerSummary server;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ip = server.ipAddress;
    return Card(
      child: InkWell(
        onTap: () => context.go(Routes.serverDetailPath(server.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      server.name?.isNotEmpty == true ? server.name! : 'Server #${server.id}',
                      style: theme.textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusChip(status: server.status),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.lan_outlined, size: 16, color: theme.colorScheme.outline),
                  const SizedBox(width: 6),
                  Text(
                    ip != null && ip.isNotEmpty ? ip : 'No IP',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: ip != null ? null : theme.colorScheme.outline,
                    ),
                  ),
                  if (server.region != null) ...[
                    const SizedBox(width: 16),
                    Icon(Icons.public, size: 16, color: theme.colorScheme.outline),
                    const SizedBox(width: 6),
                    Text(server.region!, style: theme.textTheme.bodyMedium),
                  ],
                ],
              ),
              if (server.status.isProvisioning && server.progress != null) ...[
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: (server.progress! / 100).clamp(0, 1),
                ),
                const SizedBox(height: 4),
                Text(
                  '${server.stage ?? 'Provisioning'} · ${server.progress}%'
                  '${server.etaSeconds != null ? ' · ~${server.etaSeconds}s left' : ''}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
