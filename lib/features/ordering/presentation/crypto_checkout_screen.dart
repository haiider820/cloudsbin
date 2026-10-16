import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
import '../data/crypto_repository.dart';
import '../data/models/crypto_asset.dart';
import '../data/models/crypto_checkout.dart';

/// Phase 9 — crypto checkout flow.
///
/// 1. `GET /crypto/assets` → pick an asset.
/// 2. `POST /crypto/checkout` (Idempotency-Key, once per screen) →
///    shows the wallet address (copyable), the verbatim requested amount,
///    and an `expires_in_sec` countdown.
class CryptoCheckoutScreen extends ConsumerStatefulWidget {
  const CryptoCheckoutScreen({super.key, this.planSlug, this.region});

  final String? planSlug;
  final String? region;

  @override
  ConsumerState<CryptoCheckoutScreen> createState() =>
      _CryptoCheckoutScreenState();
}

class _CryptoCheckoutScreenState extends ConsumerState<CryptoCheckoutScreen> {
  final _planController = TextEditingController();
  final _regionController = TextEditingController();

  late final String _idempotencyKey = IdempotencyKey.generate();

  CryptoAssetsResponse? _assets;
  CryptoAsset? _asset;
  bool _loadingAssets = true;
  bool _submitting = false;
  ApiError? _error;
  CryptoCheckoutResult? _result;

  @override
  void initState() {
    super.initState();
    _planController.text = widget.planSlug ?? '';
    _regionController.text = widget.region ?? '';
    _loadAssets();
  }

  @override
  void dispose() {
    _planController.dispose();
    _regionController.dispose();
    super.dispose();
  }

  Future<void> _loadAssets() async {
    try {
      final response = await ref.read(cryptoRepositoryProvider).assets();
      if (!mounted) return;
      setState(() {
        _assets = response;
        _asset = response.assets.isNotEmpty ? response.assets.first : null;
        _loadingAssets = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loadingAssets = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _checkout() async {
    final planSlug = _planController.text.trim();
    final region = _regionController.text.trim();
    if (planSlug.isEmpty || region.isEmpty) {
      showInfoSnackBar(context, 'Enter a plan slug and region.');
      return;
    }
    if (_asset == null) {
      showInfoSnackBar(context, 'Pick a crypto asset first.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
      _result = null;
    });
    try {
      final result = await ref.read(cryptoRepositoryProvider).checkout(
            planSlug: planSlug,
            region: region,
            asset: _asset!.asset,
            chain: _asset!.chain,
            idempotencyKey: _idempotencyKey,
          );
      if (!mounted) return;
      setState(() => _result = result);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Pay with crypto')),
      body: _result != null
          ? _CheckoutView(result: _result!)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (_loadingAssets)
                  const LinearProgressIndicator()
                else if ((_assets?.assets ?? []).isEmpty)
                  const Text('No crypto assets are enabled right now.')
                else
                  DropdownButtonFormField<CryptoAsset>(
                    initialValue: _asset,
                    decoration:
                        const InputDecoration(labelText: 'Crypto asset'),
                    items: _assets!.assets
                        .map((a) => DropdownMenuItem(
                              value: a,
                              child: Text(
                                  '${a.label ?? a.asset} (${a.networkName ?? a.network ?? ''})'),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => _asset = v),
                  ),
                if (_assets?.btcRate?.rate != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'BTC rate: ${MoneyFormatter.usdPkrRate(_assets!.btcRate!.rate)} USD'
                    ' · updated ${DateFormatter.dbToLocal(_assets!.btcRate!.updatedAt?.toIso8601String())}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                TextField(
                  controller: _planController,
                  decoration: const InputDecoration(labelText: 'Plan slug'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _regionController,
                  decoration: const InputDecoration(labelText: 'Region slug'),
                ),
                const SizedBox(height: 20),
                if (_error != null) ...[
                  Card(
                    color: theme.colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _error!.userMessage,
                        style: TextStyle(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                LoadingButton(
                  loading: _submitting,
                  onPressed: _checkout,
                  child: const Text('Create checkout'),
                ),
                const SizedBox(height: 8),
                Text(
                  'The price is computed server-side. Sending crypto creates a pending order — nothing is provisioned until payment is verified.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
    );
  }
}

class _CheckoutView extends StatelessWidget {
  const _CheckoutView({required this.result});

  final CryptoCheckoutResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = result;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Send exactly', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                SelectableText(
                  MoneyFormatter.crypto(r.amountRequested, r.tokenSymbol ?? r.asset),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text('To this address', style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        r.walletAddress ?? '—',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Copy address',
                      icon: const Icon(Icons.copy),
                      onPressed: r.walletAddress == null
                          ? null
                          : () {
                              Clipboard.setData(
                                  ClipboardData(text: r.walletAddress!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Address copied.')),
                              );
                            },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Network: ${r.networkName ?? r.network ?? '—'}'
                  '${r.confirmationsRequired != null ? ' · ${r.confirmationsRequired} confirmation(s) required' : ''}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (r.expiresInSec != null)
          _CountdownCard(seconds: r.expiresInSec!),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => context.push(
            Routes.cryptoOrderStatus,
            extra: {'orderId': r.orderId},
          ),
          child: const Text('Track payment status'),
        ),
      ],
    );
  }
}

/// Ticks down from `expires_in_sec` (client-side display only).
class _CountdownCard extends StatefulWidget {
  const _CountdownCard({required this.seconds});

  final int seconds;

  @override
  State<_CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<_CountdownCard> {
  late int _left = widget.seconds;

  @override
  void initState() {
    super.initState();
    _tick();
  }

  Future<void> _tick() async {
    while (mounted && _left > 0) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() => _left--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: _left > 0
          ? theme.colorScheme.tertiaryContainer
          : theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.timer_outlined,
              color: _left > 0
                  ? theme.colorScheme.onTertiaryContainer
                  : theme.colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 12),
            Text(
              _left > 0
                  ? 'Expires in ${DateFormatter.countdown(_left)}'
                  : 'This checkout has expired.',
              style: TextStyle(
                color: _left > 0
                    ? theme.colorScheme.onTertiaryContainer
                    : theme.colorScheme.onErrorContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
