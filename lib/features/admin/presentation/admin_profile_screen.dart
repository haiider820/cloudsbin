import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/admin_auth_repository.dart';
import '../data/models/admin_profile.dart';

/// Admin profile — identity from `GET /admin/me`, shown with the admin
/// accent. Never linked from (or rendered in) the user app.
class AdminProfileScreen extends ConsumerStatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  ConsumerState<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends ConsumerState<AdminProfileScreen> {
  late Future<AdminProfile> _future;

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

  void _copy(String value, String message) {
    Clipboard.setData(ClipboardData(text: value));
    showInfoSnackBar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Admin Profile')),
      body: FutureBuilder<AdminProfile>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(message: 'Loading profile…');
          }
          if (snapshot.hasError) {
            return AppErrorView(
              message: 'Could not load the admin profile.',
              onRetry: _retry,
            );
          }
          final profile = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AppCard(
                gradientBorder: true,
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.adminAccent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppColors.adminAccent.withValues(alpha: 0.4),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.email,
                            style: AppTypography.mono,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.adminAccent
                                      .withValues(alpha: 0.16),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.pill),
                                  border: Border.all(
                                    color: AppColors.adminAccent
                                        .withValues(alpha: 0.55),
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
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Admin #${profile.id}',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    InfoRow(
                      label: 'Email',
                      value: profile.email,
                      mono: true,
                      trailing: IconButton(
                        tooltip: 'Copy email',
                        icon: const Icon(
                          Icons.copy,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () =>
                            _copy(profile.email, 'Email copied.'),
                      ),
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Role',
                      value: profile.role,
                      valueColor: AppColors.adminAccentLight,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Admin ID',
                      value: '#${profile.id}',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Member since',
                      value: DateFormatter.isoToLocal(
                        profile.createdAt?.toIso8601String(),
                      ),
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Referral code',
                      value: profile.referralCode ?? 'None',
                      mono: true,
                      trailing: profile.referralCode == null
                          ? null
                          : IconButton(
                              tooltip: 'Copy referral code',
                              icon: const Icon(
                                Icons.copy,
                                size: 20,
                                color: AppColors.textSecondary,
                              ),
                              onPressed: () => _copy(
                                profile.referralCode!,
                                'Referral code copied.',
                              ),
                            ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 80.ms)
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }
}
