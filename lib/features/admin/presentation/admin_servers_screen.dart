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
import '../data/admin_repository.dart';
import '../data/models/admin_server.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/servers` — every user's servers, filterable by status.
class AdminServersScreen extends ConsumerStatefulWidget {
  const AdminServersScreen({super.key});

  @override
  ConsumerState<AdminServersScreen> createState() => _AdminServersScreenState();
}

class _AdminServersScreenState extends ConsumerState<AdminServersScreen> {
  String _status = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Servers')),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          AdminFilterChips(
            values: const ['all', 'active', 'destroyed'],
            selected: _status,
            labels: const {
              'all': 'All',
              'active': 'Active',
              'destroyed': 'Destroyed',
            },
            onChanged: (v) => setState(() => _status = v),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: PaginatedList<AdminServer>(
              key: ValueKey('servers|$_status'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getServers(page: page, status: _status),
              itemBuilder: (context, server) => _ServerTile(server: server),
              emptyState: const AppEmptyState(
                icon: Icons.dns_outlined,
                title: 'No servers found',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServerTile extends StatelessWidget {
  const _ServerTile({required this.server});

  final AdminServer server;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push(Routes.adminServerDetailPath(server.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  server.ipAddress ?? 'No IP',
                  style: AppTypography.mono,
                ),
              ),
              StatusChip(status: server.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  server.userEmail ?? 'User #${server.userId}',
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySecondary,
                ),
              ),
              if (server.providerSlug != null)
                ProviderBadge(slug: server.providerSlug!),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${server.planName ?? '—'} · ${server.region ?? '—'} · #${server.id}',
            style: AppTypography.caption,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
