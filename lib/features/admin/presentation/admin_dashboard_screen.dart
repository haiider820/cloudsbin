import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/hero_header.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';

/// Phase 11 — admin shell. The v1 docs expose admin auth + `/admin/me` but
/// no management endpoints, so the dashboard stays an honest stub: identity
/// card, the v1 limitation note, and all-sessions logout — now in the
/// premium dark tokens.
class AdminDashboardScreen extends ConsumerStatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  ConsumerState<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends ConsumerState<AdminDashboardScreen> {
  Future<void> _logoutAll() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Log out of all sessions?',
      message:
          'This ends every admin session on every device. You will need to sign in again.',
      confirmLabel: 'Log out',
      danger: true,
      icon: Icons.logout_outlined,
    );
    if (!confirmed) return;
    await ref.read(adminAuthRepositoryProvider).logoutAll();
    await ref.read(adminSessionProvider.notifier).logoutLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
            tooltip: 'Log out',
            icon: const Icon(Icons.logout_outlined),
            onPressed: _logoutAll,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: ref.read(adminAuthRepositoryProvider).me(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(
              message: 'Loading admin session…',
            );
          }
          if (snapshot.hasError) {
            final error = snapshot.error!;
            return AppErrorView(
              message: error is ApiError
                  ? error.userMessage
                  : error.toString(),
              onRetry: () => setState(() {}),
            );
          }

          final me = snapshot.data;
          final email = me?['email']?.toString() ?? 'Admin';
          final role = me?['role']?.toString() ?? 'admin';

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            children: [
              HeroHeader(
                eyebrow: 'Administration',
                title: 'Admin Console',
                subtitle: 'Signed in as $email',
                icon: Icons.admin_panel_settings_outlined,
              )
                  .animate()
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.sm,
                crossAxisSpacing: AppSpacing.sm,
                childAspectRatio: 1.4,
                children: [
                  StatTile(
                    icon: Icons.badge_outlined,
                    label: 'Role',
                    value: role,
                    accentColor: AppColors.accentViolet,
                  ),
                  const StatTile(
                    icon: Icons.verified_user_outlined,
                    label: 'Audience',
                    value: 'Admin',
                    accentColor: AppColors.success,
                  ),
                ],
              )
                  .animate(delay: 80.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Session',
                subtitle: 'Current admin session details',
                icon: Icons.key_outlined,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                gradientBorder: true,
                child: Column(
                  children: [
                    InfoRow(
                      label: 'Email',
                      value: email,
                      mono: true,
                    ),
                    const Divider(height: 1),
                    InfoRow(
                      label: 'Role',
                      value: role,
                      valueColor: AppColors.accentViolet,
                    ),
                    const Divider(height: 1),
                    const InfoRow(
                      label: 'Audience',
                      value: 'Admin',
                      valueColor: AppColors.success,
                    ),
                  ],
                ),
              )
                  .animate(delay: 140.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Management',
                subtitle: 'Available in a later phase',
                icon: Icons.dashboard_customize_outlined,
              ),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.info,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Management endpoints are not in the v1 API yet. '
                        'Admins can sign in, refresh and sign out; '
                        'dashboards, user management and top-up approvals '
                        'arrive in a later phase.',
                        style: AppTypography.bodySecondary,
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 200.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: 'Log out (all sessions)',
                icon: Icons.logout_outlined,
                variant: AppButtonVariant.danger,
                onPressed: _logoutAll,
              )
                  .animate(delay: 260.ms)
                  .fadeIn(duration: 350.ms)
                  .slideY(begin: 0.05, end: 0, curve: Curves.easeOut),
            ],
          );
        },
      ),
    );
  }
}
