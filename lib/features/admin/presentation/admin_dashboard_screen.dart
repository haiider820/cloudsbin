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
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';
import '../data/models/admin_profile.dart';

/// Admin home. Identity comes from `/admin/me` only — the v1 API has no
/// management endpoints, so every section renders as a visible, locked
/// "coming soon" entry (zero user data anywhere on this screen).
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  late Future<AdminProfile> _future;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _future = ref.read(adminAuthRepositoryProvider).getProfile();
  }

  void _retry() {
    setState(() {
      _future = ref.read(adminAuthRepositoryProvider).getProfile();
    });
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
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: const [
                AppShimmer(itemCount: 4, itemHeight: 108),
              ],
            );
          }
          if (snapshot.hasError) {
            return _buildBody(
              profile: null,
              loadError: snapshot.error!,
              onRetry: _retry,
            );
          }
          return _buildBody(
            profile: snapshot.data!,
            loadError: null,
            onRetry: _retry,
          );
        },
      ),
    );
  }

  Widget _buildBody({
    required AdminProfile? profile,
    required Object? loadError,
    required VoidCallback onRetry,
  }) {
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.dangerBg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: 0.35),
                    ),
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
                          'Could not load admin profile. '
                          '${loadError is ApiError ? loadError.userMessage : ''}',
                          style: AppTypography.caption
                              .copyWith(color: AppColors.dangerFg),
                        ),
                      ),
                      TextButton(
                        onPressed: onRetry,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
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
          title: 'Management',
          subtitle: 'API Coming Soon',
          icon: Icons.dashboard_customize_outlined,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            children: [
              const _LockedTile(
                title: 'Dashboard',
                description: 'Overview of the CloudsBin platform',
              ),
              const _LockedTile(
                title: 'Users',
                description: 'Manage accounts, roles, and access',
              ),
              const _LockedTile(
                title: 'Servers',
                description: 'Provision and manage VPS instances',
              ),
              const _LockedTile(
                title: 'Orders & Top-ups',
                description: 'Review orders and manual top-up receipts',
              ),
              const _LockedTile(
                title: 'Wallet',
                description: 'Balances, withdrawals, and transactions',
              ),
              const _LockedTile(
                title: 'Support',
                description: 'Tickets and customer requests',
                showDivider: false,
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
        )
            .animate(delay: 140.ms)
            .fadeIn(duration: 300.ms),
        const SizedBox(height: AppSpacing.md),
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

class _LockedTile extends StatelessWidget {
  const _LockedTile({
    required this.title,
    required this.description,
    this.showDivider = true,
  });

  final String title;
  final String description;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          enabled: false,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 2,
          ),
          leading: const Icon(
            Icons.lock_outline,
            size: 20,
            color: AppColors.textMuted,
          ),
          title: Text(
            title,
            style: AppTypography.title.copyWith(
              color: AppColors.textSecondary,
              fontSize: 15.5,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Text(description, style: AppTypography.caption),
              const SizedBox(height: 2),
              Text(
                'Backend v1 endpoints coming soon',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textMuted,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, indent: AppSpacing.md, endIndent: AppSpacing.md),
      ],
    );
  }
}
