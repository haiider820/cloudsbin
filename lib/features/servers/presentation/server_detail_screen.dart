import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/enums/app_enums.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
import '../../../shared/widgets/status_chip.dart';
import '../data/models/power_action.dart';
import '../data/models/server_detail.dart';
import '../data/server_repository.dart';
import 'power_action_notifier.dart';

class ServerDetailScreen extends ConsumerStatefulWidget {
  const ServerDetailScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<ServerDetailScreen> createState() => _ServerDetailScreenState();
}

class _ServerDetailScreenState extends ConsumerState<ServerDetailScreen> {
  bool _refreshing = false;

  Future<void> _sync() async {
    setState(() => _refreshing = true);
    try {
      await ref.read(serverRepositoryProvider).refresh(widget.serverId);
      ref.invalidate(serverDetailProvider(widget.serverId));
      if (mounted) showInfoSnackBar(context, 'Synced with provider.');
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } catch (_) {
      if (mounted) {
        showErrorMessageSnackBar(
            context, 'Something went wrong. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _refreshing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(serverDetailProvider(widget.serverId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Server'),
        actions: [
          IconButton(
            tooltip: 'Sync with provider',
            onPressed: _refreshing ? null : _sync,
            icon: _refreshing
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.sync),
          ),
        ],
      ),
      body: detail.when(
        loading: () => const AppLoadingView(message: 'Loading server…'),
        error: (error, _) => AppErrorView(
          title: 'Could not load server',
          message: error is ApiError ? error.userMessage : 'Unexpected error.',
          retryLabel: 'Retry',
          onRetry: () =>
              ref.invalidate(serverDetailProvider(widget.serverId)),
        ),
        data: (server) => _DetailBody(server: server),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody({required this.server});

  final ServerDetail server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bandwidth = server.bandwidth;
    // Local optimistic power status (stopping/booting/rebooting) wins until
    // the scheduled detail refresh lands the provider's real status.
    final status =
        ref.watch(serverStatusOverrideProvider(server.id)) ?? server.status;

    return ListView(
      children: [
        HeroHeader(
          eyebrow: 'Server',
          title: server.name?.isNotEmpty == true
              ? server.name!
              : 'Server #${server.id}',
          subtitle: 'ID ${server.id}',
          icon: Icons.dns_outlined,
          trailing: StatusChip(status: status),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.xl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                gradientBorder: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Details',
                      icon: Icons.info_outline,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    InfoRow(
                      label: 'IP address',
                      value: server.ipAddress?.isNotEmpty == true
                          ? server.ipAddress!
                          : '—',
                      mono: true,
                    ),
                    InfoRow(
                      label: 'Access port',
                      value: server.accessPort?.toString() ?? '—',
                      mono: true,
                    ),
                    InfoRow(
                      label: 'Plan',
                      value: server.planName?.isNotEmpty == true
                          ? server.planName!
                          : '—',
                    ),
                    InfoRow(
                      label: 'Region',
                      value: server.region?.isNotEmpty == true
                          ? server.region!
                          : '—',
                    ),
                    InfoRow(
                      label: 'Operating system',
                      value: server.os?.isNotEmpty == true
                          ? server.os!
                          : '—',
                    ),
                    InfoRow(label: 'Specs', value: _specs(server) ?? '—'),
                    InfoRow(
                      label: 'Created',
                      value: DateFormatter.isoToLocal(
                        server.createdAt?.toIso8601String(),
                      ),
                    ),
                    InfoRow(
                      label: 'Activated',
                      value: DateFormatter.isoToLocal(
                        server.activatedAt?.toIso8601String(),
                      ),
                    ),
                    if (server.destroyedAt != null)
                      InfoRow(
                        label: 'Destroyed',
                        value: DateFormatter.isoToLocal(
                          server.destroyedAt?.toIso8601String(),
                        ),
                      ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              if (!server.status.isActive) ...[
                const SizedBox(height: AppSpacing.sm),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeader(
                        title: 'Provisioning',
                        icon: Icons.hourglass_bottom_outlined,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppRadius.pill),
                        child: LinearProgressIndicator(
                          value: ((server.progress ?? 0) / 100).clamp(0, 1),
                          minHeight: 6,
                          color: AppColors.accent,
                          backgroundColor: AppColors.bg3,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '${server.stage ?? 'Working'}'
                        '${server.progress != null ? ' · ${server.progress}%' : ''}'
                        '${server.etaSeconds != null ? ' · ETA ~${DateFormatter.countdown(server.etaSeconds!)}' : ''}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(duration: 300.ms)
                    .slideY(begin: 0.06, end: 0),
              ],
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(
                      title: 'Bandwidth',
                      icon: Icons.speed_outlined,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (bandwidth == null)
                      const Text(
                        'No bandwidth data available yet.',
                        style: AppTypography.caption,
                      )
                    else ...[
                      InfoRow(label: 'In', value: _gb(bandwidth.inGb) ?? '—'),
                      InfoRow(
                        label: 'Out',
                        value: _gb(bandwidth.outGb) ?? '—',
                      ),
                      InfoRow(
                        label: 'Total',
                        value: _gb(bandwidth.totalGb) ?? '—',
                      ),
                      InfoRow(
                        label: 'Resets on day',
                        value: bandwidth.resetDay?.toString() ?? '—',
                      ),
                    ],
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06, end: 0),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Manage',
                icon: Icons.settings_outlined,
              ),
              const SizedBox(height: AppSpacing.sm),
              _ActionsGrid(serverId: server.id),
              const SizedBox(height: AppSpacing.sm),
              _PowerCard(serverId: server.id, status: status),
            ],
          ),
        ),
      ],
    );
  }

