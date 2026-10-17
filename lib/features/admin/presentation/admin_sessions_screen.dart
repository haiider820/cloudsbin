import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/admin_auth_repository.dart';
import '../data/models/admin_session.dart';

/// Admin sessions — `GET /admin/auth/sessions` plus revoke. The current
/// session cannot be revoked from here (use "Log out" instead).
class AdminSessionsScreen extends ConsumerStatefulWidget {
  const AdminSessionsScreen({super.key});

  @override
  ConsumerState<AdminSessionsScreen> createState() =>
      _AdminSessionsScreenState();
}

class _AdminSessionsScreenState extends ConsumerState<AdminSessionsScreen> {
  List<AdminSession>? _sessions;
  bool _loading = true;
  Object? _loadError;
  final Set<int> _revoking = <int>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final paged = await ref.read(adminAuthRepositoryProvider).getSessions();
      if (!mounted) return;
      setState(() => _sessions = paged.items);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loadError = e);
      showErrorSnackBar(context, e);
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadError = const ApiError(
            code: 'CLIENT_ERROR',
            message: 'Something went wrong. Please try again.',
          ));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _revoke(AdminSession session) async {
    final confirm = await confirmDialog(
      context,
      danger: true,
      title: 'Revoke session?',
      message:
          '${session.deviceName ?? 'Session #${session.id}'} will be signed out immediately.',
      confirmLabel: 'Revoke',
      icon: Icons.devices_outlined,
    );
    if (confirm != true) return;
    setState(() => _revoking.add(session.id));
    var removed = false;
    try {
      await ref.read(adminAuthRepositoryProvider).revokeSession(session.id);
      removed = true;
      if (mounted) showInfoSnackBar(context, 'Session revoked.');
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.code == 'NOT_FOUND') {
        // Already revoked elsewhere — the list is simply stale.
        removed = true;
        showInfoSnackBar(context, 'Session was already revoked.');
      } else {
        showErrorSnackBar(context, e);
      }
    } catch (_) {
      if (mounted) {
        showErrorMessageSnackBar(
            context, 'Something went wrong. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _revoking.remove(session.id);
          if (removed) {
            _sessions?.removeWhere((s) => s.id == session.id);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(title: const Text('Admin Sessions')),
      body: _loading
          ? const AppLoadingView(message: 'Loading sessions…')
          : _sessions == null
              ? AppErrorView(
                  message: _loadError is ApiError
                      ? (_loadError! as ApiError).userMessage
                      : 'Could not load sessions.',
                  onRetry: _load,
                )
              : _buildList(),
    );
  }

  Widget _buildList() {
    final sessions = _sessions!;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const SectionHeader(
          title: 'Devices',
          subtitle: 'Signed in to the admin portal',
        ),
        const SizedBox(height: AppSpacing.sm),
        if (sessions.isEmpty)
          const AppEmptyState(
            icon: Icons.devices_outlined,
            title: 'No sessions',
            message: 'No devices are signed in to the admin portal.',
          )
        else
          ...sessions.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _AdminSessionCard(
                session: s,
                revoking: _revoking.contains(s.id),
                onRevoke: () => _revoke(s),
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'To end this device\u2019s session, use Log out on the dashboard.',
          textAlign: TextAlign.center,
          style: AppTypography.caption.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

/// "5m ago" style relative time — compact, no locale table needed.
String _relativeTime(DateTime? utc) {
  if (utc == null) return 'unknown';
  var diff = DateTime.now().toUtc().difference(utc.toUtc());
  if (diff.isNegative) diff = Duration.zero;
  final seconds = diff.inSeconds;
  if (seconds < 60) return 'just now';
  if (seconds < 3600) return '${diff.inMinutes}m ago';
  if (seconds < 86400) return '${diff.inHours}h ago';
  if (seconds < 86400 * 30) return '${diff.inDays}d ago';
  return utc.toLocal().toString().split(' ').first;
}

class _AdminSessionCard extends StatelessWidget {
  const _AdminSessionCard({
    required this.session,
    required this.revoking,
    required this.onRevoke,
  });

  final AdminSession session;
  final bool revoking;
  final VoidCallback onRevoke;

  IconData get _platformIcon {
    switch (session.platform) {
      case 'android':
        return Icons.phone_android;
      case 'ios':
        return Icons.phone_iphone;
      default:
        return Icons.devices_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = session;
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.adminAccent.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              _platformIcon,
              size: 20,
              color: AppColors.adminAccentLight,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        s.deviceName ?? 'Session #${s.id}',
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.title,
                      ),
                    ),
                    if (s.current) ...[
                      const SizedBox(width: AppSpacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.activeBg,
                          borderRadius:
                              BorderRadius.circular(AppRadius.pill),
                          border: Border.all(
                            color:
                                AppColors.activeFg.withValues(alpha: 0.35),
                          ),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            color: AppColors.activeFg,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  [
                    if (s.appVersion != null) 'v${s.appVersion}',
                    if (s.platform != null) s.platform,
                    'Last used ${_relativeTime(s.lastUsedAt)}',
                  ].join(' · '),
                  style: AppTypography.mono.copyWith(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (s.lastIp != null)
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: s.lastIp!));
                      showInfoSnackBar(context, 'IP copied.');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        'IP ${s.lastIp}',
                        style: AppTypography.mono.copyWith(
                          fontSize: 12.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          _trailing(),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0);
  }

  Widget _trailing() {
    if (session.current) {
      return const Padding(
        padding: EdgeInsets.only(top: 6),
        child: Tooltip(
          message: 'This device — use Log out instead.',
          child: Icon(
            Icons.lock_outline,
            size: 18,
            color: AppColors.textMuted,
          ),
        ),
      );
    }
    if (revoking) {
      return const Padding(
        padding: EdgeInsets.only(top: 8),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: AppColors.danger),
      onPressed: onRevoke,
      child: const Text('Revoke'),
    );
  }
}
