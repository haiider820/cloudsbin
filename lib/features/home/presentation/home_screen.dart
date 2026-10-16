import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/demo/demo_mode.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/hero_header.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/auth_session.dart';
import '../data/home_repository.dart';
import '../data/models/home_summary.dart';

/// Phase 10 — full dashboard. `GET /home` → server counts, wallet balances
/// (DECIMAL strings, shown verbatim), and badges.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<HomeSummary> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(homeRepositoryProvider).summary();
  }

  Future<void> _refresh() async {
    setState(() {
      _future = ref.read(homeRepositoryProvider).summary();
    });
    await _future;
  }

  Future<void> _logout() async {
    final confirm = await confirmDialog(
      context,
      title: 'Log out?',
      message: 'You will be signed out on this device.',
      confirmLabel: 'Log out',
      icon: Icons.logout_outlined,
    );
    if (confirm != true) return;
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Local logout must succeed even if the API call fails.
    }
    await ref.read(sessionProvider.notifier).logoutLocal();
  }

  @override
  Widget build(BuildContext context) {
    final email = ref.watch(sessionProvider).email;
    final actions = <_ActionData>[
      _ActionData(
        Icons.add_circle_outline,
        'Create server',
        'Provision a new cloud server',
        () => context.push(Routes.createServer),
      ),
      _ActionData(
        Icons.dns_outlined,
        'Servers',
        'View and manage your servers',
        () => context.push(Routes.servers),
      ),
      _ActionData(
        Icons.inventory_2_outlined,
        'Plans & ordering',
        'Browse plans, estimate, create a server',
        () => context.push(Routes.plans),
      ),
      _ActionData(
        Icons.currency_bitcoin,
        'Pay with crypto',
        'Checkout with a crypto asset',
        () => context.push(Routes.cryptoCheckout),
      ),
      _ActionData(
        Icons.receipt_long_outlined,
        'Orders',
        'Order history and receipts',
        () => context.push(Routes.orders),
      ),
      _ActionData(
        Icons.person_outline,
        'Profile',
        'Account details and referral code',
        () => context.push(Routes.profile),
      ),
      _ActionData(
        Icons.devices_outlined,
        'Sessions',
        'Devices signed in to your account',
        () => context.push(Routes.sessions),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('CloudsBin'),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
          ),
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            if (kDemoMode) const _DemoBanner(),
            HeroHeader(
              eyebrow: 'CloudsBin',
              title: 'Welcome back',
              subtitle: email,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md),
              child: FutureBuilder<HomeSummary>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppSpacing.xl),
                      child: AppLoadingView(
                          message: 'Loading dashboard…'),
                    );
                  }
                  if (snapshot.hasError) {
                    final err = snapshot.error;
                    return AppErrorView(
                      message: err is ApiError
                          ? err.userMessage
                          : 'Could not load the dashboard.',
                      onRetry: _refresh,
                    );
                  }
                  return _Dashboard(summary: snapshot.data!);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: SectionHeader(
                title: 'Quick actions',
                subtitle: 'Jump to the things you do most',
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            for (var i = 0; i < actions.length; i++)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: _QuickAction(
                  icon: actions[i].icon,
                  title: actions[i].title,
                  subtitle: actions[i].subtitle,
                  onTap: actions[i].onTap,
                  delay: i * 40,
                ),
              ),
            if (kDemoMode) ...[
              const SizedBox(height: AppSpacing.sm),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: SectionHeader(
                  title: 'Demo shortcuts',
                  subtitle: 'Server #9206568',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md),
                child: AppCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _demoTile(context, Icons.info_outline,
                          'Server detail',
                          Routes.serverDetailPath(9206568)),
                      _demoTile(context, Icons.bar_chart, 'Usage',
                          Routes.serverUsagePath(9206568)),
                      _demoTile(context, Icons.shield_outlined,
                          'IP whitelist',
                          Routes.serverWhitelistPath(9206568)),
                      _demoTile(
                          context,
                          Icons.local_fire_department_outlined,
                          'Firewall',
                          Routes.serverFirewallPath(9206568)),
                      _demoTile(context, Icons.key_outlined,
                          'Credentials',
                          Routes.serverCredentialsPath(9206568)),
                      _demoTile(
                          context,
                          Icons.settings_ethernet,
                          'Access port',
                          Routes.serverAccessPortPath(9206568)),
                      _demoTile(context, Icons.delete_outline,
                          'Destroy',
                          Routes.serverDestroyPath(9206568),
                          last: true),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _demoTile(
      BuildContext context, IconData icon, String title, String route,
      {bool last = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(icon, color: AppColors.textSecondary),
          title: Text(title, style: AppTypography.body),
          trailing:
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
          onTap: () => context.push(route),
        ),
        if (!last)
          const Divider(
            color: AppColors.line,
            height: 1,
            indent: 56,
          ),
      ],
    );
  }
}

