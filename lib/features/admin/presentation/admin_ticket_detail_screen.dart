import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_ticket_detail.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/tickets/detail` — the thread plus reply/close/priority actions.
class AdminTicketDetailScreen extends ConsumerStatefulWidget {
  const AdminTicketDetailScreen({super.key, required this.ticketId});

  final int ticketId;

  @override
  ConsumerState<AdminTicketDetailScreen> createState() =>
      _AdminTicketDetailScreenState();
}

class _AdminTicketDetailScreenState
    extends ConsumerState<AdminTicketDetailScreen> {
  late Future<AdminTicketDetail> _future;
  final _replyController = TextEditingController();
  final _scrollController = ScrollController();
  bool _sending = false;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _future = ref.read(adminRepositoryProvider).getTicketDetail(widget.ticketId);
  }

  @override
  void dispose() {
    _replyController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _reload() {
    setState(() {
      _future =
          ref.read(adminRepositoryProvider).getTicketDetail(widget.ticketId);
    });
  }

  Future<void> _reply() async {
    final message = _replyController.text.trim();
    if (message.isEmpty) return;
    setState(() => _sending = true);
    try {
      await ref.read(adminRepositoryProvider).replyToTicket(
            widget.ticketId,
            message,
          );
      if (!mounted) return;
      _replyController.clear();
      showInfoSnackBar(context, 'Reply sent.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _close() async {
    final confirmed = await confirmDialog(
      context,
      title: 'Close this ticket?',
      message: 'The user will no longer be able to reply.',
      confirmLabel: 'Close ticket',
      danger: true,
      icon: Icons.archive_outlined,
    );
    if (!confirmed) return;
    setState(() => _busy = true);
    try {
      await ref.read(adminRepositoryProvider).closeTicket(widget.ticketId);
      if (!mounted) return;
      showInfoSnackBar(context, 'Ticket closed.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _setPriority(String priority) async {
    setState(() => _busy = true);
    try {
      await ref
          .read(adminRepositoryProvider)
          .setTicketPriority(widget.ticketId, priority);
      if (!mounted) return;
      showInfoSnackBar(context, 'Priority set to $priority.');
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
      appBar: AppBar(
        title: const Text('Ticket'),
        actions: [
          IconButton(
            tooltip: 'Close ticket',
            icon: const Icon(Icons.archive_outlined),
            onPressed: _busy ? null : _close,
          ),
        ],
      ),
      body: FutureBuilder<AdminTicketDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: AppShimmer(itemCount: 5, itemHeight: 60),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return AppErrorView(
              message: 'Could not load this ticket.',
              onRetry: _reload,
            );
          }
          final ticket = snapshot.data!;
          final isClosed = ticket.status.toLowerCase() == 'closed';
          return Column(
            children: [
              _TicketHeader(
                ticket: ticket,
                onPriorityChanged: _busy ? null : _setPriority,
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: ticket.messages.length,
                  itemBuilder: (context, index) =>
                      _MessageBubble(message: ticket.messages[index]),
                ),
              ),
              if (!isClosed)
                _ReplyBar(
                  controller: _replyController,
                  sending: _sending,
                  onSend: _reply,
                )
              else
                const Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'This ticket is closed.',
                    style: AppTypography.caption,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TicketHeader extends StatelessWidget {
  const _TicketHeader({required this.ticket, required this.onPriorityChanged});

  final AdminTicketDetail ticket;
  final ValueChanged<String>? onPriorityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.bg1,
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket.subject.isEmpty ? 'Ticket #${ticket.id}' : ticket.subject,
            style: AppTypography.title,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${ticket.userEmail ?? 'User #${ticket.userId}'} · #${ticket.id}',
            style: AppTypography.caption,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              AdminStatusPill(status: ticket.status),
              const SizedBox(width: AppSpacing.md),
              const Text('Priority', style: AppTypography.caption),
              const SizedBox(width: AppSpacing.xs),
              DropdownButton<String>(
                value: const ['urgent', 'high', 'normal', 'low']
                        .contains(ticket.priority.toLowerCase())
                    ? ticket.priority.toLowerCase()
                    : 'normal',
                dropdownColor: AppColors.bg2,
                underline: const SizedBox.shrink(),
                onChanged: onPriorityChanged == null
                    ? null
                    : (v) {
                        if (v != null) onPriorityChanged!(v);
                      },
                items: const [
                  DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
                  DropdownMenuItem(value: 'high', child: Text('High')),
                  DropdownMenuItem(value: 'normal', child: Text('Normal')),
                  DropdownMenuItem(value: 'low', child: Text('Low')),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final AdminTicketMessage message;

  @override
  Widget build(BuildContext context) {
    final isAdmin = message.sender.toLowerCase() == 'admin';
    return Align(
      alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: isAdmin ? AppColors.adminAccent : AppColors.bg2,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.md),
            topRight: const Radius.circular(AppRadius.md),
            bottomLeft: Radius.circular(isAdmin ? AppRadius.md : 2),
            bottomRight: Radius.circular(isAdmin ? 2 : AppRadius.md),
          ),
          border: isAdmin ? null : Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isAdmin ? 'Admin' : 'User',
              style: TextStyle(
                color: isAdmin ? Colors.white70 : AppColors.textSecondary,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.message,
              style: TextStyle(
                color: isAdmin ? Colors.white : AppColors.textPrimary,
                fontSize: 14.5,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormatter.isoToLocal(
                message.createdAt?.toIso8601String(),
              ),
              style: TextStyle(
                color: isAdmin ? Colors.white54 : AppColors.textMuted,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReplyBar extends StatelessWidget {
  const _ReplyBar({
    required this.controller,
    required this.sending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool sending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.sm,
      ),
      decoration: const BoxDecoration(
        color: AppColors.bg1,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'Type a reply…',
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          AppButton(
            label: 'Send',
            icon: Icons.send,
            dense: true,
            fullWidth: false,
            loading: sending,
            onPressed: sending ? null : onSend,
          ),
        ],
      ),
    );
  }
}
