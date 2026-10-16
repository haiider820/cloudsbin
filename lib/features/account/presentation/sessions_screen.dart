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
import '../../../shared/widgets/error_snackbar.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/data/auth_session.dart';
import '../data/account_repository.dart';
import '../data/models/auth_session_info.dart';

/// Phase 10 — sessions. `GET /auth/sessions` (§2.6) plus revoke, logout and
/// logout-all (§6.6).
class SessionsScreen extends ConsumerStatefulWidget {
  const SessionsScreen({super.key});

  @override
  ConsumerState<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends ConsumerState<SessionsScreen> {
  List<AuthSessionInfo>? _sessions;
  bool _loading = true;
  Object? _loadError;
  final Set<int> _revoking = <int>{};
  bool _loggingOutAll = false;

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
      final paged = await ref.read(accountRepositoryProvider).sessions();
      if (!mounted) return;
      setState(() {
        _sessions = paged.items;
        _loading = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = e;
      });
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _revoke(AuthSessionInfo session) async {
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
    try {
      await ref.read(accountRepositoryProvider).revokeSession(session.id);
      if (!mounted) return;
      showInfoSnackBar(context, 'Session revoked.');
      await _load();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _revoking.remove(session.id));
    }
  }

  /// Kills every session in this audience, including this device; a local
  /// logout is mandatory afterwards.
  Future<void> _logoutAll() async {
    final confirm = await confirmDialog(
      context,
      danger: true,
      title: 'Sign out everywhere?',
      message:
          'Every device with your account will be signed out, including this one.',
      confirmLabel: 'Sign out everywhere',
      icon: Icons.logout_outlined,
    );
    if (confirm != true) return;
    setState(() => _loggingOutAll = true);
    try {
      final revoked = await ref.read(accountRepositoryProvider).logoutAll();
      await ref.read(authRepositoryProvider).logout();
      if (!mounted) return;
      showInfoSnackBar(
          context, 'Signed out of $revoked session(s).');
    } on ApiError catch (e) {
      await ref.read(authRepositoryProvider).logout();
      if (!mounted) return;
      showErrorSnackBar(context, e);
    } finally {
      await ref.read(sessionProvider.notifier).logoutLocal();
      if (mounted) setState(() => _loggingOutAll = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sessions')),
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
          subtitle: 'Signed in to your account',
        ),
        const SizedBox(height: AppSpacing.sm),
        if (sessions.isEmpty)
          const AppEmptyState(
            icon: Icons.devices_outlined,
            title: 'No sessions',
            message: 'No devices are signed in to your account.',
          )
        else
          ...sessions.map(
            (s) => Padding(
              padding:
                  const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _SessionCard(
                session: s,
                revoking: _revoking.contains(s.id),
                onRevoke: () => _revoke(s),
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        AppButton(
          label: 'Sign out everywhere',
          icon: Icons.logout,
          variant: AppButtonVariant.danger,
          loading: _loggingOutAll,
          onPressed: _loggingOutAll ? null : _logoutAll,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({
    required this.session,
    required this.revoking,
    required this.onRevoke,
  });

  final AuthSessionInfo session;
  final bool revoking;
  final VoidCallback onRevoke;

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
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius:
                  BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(
              s.platform == 'android'
                  ? Icons.phone_android
                  : Icons.devices_outlined,
              size: 20,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.deviceName ?? 'Session #${s.id}',
                  style: AppTypography.title,
                ),
                const SizedBox(height: 4),
                Text(
                  [
                    if (s.appVersion != null)
                      'v${s.appVersion}',
                    if (s.lastIp != null) s.lastIp,
                    'Last used ${DateFormatter.isoToLocal(s.lastUsedAt?.toIso8601String())}',
                  ].join(' · '),
                  style: AppTypography.mono.copyWith(
                    fontSize: 12.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          _trailing(),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(
        begin: 0.06, end: 0);
  }

  Widget _trailing() {
    if (session.current) {
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.activeBg,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
              color:
                  AppColors.activeFg.withValues(alpha: 0.35)),
        ),
        child: const Text(
          'This device',
          style: TextStyle(
            color: AppColors.activeFg,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
    if (revoking) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    return TextButton(
      style: TextButton.styleFrom(
          foregroundColor: AppColors.danger),
      onPressed: onRevoke,
      child: const Text('Revoke'),
    );
  }
}