  static String? _specs(ServerDetail server) {
    final parts = <String>[];
    if (server.vcpu != null) parts.add('${server.vcpu} vCPU');
    if (server.ramGb != null) parts.add('${server.ramGb} GB RAM');
    if (server.ssdGb != null) parts.add('${server.ssdGb} GB SSD');
    return parts.isEmpty ? null : parts.join(' · ');
  }

  static String? _gb(double? value) => value == null ? null : '$value GB';
}

class _ActionsGrid extends StatelessWidget {
  const _ActionsGrid({required this.serverId});

  final int serverId;

  @override
  Widget build(BuildContext context) {
    final items = <_ActionItem>[
      _ActionItem(
        Icons.bar_chart_outlined,
        'Usage',
        Routes.serverUsagePath(serverId),
        AppColors.accent,
      ),
      _ActionItem(
        Icons.key_outlined,
        'Credentials',
        Routes.serverCredentialsPath(serverId),
        AppColors.accentViolet,
      ),
      _ActionItem(
        Icons.shield_outlined,
        'IP whitelist',
        Routes.serverWhitelistPath(serverId),
        AppColors.success,
      ),
      _ActionItem(
        Icons.local_fire_department_outlined,
        'Firewall',
        Routes.serverFirewallPath(serverId),
        AppColors.warning,
      ),
      _ActionItem(
        Icons.settings_ethernet,
        'Access port',
        Routes.serverAccessPortPath(serverId),
        AppColors.info,
      ),
      _ActionItem(
        Icons.autorenew,
        'Regenerate',
        Routes.serverRegeneratePath(serverId),
        AppColors.accentViolet,
      ),
      _ActionItem(
        Icons.delete_outline,
        'Destroy',
        Routes.serverDestroyPath(serverId),
        AppColors.danger,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 2.1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final item in items)
          _ActionTile(
            item: item,
            onTap: () => context.go(item.route),
          ),
      ],
    );
  }
}

class _ActionItem {
  const _ActionItem(this.icon, this.label, this.route, this.accentColor);

  final IconData icon;
  final String label;
  final String route;
  final Color accentColor;
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.item, required this.onTap});

  final _ActionItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(item.icon, size: 22, color: item.accentColor),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              item.label,
              style: AppTypography.bodySecondary.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}

/// Stop / Start / Reboot controls backed by `POST /servers/power`.
class _PowerCard extends ConsumerWidget {
  const _PowerCard({required this.serverId, required this.status});