class _ActionData {
  const _ActionData(this.icon, this.title, this.subtitle, this.onTap);

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    final s = summary.servers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _WalletCard(summary: summary),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.dns_outlined,
                label: 'Total',
                value: '${s.total}',
                onTap: () => context.push(Routes.servers),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatTile(
                icon: Icons.check_circle_outline,
                label: 'Active',
                value: '${s.active}',
                accentColor: AppColors.success,
                onTap: () => context.push(Routes.servers),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatTile(
                icon: Icons.hourglass_empty,
                label: 'Provisioning',
                value: '${s.provisioning}',
                accentColor: AppColors.warning,
                onTap: () => context.push(Routes.servers),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 300.ms).slideY(
            begin: 0.06, end: 0),
        if (s.other > 0) ...[
          const SizedBox(height: AppSpacing.sm),
          StatTile(
            icon: Icons.info_outline,
            label: 'Other states',
            value: '${s.other}',
            accentColor: AppColors.info,
            onTap: () => context.push(Routes.servers),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.06, end: 0),
        ],
        if ((summary.unreadNotifications ?? 0) > 0) ...[
          const SizedBox(height: AppSpacing.sm),
          _Chip(
            label:
                '${summary.unreadNotifications} unread notification(s) — notifications list is coming soon',
            bg: AppColors.pendingBg,
            fg: AppColors.pendingFg,
          ).animate().fadeIn(duration: 300.ms),
        ],
      ],
    );
  }
}

class _WalletCard extends StatelessWidget {
  const _WalletCard({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    final w = summary.wallet;
    return AppCard(
      gradientBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Wallet', style: AppTypography.title),
              const Spacer(),
              if ((summary.pendingTopups ?? 0) > 0)
                _Chip(
                  label:
                      '${summary.pendingTopups} pending top-up(s)',
                  bg: AppColors.pendingBg,
                  fg: AppColors.pendingFg,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            MoneyFormatter.usdString(w.availableUsd),
            style: AppTypography.display
                .copyWith(color: AppColors.accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Pending ${MoneyFormatter.usdString(w.pendingUsd)}'
            ' · Lifetime ${MoneyFormatter.usdString(w.lifetimeEarnedUsd)}',
            style: AppTypography.caption,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(
        begin: 0.06, end: 0);
  }
}

class _Chip extends StatelessWidget {
  const _Chip(
      {required this.label, required this.bg, required this.fg});

  final String label;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.delay = 0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final int delay;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child:
                Icon(icon, size: 20, color: AppColors.accent),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.title),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTypography.caption),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.textMuted),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.06, end: 0);
  }
}

class _DemoBanner extends StatelessWidget {
  const _DemoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.md,
        0,
      ),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.pendingBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: AppColors.pendingFg.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.science_outlined,
              color: AppColors.pendingFg),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'DEMO mode — sample data, no backend. '
              'Pass --dart-define=DEMO=false for the real API.',
              style: AppTypography.bodySecondary
                  .copyWith(color: AppColors.pendingFg),
            ),
          ),
        ],
      ),
    );
  }
}
