import 'package:flutter/material.dart';
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
import '../data/models/admin_topup.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/topups` — review manual wallet top-up requests.
class AdminTopupsScreen extends ConsumerStatefulWidget {
  const AdminTopupsScreen({super.key});

  @override
  ConsumerState<AdminTopupsScreen> createState() => _AdminTopupsScreenState();
}

class _AdminTopupsScreenState extends ConsumerState<AdminTopupsScreen> {
  String _status = 'pending';
  int _tick = 0;

  Future<void> _approve(AdminTopup topup) async {
    final note = await adminTextPrompt(
      context,
      title: 'Approve top-up #${topup.id}',
      hint: 'Optional note',
      confirmLabel: 'Approve',
      required: false,
    );
    if (note == null) return;
    try {
      await ref
          .read(adminRepositoryProvider)
          .approveTopup(topup.id, note.isEmpty ? null : note);
      if (!mounted) return;
      showInfoSnackBar(context, 'Top-up #${topup.id} approved.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _reject(AdminTopup topup) async {
    final reason = await adminTextPrompt(
      context,
      title: 'Reject top-up #${topup.id}',
      hint: 'Reason for rejection',
      confirmLabel: 'Reject',
      danger: true,
    );
    if (reason == null) return;
    try {
      await ref.read(adminRepositoryProvider).rejectTopup(topup.id, reason);
      if (!mounted) return;
      showInfoSnackBar(context, 'Top-up #${topup.id} rejected.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Top-ups')),
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
            child: PaginatedList<AdminTopup>(
              key: ValueKey('topups|$_status|$_tick'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getTopups(page: page, status: _status),
              itemBuilder: (context, topup) => _TopupTile(
                topup: topup,
                onApprove: () => _approve(topup),
                onReject: () => _reject(topup),
              ),
              emptyState: const AppEmptyState(
                icon: Icons.account_balance_wallet_outlined,
                title: 'No top-up requests',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopupTile extends StatelessWidget {
  const _TopupTile({
    required this.topup,
    required this.onApprove,
    required this.onReject,
  });

  final AdminTopup topup;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final isPending = topup.status.toLowerCase() == 'pending';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                MoneyFormatter.usdString(topup.amountUsd),
                style: AppTypography.mono.copyWith(fontSize: 17),
              ),
              const SizedBox(width: AppSpacing.xs),
              AdminStatusPill(status: topup.status),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            topup.userEmail ?? 'User #${topup.userId}',
            overflow: TextOverflow.ellipsis,
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: 2),
          Text(
            '${topup.method ?? '—'} · ${DateFormatter.isoToLocal(topup.createdAt?.toIso8601String())}',
            style: AppTypography.caption,
          ),
          if (topup.receiptUrl != null) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'View receipt',
              icon: Icons.receipt_outlined,
              variant: AppButtonVariant.ghost,
              dense: true,
              fullWidth: false,
              onPressed: () => adminOpenUrl(context, topup.receiptUrl!),
            ),
          ],
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
