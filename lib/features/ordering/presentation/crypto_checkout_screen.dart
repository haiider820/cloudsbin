import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
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

  IconData _assetIcon(CryptoAsset a) {
    final symbol = (a.symbol ?? a.asset).toUpperCase();
    if (symbol.contains('BTC')) return Icons.currency_bitcoin;
    if (symbol.contains('ETH')) return Icons.diamond_outlined;
    if (symbol.contains('USDT') || symbol.contains('USDC')) {
      return Icons.attach_money_outlined;
    }
    return Icons.token_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay with crypto')),
      body: _result != null
          ? _CheckoutView(result: _result!)
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                const HeroHeader(
                  eyebrow: 'Crypto payment',
                  title: 'Pay with crypto',
                  subtitle:
                      'Pick an asset and create a checkout — the price is computed server-side.',
                  icon: Icons.currency_bitcoin_outlined,
                ),
                if (_loadingAssets)
                  const AppShimmer(itemCount: 3, itemHeight: 76)
                else if ((_assets?.assets ?? []).isEmpty)
                  const AppEmptyState(
                    icon: Icons.currency_bitcoin_outlined,
                    title: 'No assets available',
                    message: 'No crypto assets are enabled right now.',
                  )
                else ...[
                  const SectionHeader(
                    title: 'Crypto asset',
                    subtitle: 'Choose what you will pay with',
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    height: 132,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _assets!.assets.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, i) {
                        final a = _assets!.assets[i];
                        final selected = a == _asset;
                        return SizedBox(
                          width: 152,
                          child: AppCard(
                            onTap: () => setState(() => _asset = a),
                            gradientBorder: selected,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: AppColors.accent
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(
                                        AppRadius.sm),
                                  ),
                                  child: Icon(_assetIcon(a),
                                      size: 22,
                                      color: selected
                                          ? AppColors.accent
                                          : AppColors.textMuted),
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  a.label ?? a.asset,
                                  style: AppTypography.title.copyWith(
                                      fontSize: 15),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  a.networkName ?? a.network ?? '',
                                  style: AppTypography.caption,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ).animate().fadeIn(duration: 220.ms),
                        );
                      },
                    ),
                  ),
                ],
                if (_assets?.btcRate?.rate != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'BTC rate: ${MoneyFormatter.usdPkrRate(_assets!.btcRate!.rate)} USD'
                    ' · updated ${DateFormatter.dbToLocal(_assets!.btcRate!.updatedAt?.toIso8601String())}',
                    style: AppTypography.caption,
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(
                  title: 'Order details',
                  subtitle: 'What this checkout is for',
                ),
                const SizedBox(height: AppSpacing.sm),
                AppTextField(
                  controller: _planController,
                  label: 'Plan slug',
                  hint: 'e.g. starter',
                  prefixIcon: Icons.inventory_2_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _regionController,
                  label: 'Region slug',
                  hint: 'e.g. de-fra1',
                  prefixIcon: Icons.public_outlined,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_error != null) ...[
                  AppErrorView(
                    title: 'Checkout failed',
                    message: _error!.userMessage,
                    onRetry: _checkout,
                    retryLabel: 'Try again',
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                AppButton(
                  label: 'Create checkout',
                  icon: Icons.add_card_outlined,
                  loading: _submitting,
                  onPressed: _checkout,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'The price is computed server-side. Sending crypto creates a pending order — nothing is provisioned until payment is verified.',
                  style: AppTypography.caption,
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
    final r = result;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const HeroHeader(
          eyebrow: 'Checkout ready',
          title: 'Send your payment',
          subtitle: 'Use the address below to complete this order.',
          icon: Icons.qr_code_2_outlined,
        ),
        AppCard(
          gradientBorder: true,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SEND EXACTLY', style: AppTypography.sectionEyebrow),
              const SizedBox(height: AppSpacing.xs),
              SelectableText(
                MoneyFormatter.crypto(
                    r.amountRequested, r.tokenSymbol ?? r.asset),
                style: AppTypography.display.copyWith(
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('TO THIS ADDRESS', style: AppTypography.sectionEyebrow),
              const SizedBox(height: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.bg0,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.line),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SelectableText(
                        r.walletAddress ?? '—',
                        style: AppTypography.mono,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Copy address',
                      icon: const Icon(Icons.copy_outlined,
                          size: 20, color: AppColors.accent),
                      onPressed: r.walletAddress == null
                          ? null
                          : () {
                              Clipboard.setData(ClipboardData(
                                  text: r.walletAddress!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Address copied.')),
                              );
                            },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              InfoRow(
                label: 'Network',
                value: r.networkName ?? r.network ?? '—',
              ),
              if (r.confirmationsRequired != null)
                InfoRow(
                  label: 'Confirmations',
                  value:
                      '${r.confirmationsRequired} confirmation(s) required',
                ),
            ],
          ),
        ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: AppSpacing.md),
        if (r.expiresInSec != null) ...[
          _CountdownCard(seconds: r.expiresInSec!),
          const SizedBox(height: AppSpacing.md),
        ],
        AppButton(
          label: 'Track payment status',
          icon: Icons.radar_outlined,
          onPressed: () => context.push(
            Routes.cryptoOrderStatus,
            extra: {'orderId': r.orderId},
          ),
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
    final active = _left > 0;
    final tone = active ? AppColors.warning : AppColors.danger;
    return AppCard(
      color: tone.withValues(alpha: 0.08),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.timer_outlined, size: 22, color: tone),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              active
                  ? 'Expires in ${DateFormatter.countdown(_left)}'
                  : 'This checkout has expired.',
              style: AppTypography.title
                  .copyWith(fontSize: 15, color: tone),
            ),
          ),
        ],
      ),
    );
  }
}
