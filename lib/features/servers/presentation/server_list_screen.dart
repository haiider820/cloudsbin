import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
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
        emptyState: const AppEmptyState(
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
    final ip = server.ipAddress;
    final meta = <String>[
      if (server.planName != null && server.planName!.isNotEmpty)
        server.planName!,
      if (server.region != null && server.region!.isNotEmpty) server.region!,
    ].join(' · ');

    return AppCard(
      onTap: () => context.go(Routes.serverDetailPath(server.id)),
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
                  style: AppTypography.title,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              StatusChip(status: server.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              const Icon(
                Icons.lan_outlined,
                size: 16,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  ip != null && ip.isNotEmpty ? ip : 'No IP',
                  style: AppTypography.mono.copyWith(
                    color: ip != null && ip.isNotEmpty
                        ? AppColors.textSecondary
                        : AppColors.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: AppColors.textMuted,
              ),
            ],
          ),
          if (meta.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(meta, style: AppTypography.caption),
          ],
          if (server.status.isProvisioning && server.progress != null) ...[
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: (server.progress! / 100).clamp(0, 1),
                minHeight: 6,
                color: AppColors.accent,
                backgroundColor: AppColors.bg3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${server.stage ?? 'Provisioning'} · ${server.progress}%'
              '${server.etaSeconds != null ? ' · ~${server.etaSeconds}s left' : ''}',
              style: AppTypography.caption,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0);
  }
}
