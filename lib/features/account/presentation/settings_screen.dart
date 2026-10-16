import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/auth_session.dart';

/// Phase 10 — settings hub: sessions, logout-all shortcut and coming-soon
/// stubs (wallet, tickets, notifications, terminal).
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(
      BuildContext context, WidgetRef ref) async {
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
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const SectionHeader(title: 'Account'),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.devices_outlined,
                  title: 'Sessions',
                  subtitle:
                      'Devices signed in to your account',
                  onTap: () => context.push(Routes.sessions),
                ),
                const Divider(
                  color: AppColors.line,
                  height: 1,
                  indent: 68,
                ),
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Change password',
                  subtitle: 'Coming soon',
                  onTap: () =>
                      context.push(Routes.changePassword),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Wallet'),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.add_circle_outline,
                  title: 'Top up wallet',
                  subtitle: 'Coming soon',
                  onTap: () => context.push(Routes.walletTopup),
                ),
                const Divider(
                  color: AppColors.line,
                  height: 1,
                  indent: 68,
                ),
                _SettingsTile(
                  icon: Icons.remove_circle_outline,
                  title: 'Withdraw',
                  subtitle: 'Coming soon',
                  onTap: () =>
                      context.push(Routes.walletWithdraw),
                ),
                const Divider(
                  color: AppColors.line,
                  height: 1,
                  indent: 68,
                ),
                _SettingsTile(
                  icon: Icons.history,
                  title: 'Wallet history',
                  subtitle: 'Coming soon',
                  onTap: () =>
                      context.push(Routes.walletHistory),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          const SectionHeader(title: 'Support'),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsTile(
                  icon: Icons.support_agent_outlined,
                  title: 'Support tickets',
                  subtitle: 'Coming soon',
                  onTap: () => context.push(Routes.tickets),
                ),
                const Divider(
                  color: AppColors.line,
                  height: 1,
                  indent: 68,
                ),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Coming soon',
                  onTap: () =>
                      context.push(Routes.notificationsList),
                ),
                const Divider(
                  color: AppColors.line,
                  height: 1,
                  indent: 68,
                ),
                _SettingsTile(
                  icon: Icons.terminal,
                  title: 'Terminal / desktop',
                  subtitle: 'Coming soon',
                  onTap: () => context.push(Routes.terminal),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Log out',
            icon: Icons.logout,
            variant: AppButtonVariant.danger,
            onPressed: () => _logout(context, ref),
          ),
          const SizedBox(height: AppSpacing.xl),
          const _AppVersion(),
          const SizedBox(height: AppSpacing.md),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.12),
                borderRadius:
                    BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(icon,
                  size: 20, color: AppColors.accent),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.title),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: AppTypography.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _AppVersion extends StatefulWidget {
  const _AppVersion();

  @override
  State<_AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<_AppVersion> {
  late final Future<String> _version;

  @override
  void initState() {
    super.initState();
    _version = _readVersion();
  }

  Future<String> _readVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return 'CloudsBin v${info.version} (${info.buildNumber})';
    } catch (_) {
      return 'CloudsBin';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _version,
      builder: (context, snapshot) => Center(
        child: Text(
          snapshot.data ?? 'CloudsBin',
          style: AppTypography.caption,
        ),
      ),
    );
  }
}
