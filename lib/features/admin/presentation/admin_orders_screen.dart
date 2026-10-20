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
import '../data/models/admin_order.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/orders` — approve/reject pending orders inline.
class AdminOrdersScreen extends ConsumerStatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  ConsumerState<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends ConsumerState<AdminOrdersScreen> {
  String _status = 'pending';
  int _tick = 0;

  Future<void> _approve(AdminOrder order) async {
    final note = await adminTextPrompt(
      context,
      title: 'Approve order #${order.id}',
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
        (grant) => ref.read(adminRepositoryProvider).approveOrder(
              order.id,
              note.isEmpty ? null : note,
              reauthToken: grant,
            ),
      );
      if (!performed || !mounted) return;
      showInfoSnackBar(context, 'Order #${order.id} approved.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  Future<void> _reject(AdminOrder order) async {
    final reason = await adminTextPrompt(
      context,
      title: 'Reject order #${order.id}',
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
        (grant) => ref.read(adminRepositoryProvider).rejectOrder(
              order.id,
              reason,
              reauthToken: grant,
            ),
      );
      if (!performed || !mounted) return;
      showInfoSnackBar(context, 'Order #${order.id} rejected.');
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Orders')),
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
            child: PaginatedList<AdminOrder>(
              key: ValueKey('orders|$_status|$_tick'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getOrders(page: page, status: _status),
              itemBuilder: (context, order) => _OrderTile(
                order: order,
                onApprove: () => _approve(order),
                onReject: () => _reject(order),
              ),
              emptyState: const AppEmptyState(
                icon: Icons.receipt_long_outlined,
                title: 'No orders here',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({
    required this.order,
    required this.onApprove,
    required this.onReject,
  });

  final AdminOrder order;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final isPending = order.status.toLowerCase() == 'pending';
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Order #${order.id}',
                  style: AppTypography.title,
                ),
              ),
              Text(
                MoneyFormatter.fromCents(order.totalCents),
                style: AppTypography.mono.copyWith(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              AdminStatusPill(status: order.status),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  order.userEmail ?? 'User #${order.userId}',
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${order.planName ?? '—'} · ${DateFormatter.isoToLocal(order.createdAt?.toIso8601String())}',
            style: AppTypography.caption,
          ),
          if (order.hasReceipt && order.receiptUrl != null) ...[
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'View receipt',
              icon: Icons.receipt_outlined,
              variant: AppButtonVariant.ghost,
              dense: true,
              fullWidth: false,
              onPressed: () => adminOpenUrl(context, order.receiptUrl!),
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
                    variant: AppButtonVariant.primary,
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
