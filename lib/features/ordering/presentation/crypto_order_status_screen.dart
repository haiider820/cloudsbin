import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../data/crypto_repository.dart';
import '../data/models/crypto_order.dart';

/// Phase 9 — `GET /crypto/order?order=CRY-...` (§6.34).
///
/// Polls every 15 s while `status == PENDING`; stops on PAID/EXPIRED.
/// Datetimes arrive as `Y-m-d H:i:s` (parsed as UTC by the model).
class CryptoOrderStatusScreen extends ConsumerStatefulWidget {
  const CryptoOrderStatusScreen({super.key, required this.orderId});

  final String orderId;

  @override
  ConsumerState<CryptoOrderStatusScreen> createState() =>
      _CryptoOrderStatusScreenState();
}

class _CryptoOrderStatusScreenState
    extends ConsumerState<CryptoOrderStatusScreen> {
  Timer? _poller;
  CryptoOrder? _order;
  ApiError? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void dispose() {
    _poller?.cancel();
    super.dispose();
  }

  Future<void> _fetch() async {
    try {
      final order = await ref
          .read(cryptoRepositoryProvider)
          .orderStatus(widget.orderId);
      if (!mounted) return;
      setState(() {
        _order = order;
        _error = null;
        _loading = false;
      });
      _armPoller(order);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _loading = false;
      });
    }
  }

  void _armPoller(CryptoOrder order) {
    _poller?.cancel();
    if (order.status.isTerminal) return;
    _poller = Timer.periodic(const Duration(seconds: 15), (_) {
      if (mounted) _fetch();
    });
  }

  void _refresh() => _fetch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.orderId)),
      body: _loading
          ? const AppLoadingView(message: 'Loading payment status…')
          : _error != null
              ? AppErrorView(
                  message: _error!.userMessage,
                  onRetry: () {
                    setState(() => _loading = true);
                    _fetch();
                  },
                )
              : _OrderView(
                  order: _order!,
                  onRefresh: _refresh,
                ),
    );
  }
}

class _OrderView extends StatelessWidget {
  const _OrderView({required this.order, required this.onRefresh});

  final CryptoOrder order;
  final VoidCallback onRefresh;

  bool get _pending => !order.status.isTerminal;
  bool get _paid => order.status.raw == 'PAID';

  Color get _tone =>
      _paid ? AppColors.success : (_pending ? AppColors.warning : AppColors.danger);

  IconData get _icon => _paid
      ? Icons.check_circle_outline
      : (_pending ? Icons.hourglass_top_outlined : Icons.timer_off_outlined);

  String get _statusTitle =>
      _paid ? 'Payment confirmed' : (_pending ? 'Waiting for payment' : 'Payment expired');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // ── Status hero ──────────────────────────────────────────────
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _tone.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _tone.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _tone.withValues(alpha: 0.45),
                  ),
                ),
                child: Icon(_icon, size: 46, color: _tone),
              ),
            ).animate().fadeIn(duration: 260.ms).scale(
                begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
            const SizedBox(height: AppSpacing.md),
            Text(_statusTitle,
                textAlign: TextAlign.center, style: AppTypography.headline),
            const SizedBox(height: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: _tone.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: _tone.withValues(alpha: 0.4)),
              ),
              child: Text(
                order.status.raw,
                style: AppTypography.caption.copyWith(
                  color: _tone,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        // ── Payment details ──────────────────────────────────────────
        const SectionHeader(
          title: 'Payment details',
          subtitle: 'Verbatim from the checkout',
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          child: Column(
            children: [
              InfoRow(
                label: 'Amount requested',
                value: MoneyFormatter.crypto(order.amountRequested,
                    order.tokenSymbol ?? order.asset),
                mono: true,
                valueColor: AppColors.accent,
              ),
              if (order.amountReceived != null)
                InfoRow(
                  label: 'Amount received',
                  value: MoneyFormatter.crypto(order.amountReceived,
                      order.tokenSymbol ?? order.asset),
                  mono: true,
                ),
              if (order.walletAddress != null)
                InfoRow(
                  label: 'Address',
                  value: order.walletAddress!,
                  mono: true,
                  trailing: IconButton(
                    tooltip: 'Copy address',
                    icon: const Icon(Icons.copy_outlined,
                        size: 18, color: AppColors.accent),
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: order.walletAddress!));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Address copied.')),
                      );
                    },
                  ),
                ),
              InfoRow(
                label: 'Network',
                value: order.networkName ?? order.network ?? '—',
              ),
              InfoRow(
                label: 'Created',
                value: DateFormatter.dbToLocal(
                    order.createdAt?.toIso8601String()),
              ),
              if (order.verifiedAt != null)
                InfoRow(
                  label: 'Verified',
                  value: DateFormatter.dbToLocal(
                      order.verifiedAt?.toIso8601String()),
                ),
              if (order.txHash != null)
                InfoRow(
                  label: 'Tx hash',
                  value: order.txHash!,
                  mono: true,
                ),
              if (order.serverId != null)
                InfoRow(
                  label: 'Server',
                  value: '#${order.serverId}',
                  mono: true,
                ),
            ],
          ),
        ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: AppSpacing.md),
        // ── Polling / outcome banner ─────────────────────────────────
        if (_pending)
          AppCard(
            color: AppColors.warning.withValues(alpha: 0.07),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    order.secondsLeft != null && order.secondsLeft! > 0
                        ? 'Waiting for payment — ${DateFormatter.countdown(order.secondsLeft!)} left. Checking every 15 s.'
                        : 'Waiting for payment — checking every 15 s.',
                    style: AppTypography.bodySecondary,
                  ),
                ),
              ],
            ),
          )
        else
          AppCard(
            color: _tone.withValues(alpha: 0.08),
            child: Row(
              children: [
                Icon(
                  _paid
                      ? Icons.rocket_launch_outlined
                      : Icons.refresh_outlined,
                  size: 24,
                  color: _tone,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    _paid
                        ? 'Payment confirmed. Your server will be provisioned shortly.'
                        : 'This payment window expired. Create a new checkout to try again.',
                    style: AppTypography.bodySecondary,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          label: 'Refresh status',
          icon: Icons.refresh_outlined,
          variant: AppButtonVariant.secondary,
          onPressed: onRefresh,
        ),
      ],
    );
  }
}
