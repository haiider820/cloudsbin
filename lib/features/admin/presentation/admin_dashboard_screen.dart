import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';

/// Phase 11 — admin shell. The v1 docs expose admin auth + `/admin/me` but
/// no management endpoints, so the dashboard stays an honest stub.
class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(adminAuthRepositoryProvider).logoutAll();
              await ref.read(adminSessionProvider.notifier).logoutLocal();
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ref.read(adminAuthRepositoryProvider).me(),
        builder: (context, snapshot) {
          final me = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.admin_panel_settings_outlined),
                  title: Text(me?['email']?.toString() ?? 'Admin'),
                  subtitle:
                      Text('role: ${me?['role']?.toString() ?? 'admin'}'),
                ),
              ),
              const SizedBox(height: 16),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Management endpoints are not in the v1 API yet. '
                    'Admins can sign in, refresh and sign out; dashboards, '
                    'user management and top-up approvals arrive in a later phase.',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  await ref.read(adminAuthRepositoryProvider).logoutAll();
                  await ref
                      .read(adminSessionProvider.notifier)
                      .logoutLocal();
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log out (all sessions)'),
              ),
            ],
          );
        },
      ),
    );
  }
}
