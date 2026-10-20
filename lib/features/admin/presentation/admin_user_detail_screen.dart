import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_user_detail.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/users/detail` — profile, wallet adjust, ban/unban, role change.
class AdminUserDetailScreen extends ConsumerStatefulWidget {
  const AdminUserDetailScreen({super.key, required this.userId});

  final int userId;

  @override
  ConsumerState<AdminUserDetailScreen> createState() =>
      _AdminUserDetailScreenState();
}

class _AdminUserDetailScreenState
    extends ConsumerState<AdminUserDetailScreen> {
  late Future<AdminUserDetail> _future;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _future = ref.read(adminRepositoryProvider).getUserDetail(widget.userId);
  }

  void _reload() {
    setState(() {
      _future = ref.read(adminRepositoryProvider).getUserDetail(widget.userId);
    });
  }

  Future<void> _toggleActive(AdminUserDetail user) async {
    final confirmed = await confirmDialog(
      context,
      title: user.isActive ? 'Ban this user?' : 'Unban this user?',
      message: user.isActive
          ? 'The account will be deactivated and can no longer sign in.'
          : 'The account will be reactivated.',
      confirmLabel: user.isActive ? 'Ban' : 'Unban',
      danger: user.isActive,
      icon: user.isActive ? Icons.block : Icons.check_circle_outline,
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await ref
          .read(adminRepositoryProvider)
          .toggleUserActive(user.id, !user.isActive);
      if (!mounted) return;
      showInfoSnackBar(context, user.isActive ? 'User banned.' : 'User unbanned.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _changeRole(AdminUserDetail user) async {
    final role = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.bg1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Change role', style: AppTypography.title),
            const SizedBox(height: AppSpacing.sm),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('User'),
              trailing: user.role == 'user'
                  ? const Icon(Icons.check, color: AppColors.adminAccent)
                  : null,
              onTap: () => Navigator.of(context).pop('user'),
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text('Admin'),
              trailing: user.role == 'admin'
                  ? const Icon(Icons.check, color: AppColors.adminAccent)
                  : null,
              onTap: () => Navigator.of(context).pop('admin'),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
    if (role == null || role == user.role) return;
    setState(() => _busy = true);
    try {
      await ref.read(adminRepositoryProvider).changeUserRole(user.id, role);
      if (!mounted) return;
      showInfoSnackBar(context, 'Role changed to $role.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _adjustWallet(AdminUserDetail user) async {
    final result = await showModalBottomSheet<(double, String)>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) => const _AdjustWalletSheet(),
    );
    if (result == null) return;
    if (!mounted) return;
    setState(() => _busy = true);
    try {
      String? message;
      final performed = await runWithAdminReauth(context, ref, (grant) async {
        message = await ref.read(adminRepositoryProvider).adjustWallet(
              user.id,
              result.$1,
              result.$2,
              reauthToken: grant,
            );
      });
      if (!performed || !mounted) return;
      showInfoSnackBar(context, message ?? 'Wallet adjusted.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('User detail')),
      body: FutureBuilder<AdminUserDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: AppShimmer(itemCount: 4, itemHeight: 96),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return AppErrorView(
              message: 'Could not load this user.',
              onRetry: _reload,
            );
          }
          final user = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AppCard(
                gradientBorder: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            user.email,
                            style: AppTypography.title,
                          ),
                        ),
                        AdminStatusPill(status: user.role),
                        const SizedBox(width: AppSpacing.xs),
                        AdminStatusPill(
                          status: user.isActive ? 'active' : 'banned',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: InfoRow(
                            label: 'Wallet',
                            value: user.walletBalanceUsd ?? '—',
                            mono: true,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: InfoRow(
                            label: 'Lifetime spent',
                            value: user.lifetimeSpentUsd ?? '—',
                            mono: true,
                          ),
                        ),
                      ],
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
                    InfoRow(label: 'User ID', value: '#${user.id}', mono: true),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(label: 'Servers', value: '${user.serverCount}'),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(label: 'Tickets', value: '${user.ticketCount}'),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Referral code',
                      value: user.referralCode ?? 'None',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Referred by',
                      value: user.referredByUserId?.toString() ?? 'None',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Last login',
                      value: DateFormatter.isoToLocal(
                        user.lastLoginAt?.toIso8601String(),
                      ),
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Last login IP',
                      value: user.lastLoginIp ?? '—',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Member since',
                      value: DateFormatter.isoToLocal(
                        user.createdAt?.toIso8601String(),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 60.ms)
                  .fadeIn(duration: 300.ms),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Adjust wallet',
                icon: Icons.account_balance_wallet_outlined,
                onPressed: _busy ? null : () => _adjustWallet(user),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Change role',
                      icon: Icons.manage_accounts_outlined,
                      variant: AppButtonVariant.secondary,
                      loading: _busy,
                      onPressed: _busy ? null : () => _changeRole(user),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: AppButton(
                      label: user.isActive ? 'Ban' : 'Unban',
                      icon: user.isActive
                          ? Icons.block
                          : Icons.check_circle_outline,
                      variant: user.isActive
                          ? AppButtonVariant.danger
                          : AppButtonVariant.secondary,
                      onPressed: _busy ? null : () => _toggleActive(user),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }
}

class _AdjustWalletSheet extends StatefulWidget {
  const _AdjustWalletSheet();

  @override
  State<_AdjustWalletSheet> createState() => _AdjustWalletSheetState();
}

class _AdjustWalletSheetState extends State<_AdjustWalletSheet> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  void _submit() {
    final value = double.tryParse(_amount.text.trim());
    if (value == null || value == 0) {
      setState(() => _error = 'Enter a non-zero amount (negative to debit).');
      return;
    }
    if (_note.text.trim().isEmpty) {
      setState(() => _error = 'A note is required.');
      return;
    }
    Navigator.of(context).pop((value, _note.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Adjust wallet', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _amount,
            label: 'Amount (USD)',
            hint: 'e.g. 25.00 or -10.00',
            prefixIcon: Icons.attach_money,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppTextField(
            controller: _note,
            label: 'Note',
            hint: 'Reason for the adjustment',
            prefixIcon: Icons.notes_outlined,
            errorText: _error,
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: 'Apply adjustment',
            icon: Icons.check,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