  final int serverId;
  final ServerStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // A destroyed server has no provider instance left to power-manage.
    if (status.isDestroyed) return const SizedBox.shrink();

    final power = ref.watch(powerActionProvider(serverId));
    final busy = power.isLoading;

    // Enablement rules per current status; transitional states label the card.
    final (bool stopEnabled, bool startEnabled, bool rebootEnabled,
        String? transition) = switch (status.raw) {
      'active' => (true, false, true, null),
      'stopped' => (false, true, false, null),
      'stopping' => (false, false, false, 'Stopping...'),
      'booting' => (false, false, false, 'Starting...'),
      'rebooting' => (false, false, false, 'Rebooting...'),
      _ => (false, false, false, null),
    };

    // 409 conflicts show inline — they never change the local status.
    final inlineError = power.isError &&
            (power.error!.code == 'SERVER_NOT_ACTIVE' ||
                power.error!.code == 'SERVER_NOT_STOPPED')
        ? power.error!.message
        : null;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Power', icon: Icons.power_settings_new),
          if (transition != null || inlineError != null) ...[
            const SizedBox(height: AppSpacing.sm),
            if (transition != null)
              Text(
                transition,
                style: AppTypography.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            if (inlineError != null) ...[
              if (transition != null) const SizedBox(height: AppSpacing.xs),
              Text(
                inlineError,
                style: AppTypography.caption.copyWith(color: AppColors.danger),
              ),
            ],
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Stop',
                  icon: Icons.stop_circle_outlined,
                  variant: AppButtonVariant.danger,
                  dense: true,
                  loading: power.isLoadingAction(PowerAction.stop),
                  onPressed: (!stopEnabled || busy)
                      ? null
                      : () => _run(context, ref, PowerAction.stop),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Start',
                  icon: Icons.play_circle_outlined,
                  variant: AppButtonVariant.primary,
                  dense: true,
                  loading: power.isLoadingAction(PowerAction.start),
                  onPressed: (!startEnabled || busy)
                      ? null
                      : () => _run(context, ref, PowerAction.start),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Reboot',
                  icon: Icons.restart_alt_outlined,
                  variant: AppButtonVariant.secondary,
                  dense: true,
                  loading: power.isLoadingAction(PowerAction.reboot),
                  onPressed: (!rebootEnabled || busy)
                      ? null
                      : () => _run(context, ref, PowerAction.reboot),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    PowerAction action,
  ) async {
    // Confirmation before the destructive calls; Start is non-destructive.
    if (action == PowerAction.stop) {
      final confirmed = await confirmDialog(
        context,
        title: 'Stop server?',
        message: 'It will become unreachable until started again.',
        confirmLabel: 'Stop Server',
        cancelLabel: 'Cancel',
        danger: true,
        icon: Icons.stop_circle_outlined,
      );
      if (!confirmed || !context.mounted) return;
    } else if (action == PowerAction.reboot) {
      final confirmed = await confirmDialog(
        context,
        title: 'Reboot server?',
        message: 'It will be briefly unreachable.',
        confirmLabel: 'Reboot',
        cancelLabel: 'Cancel',
        icon: Icons.restart_alt_outlined,
      );
      if (!confirmed || !context.mounted) return;
    }

    final state =
        await ref.read(powerActionProvider(serverId).notifier).perform(action);
    if (!state.isError || !context.mounted) return;

    final error = state.error!;
    switch (error.code) {
      case 'RATE_LIMITED':
        // 5/300s per server; countdown straight from Retry-After.
        showErrorMessageSnackBar(context,
            'Too many power actions. Wait ${error.retryAfterSeconds ?? 300}s.');
      case 'PROVIDER_ERROR':
        showErrorMessageSnackBar(
            context, 'Provider unreachable. Try again shortly.');
      case 'SERVER_NOT_ACTIVE':
      case 'SERVER_NOT_STOPPED':
        showErrorMessageSnackBar(context, error.message);
      default:
        showErrorSnackBar(context, error);
    }
  }
}
