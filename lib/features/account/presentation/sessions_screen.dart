import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/date_formatter.dart';
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
  final Set<int> _revoking = <int>{};
  bool _loggingOutAll = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final paged = await ref.read(accountRepositoryProvider).sessions();
      if (!mounted) return;
      setState(() {
        _sessions = paged.items;
        _loading = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _revoke(AuthSessionInfo session) async {
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign out everywhere?'),
        content: const Text(
            'Every device with your account will be signed out, including this one.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Sign out everywhere')),
        ],
      ),
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sessions')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if ((_sessions ?? []).isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('No sessions found.'),
                  )
                else
                  ..._sessions!.map((s) => Card(
                        child: ListTile(
                          leading: Icon(
                            s.platform == 'android'
                                ? Icons.phone_android
                                : Icons.devices_outlined,
                          ),
                          title: Text(s.deviceName ?? 'Session #${s.id}'),
                          subtitle: Text(
                            [
                              if (s.appVersion != null) 'v${s.appVersion}',
                              if (s.lastIp != null) s.lastIp,
                              'Last used ${DateFormatter.isoToLocal(s.lastUsedAt?.toIso8601String())}',
                            ].join(' · '),
                          ),
                          trailing: s.current
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'This device',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme
                                          .onPrimaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : (_revoking.contains(s.id)
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2))
                                  : TextButton(
                                      onPressed: () => _revoke(s),
                                      child: const Text('Revoke'),
                                    )),
                        ),
                      )),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _loggingOutAll ? null : _logoutAll,
                  icon: _loggingOutAll
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child:
                              CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.logout),
                  label: const Text('Sign out everywhere'),
                ),
              ],
            ),
    );
  }
}
