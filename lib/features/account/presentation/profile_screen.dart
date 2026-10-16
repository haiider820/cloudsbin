import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/account_repository.dart';
import '../data/models/user_profile.dart';

/// Phase 10 — profile and referral code. `GET /me` (§6.9).
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late Future<UserProfile> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(accountRepositoryProvider).me();
  }

  void _retry() {
    setState(() {
      _future = ref.read(accountRepositoryProvider).me();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: FutureBuilder<UserProfile>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(
                message: 'Loading profile…');
          }
          if (snapshot.hasError) {
            return AppErrorView(
              message: 'Could not load your profile.',
              onRetry: _retry,
            );
          }
          return _ProfileBody(profile: snapshot.data!);
        },
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _ProfileHero(profile: profile)
            .animate()
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            children: [
              InfoRow(
                label: 'Member since',
                value: DateFormatter.isoToLocal(
                    profile.createdAt?.toIso8601String()),
              ),
              const Divider(color: AppColors.line, height: 1),
              InfoRow(
                label: 'Referral code',
                value: profile.referralCode ?? 'Not available',
                mono: true,
                trailing: profile.referralCode == null
                    ? null
                    : IconButton(
                        tooltip: 'Copy referral code',
                        icon: const Icon(Icons.copy,
                            size: 20,
                            color: AppColors.textSecondary),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                              text: profile.referralCode!));
                          showInfoSnackBar(
                              context, 'Referral code copied.');
                        },
                      ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 300.ms)
            .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(title: 'Account security'),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Change password',
          icon: Icons.lock_outline,
          variant: AppButtonVariant.secondary,
          onPressed: () => context.push(Routes.changePassword),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Sessions',
          icon: Icons.devices_outlined,
          variant: AppButtonVariant.secondary,
          onPressed: () => context.push(Routes.sessions),
        ),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final initial = profile.email.isNotEmpty
        ? profile.email[0].toUpperCase()
        : '?';
    return AppCard(
      gradientBorder: true,
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: AppColors.brandGradient,
              shape: BoxShape.circle,
            ),
            child: Text(
              initial,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.onAccent,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.email,
                    style: AppTypography.mono),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'User #${profile.id} · ${profile.role}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
