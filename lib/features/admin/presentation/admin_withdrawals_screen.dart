import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_withdrawal.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/withdrawals` — review pending withdrawal requests.
class AdminWithdrawalsScreen extends ConsumerStatefulWidget {
  const AdminWithdrawalsScreen({super.key});

  @override
  ConsumerState<AdminWithdrawalsScreen> createState() =>
      _AdminWithdrawalsScreenState();
}

class _AdminWithdrawalsScreenState
    extends ConsumerState<AdminWithdrawalsScreen> {
  String _status = 'pending';
  int _tick = 0;

  Future<void> _approve(AdminWithdrawal w) async {
    final note = await adminTextPrompt(
      context,
      title: 'Approve withdrawal #${w.id}',
      hint: 'Optional note',
      confirmLabel: 'Approve',
      required: false,
    );
    if (note == null) return;
    if (!mounted) return;
    try {
      final performed = await runWithAdminReauth(
        context,
        ref,
        (grant) => ref.read(adminRepositoryProvider).approveWithdrawal(
              w.id,
              note.isEmpty ? null : note,
              reauthToken: grant,
            ),
      );
      if (!performed || !mounted) return;
      showInfoSnackBar(context, 'Withdrawal #${w.id} approved.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _reject(AdminWithdrawal w) async {
    final reason = await adminTextPrompt(
      context,
      title: 'Reject withdrawal #${w.id}',
      hint: 'Reason for rejection',
      confirmLabel: 'Reject',
      danger: true,
    );
    if (reason == null) return;
    if (!mounted) return;
    try {
      final performed = await runWithAdminReauth(
        context,
        ref,
        (grant) => ref.read(adminRepositoryProvider).rejectWithdrawal(
              w.id,
              reason,
              reauthToken: grant,
            ),
      );
      if (!performed || !mounted) return;
      showInfoSnackBar(context, 'Withdrawal #${w.id} rejected.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Withdrawals')),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          AdminFilterChips(
            values: const ['pending', 'approved', 'rejected', 'all'],
            selected: _status,
            onChanged: (v) => setState(() => _status = v),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: PaginatedList<AdminWithdrawal>(
              key: ValueKey('withdrawals|$_status|$_tick'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getWithdrawals(page: page, status: _status),
              itemBuilder: (context, w) => _WithdrawalTile(
                withdrawal: w,
                onApprove: () => _approve(w),
                onReject: () => _reject(w),
              ),
              emptyState: const AppEmptyState(
                icon: Icons.payments_outlined,
                title: 'No withdrawal requests',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WithdrawalTile extends StatelessWidget {
  const _WithdrawalTile({
    required this.withdrawal,
    required this.onApprove,
    required this.onReject,
  });

  final AdminWithdrawal withdrawal;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final w = withdrawal;
    final isPending = w.status.toLowerCase() == 'pending';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                MoneyFormatter.usdString(w.amountUsd),
                style: AppTypography.mono.copyWith(fontSize: 17),
              ),
              const SizedBox(width: AppSpacing.xs),
              AdminStatusPill(status: w.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            w.userEmail ?? 'User #${w.userId}',
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${w.method ?? '—'}: ${w.accountDetails ?? '—'}',
                  style: AppTypography.mono.copyWith(fontSize: 12.5),
                ),
              ),
              IconButton(
                tooltip: 'Copy account details',
                icon: const Icon(
                  Icons.copy,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                onPressed: w.accountDetails == null
                    ? null
                    : () {
                        Clipboard.setData(
                          ClipboardData(text: w.accountDetails!),
                        );
                        showInfoSnackBar(context, 'Account details copied.');
                      },
              ),
            ],
          ),
          Text(
            DateFormatter.isoToLocal(w.createdAt?.toIso8601String()),
            style: AppTypography.caption,
          ),
          if (isPending) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Approve',
                    icon: Icons.check,
                    dense: true,
                    onPressed: onApprove,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: AppButton(
                    label: 'Reject',
                    icon: Icons.close,
                    variant: AppButtonVariant.danger,
                    dense: true,
                    onPressed: onReject,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
