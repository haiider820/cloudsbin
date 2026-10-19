import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_dashboard.dart';
import '../data/models/admin_profile.dart';

/// Admin home — real platform stats and navigation into every management
/// section backed by the live `/api/v1/admin/*` endpoints.
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  late Future<AdminProfile> _future;
  late Future<AdminDashboard> _statsFuture;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = ref.read(adminAuthRepositoryProvider).getProfile();
    _statsFuture = ref.read(adminRepositoryProvider).getDashboard();
    // Both futures are consumed by FutureBuilders that may mount a frame
    // later (the stats card lives inside the profile-gated ListView), so mark
    // their errors as handled up front to avoid stray "unhandled error" logs.
    _future.ignore();
    _statsFuture.ignore();
  }

  void _retry() {
    setState(_load);
  }

  Future<void> _logout() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Log out?',
      message: 'End this admin session on this device.',
      confirmLabel: 'Log out',
      danger: true,
      icon: Icons.logout_outlined,
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await ref.read(adminAuthRepositoryProvider).logout();
      await ref.read(adminSessionProvider.notifier).logoutLocal();
      if (!mounted) return;
      context.go(Routes.login);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _logoutAll() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Log out of all sessions?',
      message:
          'This ends every admin session on every device. You will need to sign in again.',
      confirmLabel: 'Log out',
      danger: true,
      icon: Icons.devices_outlined,
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await ref.read(adminAuthRepositoryProvider).logoutAll();
      await ref.read(adminSessionProvider.notifier).logoutLocal();
      if (!mounted) return;
      context.go(Routes.login);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('CloudsBin Admin')),
      body: FutureBuilder<AdminProfile>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: AppShimmer(itemCount: 4, itemHeight: 108),
            );
          }
          return _buildBody(snapshot.data, snapshot.error);
        },
      ),
    );
  }

  Widget _buildBody(AdminProfile? profile, Object? loadError) {
    final sessionEmail = ref.read(adminSessionProvider).email;
    final email = profile?.email ?? sessionEmail ?? 'Administrator';
    final memberSince = DateFormatter.isoToLocal(
      profile?.createdAt?.toIso8601String(),
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        AppCard(
          gradientBorder: true,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.adminAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.adminAccent.withValues(alpha: 0.4),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.admin_panel_settings_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                email,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.title,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            const _AdminBadge(),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Member since: $memberSince',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (loadError != null) ...[
                const SizedBox(height: AppSpacing.sm),
                _ErrorBanner(
                  message:
                      'Could not load admin profile. ${loadError is ApiError ? loadError.userMessage : ''}',
                  onRetry: _retry,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'View Profile',
                      icon: Icons.badge_outlined,
                      variant: AppButtonVariant.secondary,
                      dense: true,
                      onPressed: () => context.push(Routes.adminProfile),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppButton(
                      label: 'My Sessions',
                      icon: Icons.devices_outlined,
                      variant: AppButtonVariant.secondary,
                      dense: true,
                      onPressed: () => context.push(Routes.adminSessions),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(
          title: 'Overview',
          icon: Icons.dashboard_customize_outlined,
        ),
        const SizedBox(height: AppSpacing.sm),
        FutureBuilder<AdminDashboard>(
          future: _statsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppShimmer(itemCount: 2, itemHeight: 100);
            }
            if (snapshot.hasError || !snapshot.hasData) {
              return AppCard(
                child: _ErrorBanner(
                  message: 'Could not load platform stats.',
                  onRetry: _retry,
                ),
              );
            }
            final s = snapshot.data!;
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        icon: Icons.people_outline,
                        label: 'Users',
                        value: '${s.users.total}',
                        accentColor: AppColors.accent,
                        onTap: () => context.push(Routes.adminUsers),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        icon: Icons.dns_outlined,
                        label: 'Servers',
                        value: '${s.servers.total}',
                        accentColor: AppColors.adminAccent,
                        onTap: () => context.push(Routes.adminServers),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: StatTile(
                        icon: Icons.receipt_long_outlined,
                        label: 'Pending orders',
                        value: '${s.orders.pending}',
                        accentColor: AppColors.warning,
                        onTap: () => context.push(Routes.adminOrders),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: StatTile(
                        icon: Icons.trending_up,
                        label: 'Revenue (mo)',
                        value: MoneyFormatter.usdString(s.revenue.thisMonthUsd),
                        accentColor: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(
          title: 'Needs review',
          icon: Icons.pending_actions_outlined,
        ),
        const SizedBox(height: AppSpacing.sm),
        _QuickActions(statsFuture: _statsFuture),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(
          title: 'Manage',
          icon: Icons.grid_view_outlined,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            children: [
              _NavTile(
                icon: Icons.people_outline,
                title: 'Users',
                description: 'Accounts, roles, and access',
                onTap: () => context.push(Routes.adminUsers),
              ),
              _NavTile(
                icon: Icons.dns_outlined,
                title: 'Servers',
                description: 'Provision and manage VPS instances',
                onTap: () => context.push(Routes.adminServers),
              ),
              _NavTile(
                icon: Icons.receipt_long_outlined,
                title: 'Orders',
                description: 'Review and approve orders',
                onTap: () => context.push(Routes.adminOrders),
              ),
              _NavTile(
                icon: Icons.account_balance_wallet_outlined,
                title: 'Top-ups',
                description: 'Manual wallet top-up receipts',
                onTap: () => context.push(Routes.adminTopups),
              ),
              _NavTile(
                icon: Icons.payments_outlined,
                title: 'Withdrawals',
                description: 'Wallet withdrawal requests',
                onTap: () => context.push(Routes.adminWithdrawals),
              ),
              _NavTile(
                icon: Icons.support_agent_outlined,
                title: 'Support',
                description: 'Tickets and customer requests',
                onTap: () => context.push(Routes.adminTickets),
              ),
              _NavTile(
                icon: Icons.campaign_outlined,
                title: 'Notifications',
                description: 'Send notices and view history',
                showDivider: false,
                onTap: () => context.push(Routes.adminNotifications),
              ),
            ],
          ),
        )
            .animate(delay: 80.ms)
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Log out',
                icon: Icons.logout_outlined,
                variant: AppButtonVariant.secondary,
                onPressed: _busy ? null : _logout,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppButton(
                label: 'Log out all',
                icon: Icons.devices_outlined,
                variant: AppButtonVariant.danger,
                loading: _busy,
                onPressed: _busy ? null : _logoutAll,
              ),
            ),
          ],
        ).animate(delay: 140.ms).fadeIn(duration: 300.ms),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.statsFuture});

  final Future<AdminDashboard> statsFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AdminDashboard>(
      future: statsFuture,
      builder: (context, snapshot) {
        final s = snapshot.data;
        return Row(
          children: [
            Expanded(
              child: _QuickAction(
                icon: Icons.receipt_long_outlined,
                label: 'Orders',
                count: s?.orders.pending ?? 0,
                onTap: () => context.push(Routes.adminOrders),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.account_balance_wallet_outlined,
                label: 'Top-ups',
                count: s?.topups.pendingCount ?? 0,
                onTap: () => context.push(Routes.adminTopups),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _QuickAction(
                icon: Icons.support_agent_outlined,
                label: 'Tickets',
                count: s?.tickets.open ?? 0,
                onTap: () => context.push(Routes.adminTickets),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 26, color: AppColors.adminAccentLight),
              if (count > 0)
                Positioned(
                  right: -10,
                  top: -8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 2,
          ),
          leading: Icon(icon, size: 20, color: AppColors.adminAccentLight),
          title: Text(
            title,
            style: AppTypography.title.copyWith(fontSize: 15.5),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(description, style: AppTypography.caption),
            ],
          ),
          trailing: const Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: AppSpacing.md,
            endIndent: AppSpacing.md,
          ),
      ],
    );
  }
}

class _AdminBadge extends StatelessWidget {
  const _AdminBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.adminAccent.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: AppColors.adminAccent.withValues(alpha: 0.55),
        ),
      ),
      child: const Text(
        'ADMIN',
        style: TextStyle(
          color: AppColors.adminAccentLight,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.dangerBg,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            size: 18,
            color: AppColors.dangerFg,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTypography.caption
                  .copyWith(color: AppColors.dangerFg),
            ),
          ),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
