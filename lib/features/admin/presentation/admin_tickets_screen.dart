import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_ticket.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/tickets` — support queue with priority + unread badges.
class AdminTicketsScreen extends ConsumerStatefulWidget {
  const AdminTicketsScreen({super.key});

  @override
  ConsumerState<AdminTicketsScreen> createState() => _AdminTicketsScreenState();
}

class _AdminTicketsScreenState extends ConsumerState<AdminTicketsScreen> {
  String _status = 'open';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Tickets')),
      body: Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          AdminFilterChips(
            values: const ['open', 'closed', 'all'],
            selected: _status,
            onChanged: (v) => setState(() => _status = v),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: PaginatedList<AdminTicket>(
              key: ValueKey('tickets|$_status'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getTickets(page: page, status: _status),
              itemBuilder: (context, ticket) => _TicketTile(ticket: ticket),
              emptyState: const AppEmptyState(
                icon: Icons.support_agent_outlined,
                title: 'No tickets',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TicketTile extends StatelessWidget {
  const _TicketTile({required this.ticket});

  final AdminTicket ticket;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push(Routes.adminTicketDetailPath(ticket.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  ticket.subject.isEmpty ? 'Ticket #${ticket.id}' : ticket.subject,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title,
                ),
              ),
              if (ticket.unreadCount > 0) ...[
                const SizedBox(width: AppSpacing.xs),
                _UnreadBadge(count: ticket.unreadCount),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              AdminStatusPill(status: ticket.status),
              const SizedBox(width: AppSpacing.xs),
              AdminPriorityPill(priority: ticket.priority),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            ticket.userEmail ?? 'User #${ticket.userId}',
            overflow: TextOverflow.ellipsis,
            style: AppTypography.caption,
          ),
          const SizedBox(height: 2),
          Text(
            'Last reply: ${DateFormatter.isoToLocal(ticket.lastReplyAt?.toIso8601String())}',
            style: AppTypography.caption,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
