import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
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
        emptyState: const EmptyState(
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

  Color _statusColor(BuildContext context) {
    switch (order.status.raw) {
      case 'server_created':
        return Colors.green;
      case 'pending':
        return Colors.amber.shade800;
      case 'rejected':
        return Theme.of(context).colorScheme.error;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order #${order.id}',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor(context).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status.raw.replaceAll('_', ' '),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: _statusColor(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${order.planName ?? order.planSlug ?? '—'}'
              '${order.region != null ? ' · ${order.region}' : ''}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.totalCents != null
                      ? MoneyFormatter.fromCents(order.totalCents!)
                      : '—',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  DateFormatter.isoToLocal(
                      order.createdAt?.toIso8601String()),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
            if (order.serverId != null) ...[
              const SizedBox(height: 8),
              InkWell(
                onTap: () =>
                    context.push(Routes.serverDetailPath(order.serverId!)),
                child: Row(
                  children: [
                    Icon(Icons.dns_outlined,
                        size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Server #${order.serverId}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
