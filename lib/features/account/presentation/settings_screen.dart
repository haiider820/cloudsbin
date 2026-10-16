import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/auth_session.dart';

/// Phase 10 — settings hub: sessions, logout-all shortcut and coming-soon
/// stubs (wallet, tickets, notifications, terminal).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Account', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _tile(context, Icons.devices_outlined, 'Sessions',
              'Devices signed in to your account', Routes.sessions),
          _tile(context, Icons.lock_outline, 'Change password',
              'Coming soon', Routes.changePassword),
          const SizedBox(height: 16),
          Text('Wallet', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _tile(context, Icons.add_circle_outline, 'Top up wallet',
              'Coming soon', Routes.walletTopup),
          _tile(context, Icons.remove_circle_outline, 'Withdraw',
              'Coming soon', Routes.walletWithdraw),
          _tile(context, Icons.history, 'Wallet history', 'Coming soon',
              Routes.walletHistory),
          const SizedBox(height: 16),
          Text('Support', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _tile(context, Icons.support_agent_outlined, 'Support tickets',
              'Coming soon', Routes.tickets),
          _tile(context, Icons.notifications_outlined, 'Notifications',
              'Coming soon', Routes.notificationsList),
          _tile(context, Icons.terminal, 'Terminal / desktop',
              'Coming soon', Routes.terminal),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () async {
              try {
                await ref.read(authRepositoryProvider).logout();
              } catch (_) {
                // Local logout must succeed even if the API call fails.
              }
              await ref.read(sessionProvider.notifier).logoutLocal();
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
        ],
      ),
    );
  }

  ListTile _tile(BuildContext context, IconData icon, String title,
      String subtitle, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push(route),
    );
  }
}
