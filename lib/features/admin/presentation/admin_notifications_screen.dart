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
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/paginated_list.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_notification.dart';
import 'widgets/admin_widgets.dart';

/// `POST /admin/notifications/send` + `GET /admin/notifications/history`.
class AdminNotificationsScreen extends ConsumerStatefulWidget {
  const AdminNotificationsScreen({super.key});

  @override
  ConsumerState<AdminNotificationsScreen> createState() =>
      _AdminNotificationsScreenState();
}

class _AdminNotificationsScreenState
    extends ConsumerState<AdminNotificationsScreen> {
  final _title = TextEditingController();
  final _message = TextEditingController();
  final _userId = TextEditingController();
  String _target = 'all';
  bool _sending = false;
  int _tick = 0;

  @override
  void dispose() {
    _title.dispose();
    _message.dispose();
    _userId.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final title = _title.text.trim();
    final message = _message.text.trim();
    if (title.isEmpty || message.isEmpty) {
      showErrorSnackBar(
        context,
        const ApiError(
          code: 'VALIDATION',
          message: 'Title and message are required.',
        ),
      );
      return;
    }
    int? userId;
    if (_target == 'user') {
      userId = int.tryParse(_userId.text.trim());
      if (userId == null) {
        showErrorSnackBar(
          context,
          const ApiError(
            code: 'VALIDATION',
            message: 'Enter a valid user ID.',
          ),
        );
        return;
      }
    }
    setState(() => _sending = true);
    try {
      await ref.read(adminRepositoryProvider).sendNotification(
            title,
            message,
            _target,
            userId,
          );
      if (!mounted) return;
      showInfoSnackBar(context, 'Notification sent.');
      _title.clear();
      _message.clear();
      _userId.clear();
      setState(() => _tick++);
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Notifications')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: 'Send notification',
                    icon: Icons.campaign_outlined,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    controller: _title,
                    label: 'Title',
                    hint: 'Notification title',
                    prefixIcon: Icons.title,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AppTextField(
                    controller: _message,
                    label: 'Message',
                    hint: 'Notification body',
                    maxLines: 3,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Target', style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  AdminFilterChips(
                    values: const ['all', 'user'],
                    selected: _target,
                    labels: const {'all': 'All users', 'user': 'Specific user'},
                    onChanged: (v) => setState(() => _target = v),
                  ),
                  if (_target == 'user') ...[
                    const SizedBox(height: AppSpacing.sm),
                    AppTextField(
                      controller: _userId,
                      label: 'User ID',
                      hint: 'e.g. 900152',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  AppButton(
                    label: 'Send notification',
                    icon: Icons.send,
                    loading: _sending,
                    onPressed: _sending ? null : _send,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: SectionHeader(
              title: 'History',
              icon: Icons.history,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: PaginatedList<AdminNotification>(
              key: ValueKey('notifications|$_tick'),
              fetcher: (page) => ref
                  .read(adminRepositoryProvider)
                  .getNotificationHistory(page: page),
              itemBuilder: (context, n) => _NotificationTile(n: n),
              emptyState: const AppEmptyState(
                icon: Icons.notifications_none,
                title: 'No notifications sent yet',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.n});

  final AdminNotification n;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  n.title.isEmpty ? 'Notification #${n.id}' : n.title,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.title,
                ),
              ),
              AdminStatusPill(status: n.target),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(n.message, style: AppTypography.bodySecondary),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${n.recipientCount} recipient(s) · ${DateFormatter.isoToLocal(n.sentAt?.toIso8601String())}',
            style: AppTypography.caption,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 250.ms);
  }
}
