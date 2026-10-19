import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_user.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/users` — searchable, role-filtered, paginated user list.
class AdminUsersScreen extends ConsumerStatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  final _searchController = TextEditingController();
  String _search = '';
  String _role = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Users')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              0,
            ),
            child: AppTextField(
              controller: _searchController,
              hint: 'Search by email',
              prefixIcon: Icons.search,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (v) =>
                  setState(() => _search = v.trim()),
              suffixIcon: IconButton(
                tooltip: 'Search',
                icon: const Icon(Icons.search),
                onPressed: () =>
                    setState(() => _search = _searchController.text.trim()),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AdminFilterChips(
            values: const ['all', 'user', 'admin'],
            selected: _role,
            labels: const {'all': 'All', 'user': 'Users', 'admin': 'Admins'},
            onChanged: (v) => setState(() => _role = v),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: PaginatedList<AdminUser>(
              key: ValueKey('users|$_search|$_role'),
              fetcher: (page) => ref.read(adminRepositoryProvider).getUsers(
                    page: page,
                    search: _search,
                    role: _role,
                  ),
              itemBuilder: (context, user) => _UserTile(user: user),
              emptyState: const AppEmptyState(
                icon: Icons.people_outline,
                title: 'No users found',
                message: 'Try a different search or filter.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user});

  final AdminUser user;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push(Routes.adminUserDetailPath(user.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              AdminStatusPill(status: user.role),
              const SizedBox(width: AppSpacing.xs),
              AdminStatusPill(status: user.isActive ? 'active' : 'banned'),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: InfoRow(
                  label: 'Wallet',
                  value: user.walletBalanceUsd ?? '—',
                  mono: true,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: InfoRow(
                  label: 'Servers',
                  value: '${user.serverCount}',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Last login: ${DateFormatter.isoToLocal(user.lastLoginAt?.toIso8601String())}',
            style: AppTypography.caption,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
