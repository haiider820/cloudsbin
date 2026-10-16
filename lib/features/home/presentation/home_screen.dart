import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/demo/demo_mode.dart';
import '../../../core/router/routes.dart';
import '../../../shared/utils/money_formatter.dart';
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
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Local logout must succeed even if the API call fails.
    }
    await ref.read(sessionProvider.notifier).logoutLocal();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16),
          children: [
            if (kDemoMode) const _DemoBanner(),
            FutureBuilder<HomeSummary>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (snapshot.hasError) {
                  final err = snapshot.error;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(err is ApiError
                                ? err.userMessage
                                : 'Could not load the dashboard.'),
                          ),
                          TextButton(
                            onPressed: _refresh,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return _Dashboard(summary: snapshot.data!);
              },
            ),
            const SizedBox(height: 16),
            _NavCard(
              icon: Icons.dns_outlined,
              title: 'Servers',
              subtitle: 'View and manage your servers',
              onTap: () => context.push(Routes.servers),
            ),
            _NavCard(
              icon: Icons.inventory_2_outlined,
              title: 'Plans & ordering',
              subtitle: 'Browse plans, estimate, create a server',
              onTap: () => context.push(Routes.plans),
            ),
            _NavCard(
              icon: Icons.currency_bitcoin,
              title: 'Pay with crypto',
              subtitle: 'Checkout with a crypto asset',
              onTap: () => context.push(Routes.cryptoCheckout),
            ),
            _NavCard(
              icon: Icons.receipt_long_outlined,
              title: 'Orders',
              subtitle: 'Order history and receipts',
              onTap: () => context.push(Routes.orders),
            ),
            _NavCard(
              icon: Icons.person_outline,
              title: 'Profile',
              subtitle: 'Account details and referral code',
              onTap: () => context.push(Routes.profile),
            ),
            _NavCard(
              icon: Icons.devices_outlined,
              title: 'Sessions',
              subtitle: 'Devices signed in to your account',
              onTap: () => context.push(Routes.sessions),
            ),
            if (kDemoMode) ...[
              const SizedBox(height: 16),
              Text(
                'Demo shortcuts (server #9206568)',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    _demoTile(context, Icons.info_outline, 'Server detail',
                        Routes.serverDetailPath(9206568)),
                    _demoTile(context, Icons.bar_chart, 'Usage',
                        Routes.serverUsagePath(9206568)),
                    _demoTile(context, Icons.shield_outlined, 'IP whitelist',
                        Routes.serverWhitelistPath(9206568)),
                    _demoTile(context,
                        Icons.local_fire_department_outlined, 'Firewall',
                        Routes.serverFirewallPath(9206568)),
                    _demoTile(context, Icons.key_outlined, 'Credentials',
                        Routes.serverCredentialsPath(9206568)),
                    _demoTile(context, Icons.settings_ethernet, 'Access port',
                        Routes.serverAccessPortPath(9206568)),
                    _demoTile(context, Icons.delete_outline, 'Destroy',
                        Routes.serverDestroyPath(9206568)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  ListTile _demoTile(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = summary.servers;
    final w = summary.wallet;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Wallet', style: theme.textTheme.titleSmall),
                    const Spacer(),
                    if ((summary.pendingTopups ?? 0) > 0)
                      _Badge(
                          label: '${summary.pendingTopups} pending top-up(s)',
                          color: Colors.amber.shade800),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  MoneyFormatter.usdString(w.availableUsd),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pending ${MoneyFormatter.usdString(w.pendingUsd)}'
                  ' · Lifetime ${MoneyFormatter.usdString(w.lifetimeEarnedUsd)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
                child: _CountTile(
                    label: 'Total', value: s.total, icon: Icons.dns_outlined)),
            const SizedBox(width: 12),
            Expanded(
                child: _CountTile(
                    label: 'Active',
                    value: s.active,
                    icon: Icons.check_circle_outline,
                    color: Colors.green)),
            const SizedBox(width: 12),
            Expanded(
                child: _CountTile(
                    label: 'Provisioning',
                    value: s.provisioning,
                    icon: Icons.hourglass_empty,
                    color: Colors.amber.shade800)),
          ],
        ),
        if (s.other > 0) ...[
          const SizedBox(height: 12),
          _CountTile(
              label: 'Other states',
              value: s.other,
              icon: Icons.info_outline,
              color: Colors.orange),
        ],
        if ((summary.unreadNotifications ?? 0) > 0) ...[
          const SizedBox(height: 12),
          _Badge(
              label:
                  '${summary.unreadNotifications} unread notification(s) — notifications list is coming soon',
              color: theme.colorScheme.primary),
        ],
      ],
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile(
      {required this.label, required this.value, required this.icon, this.color});

  final String label;
  final int value;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color ?? theme.colorScheme.primary),
            const SizedBox(height: 4),
            Text('$value',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text(label, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _DemoBanner extends StatelessWidget {
  const _DemoBanner();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.science_outlined, color: scheme.onTertiaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'DEMO mode — sample data, no backend. '
              'Pass --dart-define=DEMO=false for the real API.',
              style: TextStyle(color: scheme.onTertiaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
