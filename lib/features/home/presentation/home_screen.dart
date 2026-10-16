import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          const Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text('Full dashboard coming in Phase 10.'),
          ),
        ],
      ),
    );
  }
}
