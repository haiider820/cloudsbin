import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/money_formatter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.orderId)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 12),
                        Text(_error!.userMessage,
                            textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: () {
                            setState(() => _loading = true);
                            _fetch();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                )
              : _OrderView(order: _order!),
    );
  }
}

class _OrderView extends StatelessWidget {
  const _OrderView({required this.order});

  final CryptoOrder order;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pending = !order.status.isTerminal;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text('Payment status',
                          style: theme.textTheme.titleSmall),
                    ),
                    _StatusChip(
                        status: order.status.raw, pending: pending),
                  ],
                ),
                const SizedBox(height: 12),
                _kv(theme, 'Amount requested',
                    MoneyFormatter.crypto(order.amountRequested, order.tokenSymbol ?? order.asset)),
                if (order.amountReceived != null)
                  _kv(theme, 'Amount received',
                      MoneyFormatter.crypto(order.amountReceived, order.tokenSymbol ?? order.asset)),
                _kv(theme, 'Network',
                    order.networkName ?? order.network ?? '—'),
                _kv(theme, 'Created',
                    DateFormatter.dbToLocal(order.createdAt?.toIso8601String())),
                if (order.verifiedAt != null)
                  _kv(theme, 'Verified',
                      DateFormatter.dbToLocal(order.verifiedAt?.toIso8601String())),
                if (order.txHash != null) _kv(theme, 'Tx hash', order.txHash!),
                if (order.serverId != null)
                  _kv(theme, 'Server', '#${order.serverId}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (pending) ...[
          Card(
            color: theme.colorScheme.tertiaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      order.secondsLeft != null && order.secondsLeft! > 0
                          ? 'Waiting for payment — ${DateFormatter.countdown(order.secondsLeft!)} left. Checking every 15 s.'
                          : 'Waiting for payment — checking every 15 s.',
                      style: TextStyle(
                          color: theme.colorScheme.onTertiaryContainer),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          Card(
            color: order.status.raw == 'PAID'
                ? theme.colorScheme.primaryContainer
                : theme.colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                order.status.raw == 'PAID'
                    ? 'Payment confirmed. Your server will be provisioned shortly.'
                    : 'This payment window expired. Create a new checkout to try again.',
                style: TextStyle(
                  color: order.status.raw == 'PAID'
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _kv(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(value,
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.pending});

  final String status;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = pending
        ? Colors.amber.shade800
        : (status == 'PAID' ? Colors.green : theme.colorScheme.error);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
