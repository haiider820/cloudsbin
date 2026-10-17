import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/byte_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/models/server_usage.dart';
import '../data/server_repository.dart';

/// `GET /servers/usage?id=` with a `force=1` bypass (§6.19).
class ServerUsageScreen extends ConsumerStatefulWidget {
  const ServerUsageScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<ServerUsageScreen> createState() => _ServerUsageScreenState();
}

class _ServerUsageScreenState extends ConsumerState<ServerUsageScreen> {
  ServerUsage? _usage;
  ApiError? _error;
  bool _loading = false;

  Timer? _ticker;
  int _rateLimitRemaining = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _load({bool force = false}) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      if (!force) _error = null;
    });
    try {
      final usage = await ref.read(serverRepositoryProvider).usage(
            serverId: widget.serverId,
            force: force,
          );
      if (!mounted) return;
      setState(() {
        _usage = usage;
        _error = null;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.code == 'RATE_LIMITED' && e.retryAfterSeconds != null) {
        _startRateLimit(e.retryAfterSeconds!);
        showErrorSnackBar(context, e);
      } else {
        setState(() => _error = e);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = const ApiError(
            code: 'CLIENT_ERROR',
            message: 'Something went wrong. Please try again.',
          ));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _startRateLimit(int seconds) {
    _ticker?.cancel();
    setState(() => _rateLimitRemaining = seconds);
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _rateLimitRemaining -= 1);
      if (_rateLimitRemaining <= 0) {
        timer.cancel();
        setState(() => _rateLimitRemaining = 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final forced = _rateLimitRemaining > 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Usage')),
      body: _buildBody(context),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: AppButton(
            label: forced
                ? 'Rate limited · ${_rateLimitRemaining}s'
                : 'Force refresh',
            icon: Icons.bolt,
            loading: _loading,
            onPressed:
                _loading || forced ? null : () => _load(force: true),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading && _usage == null && _error == null) {
      return const AppLoadingView(message: 'Fetching usage…');
    }
    if (_error != null) {
      return AppErrorView(
        title: 'Usage unavailable',
        message: _error!.userMessage,
        retryLabel: 'Retry',
        onRetry: _load,
      );
    }
    final usage = _usage;
    if (usage == null) {
      return const AppEmptyState(
        icon: Icons.speed_outlined,
        title: 'No usage data',
        message: 'Bandwidth statistics have not been reported yet.',
      );
    }

    final usedFraction = (usage.limitBytes ?? 0) > 0
        ? ((usage.totalBytes ?? 0) / usage.limitBytes!).clamp(0.0, 1.0)
        : null;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        SectionHeader(
          title: 'Bandwidth',
          icon: Icons.speed_outlined,
          action: usage.cached == true
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bg3,
                    borderRadius:
                        BorderRadius.circular(AppRadius.pill),
                    border: Border.all(color: AppColors.line),
                  ),
                  child: const Text(
                    'cached',
                    style: AppTypography.caption,
                  ),
                )
              : null,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: StatTile(
                icon: Icons.arrow_downward,
                label: 'In',
                value: ByteFormatter.toGb(usage.bandwidthInBytes),
                accentColor: AppColors.info,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatTile(
                icon: Icons.arrow_upward,
                label: 'Out',
                value: ByteFormatter.toGb(usage.bandwidthOutBytes),
                accentColor: AppColors.accentViolet,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatTile(
                icon: Icons.swap_vert,
                label: 'Total',
                value: ByteFormatter.toGb(usage.totalBytes),
                accentColor: AppColors.accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        if (usedFraction != null)
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Usage of limit',
                      style: AppTypography.bodySecondary,
                    ),
                    const Spacer(),
                    Text(
                      '${(usedFraction * 100).round()}%',
                      style: AppTypography.mono,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppRadius.pill),
                  child: LinearProgressIndicator(
                    value: usedFraction,
                    minHeight: 8,
                    color: AppColors.accent,
                    backgroundColor: AppColors.bg3,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  '${ByteFormatter.toGb(usage.totalBytes)} of '
                  '${ByteFormatter.toGb(usage.limitBytes)}',
                  style: AppTypography.caption,
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms)
              .slideY(begin: 0.06, end: 0),
        const SizedBox(height: AppSpacing.lg),
        const SectionHeader(
          title: 'Details',
          icon: Icons.info_outline,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            children: [
              InfoRow(
                label: 'Limit',
                value: ByteFormatter.toGb(usage.limitBytes),
              ),
              InfoRow(
                label: 'Fetched at',
                value: usage.fetchedAt == null
                    ? '—'
                    : DateFormatter.isoToLocal(
                        usage.fetchedAt!.toIso8601String(),
                      ),
              ),
              InfoRow(
                label: 'Server ID',
                value: usage.serverId?.toString() ?? '—',
                mono: true,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0),
      ],
    );
  }
}
