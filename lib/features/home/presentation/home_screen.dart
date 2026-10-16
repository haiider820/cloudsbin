import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/demo/demo_mode.dart';
import '../../../core/router/routes.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/auth_session.dart';

/// Phase-2 placeholder. The full dashboard (GET /home) arrives in Phase 10.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authRepositoryProvider).logout();
    } catch (_) {
      // Local logout must succeed even if the API call fails.
    }
    await ref.read(sessionProvider.notifier).logoutLocal();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CloudsBin'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context, ref),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (kDemoMode) const _DemoBanner(),
          if (session.email != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('Signed in as ${session.email}'),
            ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dns_outlined),
                  title: const Text('Servers'),
                  subtitle: const Text('View and manage your servers'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go(Routes.servers),
                ),
              ],
            ),
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
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Server detail'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.serverDetailPath(9206568)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.bar_chart),
                    title: const Text('Usage'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.serverUsagePath(9206568)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.shield_outlined),
                    title: const Text('IP whitelist'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.serverWhitelistPath(9206568)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.key_outlined),
                    title: const Text('Credentials'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(Routes.serverCredentialsPath(9206568)),
                  ),
                ],
              ),
            ),
          ],
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text('Full dashboard coming in Phase 10.'),
          ),
        ],
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
