import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../data/models/order.dart';
import '../data/order_repository.dart';

/// Phase 8 — `GET /orders/list` (paginated). Shows status, plan,
/// server-computed total, and creation time.
class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            tooltip: 'Upload payment receipt',
            icon: const Icon(Icons.upload_file_outlined),
            onPressed: () => context.push(Routes.receiptUpload),
          ),
        ],
      ),
      body: PaginatedList<OrderItem>(
        fetcher: (page) =>
            ref.read(orderRepositoryProvider).orders(page: page),
        emptyState: const AppEmptyState(
          icon: Icons.receipt_long_outlined,
          title: 'No orders yet',
          message: 'Orders you place will appear here.',
        ),
        itemBuilder: (context, order) => _OrderCard(order: order),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderItem order;

  /// Same status mapping as before, now on the brand token tones:
  /// server_created → green, pending → amber, rejected → red,
  /// anything else → orange.
  (Color, Color) get _statusTones {
    switch (order.status.raw) {
      case 'server_created':
        return (AppColors.activeBg, AppColors.activeFg);
      case 'pending':
        return (AppColors.pendingBg, AppColors.pendingFg);
      case 'rejected':
        return (AppColors.dangerBg, AppColors.dangerFg);
      default:
        return (AppColors.attentionBg, AppColors.attentionFg);
    }
  }

  String get _statusLabel => order.status.raw
      .split('_')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _statusTones;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Order #${order.id}',
                  style: AppTypography.mono.copyWith(fontSize: 14.5),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  border: Border.all(color: fg.withValues(alpha: 0.35)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: fg,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _statusLabel,
                      style: TextStyle(
                        color: fg,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${order.planName ?? order.planSlug ?? '—'}'
            '${order.region != null ? ' · ${order.region}' : ''}',
            style: AppTypography.bodySecondary,
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.totalCents != null
                    ? MoneyFormatter.fromCents(order.totalCents!)
                    : '—',
                style: AppTypography.title.copyWith(
                  color: AppColors.accent,
                ),
              ),
              Text(
                DateFormatter.isoToLocal(
                    order.createdAt?.toIso8601String()),
                style: AppTypography.caption,
              ),
            ],
          ),
          if (order.serverId != null) ...[
            const Divider(height: AppSpacing.lg),
            InkWell(
              onTap: () =>
                  context.push(Routes.serverDetailPath(order.serverId!)),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.xxs,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.dns_outlined,
                        size: 16, color: AppColors.accent),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Server #${order.serverId}',
                      style: AppTypography.bodySecondary.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    const Icon(Icons.arrow_forward,
                        size: 14, color: AppColors.accent),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0);
  }
}
