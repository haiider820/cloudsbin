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
import '../../../shared/widgets/status_chip.dart';
import '../data/admin_repository.dart';
import '../data/models/admin_server.dart';
import 'widgets/admin_widgets.dart';

/// `GET /admin/servers/detail` — full server info + force refresh/destroy.
class AdminServerDetailScreen extends ConsumerStatefulWidget {
  const AdminServerDetailScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<AdminServerDetailScreen> createState() =>
      _AdminServerDetailScreenState();
}

class _AdminServerDetailScreenState
    extends ConsumerState<AdminServerDetailScreen> {
  late Future<AdminServer> _future;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _future = ref.read(adminRepositoryProvider).getServerDetail(widget.serverId);
  }

  void _reload() {
    setState(() {
      _future =
          ref.read(adminRepositoryProvider).getServerDetail(widget.serverId);
    });
  }

  Future<void> _forceRefresh(AdminServer server) async {
    setState(() => _busy = true);
    try {
      await ref.read(adminRepositoryProvider).forceRefreshServer(server.id);
      if (!mounted) return;
      showInfoSnackBar(context, 'Server refreshed from provider.');
      _reload();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _forceDestroy(AdminServer server) async {
    final confirmed = await confirmDialog(
      context,
      title: 'Force destroy server?',
      message:
          'This immediately destroys server #${server.id} at the provider. '
          'It cannot be undone.',
      confirmLabel: 'Force destroy',
      danger: true,
      icon: Icons.warning_amber_outlined,
    );
    if (!confirmed || !mounted) return;
    setState(() => _busy = true);
    try {
      final performed = await runWithAdminReauth(
        context,
        ref,
        (grant) => ref.read(adminRepositoryProvider).forceDestroyServer(
              server.id,
              'Force-destroyed by admin',
              reauthToken: grant,
            ),
      );
      if (!performed || !mounted) return;
      showInfoSnackBar(context, 'Server force-destroyed.');
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
      appBar: AppBar(title: const Text('Server detail')),
      body: FutureBuilder<AdminServer>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: AppShimmer(itemCount: 3, itemHeight: 96),
            );
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return AppErrorView(
              message: 'Could not load this server.',
              onRetry: _reload,
            );
          }
          final server = snapshot.data!;
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              AppCard(
                gradientBorder: true,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        server.ipAddress ?? 'No IP',
                        style: AppTypography.mono.copyWith(fontSize: 17),
                      ),
                    ),
                    StatusChip(status: server.status),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  children: [
                    InfoRow(
                      label: 'Server ID',
                      value: '#${server.id}',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'User',
                      value: server.userEmail ?? 'User #${server.userId}',
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Plan',
                      value: server.planName ?? '—',
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(label: 'Region', value: server.region ?? '—'),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Provider',
                      value: server.providerSlug ?? '—',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'IP address',
                      value: server.ipAddress ?? '—',
                      mono: true,
                    ),
                    const Divider(color: AppColors.line, height: 1),
                    InfoRow(
                      label: 'Created',
                      value: DateFormatter.isoToLocal(
                        server.createdAt?.toIso8601String(),
                      ),
                    ),
                  ],
                ),
              )
                  .animate(delay: 60.ms)
                  .fadeIn(duration: 300.ms),
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Force refresh',
                icon: Icons.refresh,
                variant: AppButtonVariant.secondary,
                loading: _busy,
                onPressed: _busy ? null : () => _forceRefresh(server),
              ),
              const SizedBox(height: AppSpacing.sm),
              AppButton(
                label: 'Force destroy',
                icon: Icons.delete_forever_outlined,
                variant: AppButtonVariant.danger,
                onPressed: _busy ? null : () => _forceDestroy(server),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }
}
