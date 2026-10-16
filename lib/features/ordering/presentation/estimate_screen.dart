import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
import '../data/models/estimate_result.dart';
import '../data/models/region.dart';
import '../data/order_repository.dart';

/// Phase 8 — `POST /servers/estimate`. Custom specs form; the price shown
/// is server-computed (`price_display` / `price_cents`), never derived
/// client-side.
class EstimateScreen extends ConsumerStatefulWidget {
  const EstimateScreen({super.key});

  @override
  ConsumerState<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends ConsumerState<EstimateScreen> {
  final _vcpuController = TextEditingController(text: '1');
  final _ramController = TextEditingController(text: '1');
  final _ssdController = TextEditingController(text: '25');

  List<Region> _regions = [];
  String? _region;
  bool _loadingRegions = true;
  bool _submitting = false;
  EstimateResult? _result;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    _loadRegions();
  }

  @override
  void dispose() {
    _vcpuController.dispose();
    _ramController.dispose();
    _ssdController.dispose();
    super.dispose();
  }

  Future<void> _loadRegions() async {
    try {
      final paged = await ref.read(orderRepositoryProvider).regions();
      if (!mounted) return;
      setState(() {
        _regions = paged.items;
        _region = paged.items.isNotEmpty ? paged.items.first.slug : null;
        _loadingRegions = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loadingRegions = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _estimate() async {
    final vcpu = int.tryParse(_vcpuController.text.trim());
    final ram = double.tryParse(_ramController.text.trim());
    final ssd = int.tryParse(_ssdController.text.trim());
    if (vcpu == null ||
        vcpu <= 0 ||
        ram == null ||
        ram <= 0 ||
        ssd == null ||
        ssd <= 0) {
      showInfoSnackBar(context, 'Enter valid specs (all greater than zero).');
      return;
    }
    if (_region == null) {
      showInfoSnackBar(context, 'Pick a region first.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
      _result = null;
    });
    try {
      final result = await ref.read(orderRepositoryProvider).estimate(
            vcpu: vcpu,
            ramGb: ram,
            ssdGb: ssd,
            region: _region!,
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
    return Scaffold(
      appBar: AppBar(title: const Text('Estimate price')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        children: [
          const HeroHeader(
            eyebrow: 'Price calculator',
            title: 'Estimate price',
            subtitle:
                'Custom specs — the server computes the price. Nothing is charged here.',
            icon: Icons.calculate_outlined,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Specs',
                  subtitle: 'Enter the resources you need',
                  icon: Icons.tune_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _vcpuController,
                        label: 'vCPU',
                        hint: '1',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppTextField(
                        controller: _ramController,
                        label: 'RAM (GB)',
                        hint: '1',
                        keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppTextField(
                        controller: _ssdController,
                        label: 'SSD (GB)',
                        hint: '25',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(
                  title: 'Region',
                  subtitle: 'Where the server will live',
                  icon: Icons.public_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                _loadingRegions
                    ? const AppShimmerInline()
                    : DropdownButtonFormField<String>(
                        initialValue: _region,
                        decoration:
                            const InputDecoration(labelText: 'Region'),
                        items: _regions
                            .map((r) => DropdownMenuItem(
                                  value: r.slug,
                                  child: Text(r.displayName ?? r.slug),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _region = v),
                      ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Estimate',
                  icon: Icons.calculate_outlined,
                  loading: _submitting,
                  onPressed: _estimate,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_error != null) ...[
                  AppCard(
                    color: AppColors.dangerBg,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 20, color: AppColors.danger),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            _error!.userMessage,
                            style: AppTypography.bodySecondary.copyWith(
                              color: AppColors.dangerFg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
                if (_result != null) _ResultCard(result: _result!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact loading placeholder for the region dropdown while it loads.
class AppShimmerInline extends StatelessWidget {
  const AppShimmerInline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.line),
      ),
      child: const Center(
        child: SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final EstimateResult result;

  @override
  Widget build(BuildContext context) {
    final price = result.priceDisplay ??
        (result.priceCents != null
            ? MoneyFormatter.fromCents(result.priceCents!)
            : '—');
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Estimated price',
            subtitle: 'Server-computed monthly price',
            icon: Icons.receipt_long_outlined,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            price,
            style: AppTypography.display.copyWith(
              color: AppColors.accent,
            ),
          ),
          const Text('/month', style: AppTypography.caption),
          const Divider(height: AppSpacing.lg),
          InfoRow(
            label: 'vCPU',
            value: result.vcpu != null ? '${result.vcpu}' : '—',
            mono: true,
          ),
          InfoRow(
            label: 'RAM',
            value: result.ramGb != null ? '${result.ramGb} GB' : '—',
            mono: true,
          ),
          InfoRow(
            label: 'SSD',
            value: result.ssdGb != null ? '${result.ssdGb} GB' : '—',
            mono: true,
          ),
          InfoRow(
            label: 'Region',
            value: result.region ?? result.regionSlug ?? '—',
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            label: 'Continue to create server',
            icon: Icons.arrow_forward,
            variant: AppButtonVariant.secondary,
            onPressed: () => context.push(Routes.createServer),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0);
  }
}
