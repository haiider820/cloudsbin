import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Estimate price')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Custom specs — the server computes the price; nothing is charged here.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _vcpuController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'vCPU'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _ramController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'RAM (GB)'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _ssdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'SSD (GB)'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _loadingRegions
              ? const LinearProgressIndicator()
              : DropdownButtonFormField<String>(
                  initialValue: _region,
                  decoration: const InputDecoration(labelText: 'Region'),
                  items: _regions
                      .map((r) => DropdownMenuItem(
                            value: r.slug,
                            child: Text(r.displayName ?? r.slug),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _region = v),
                ),
          const SizedBox(height: 20),
          LoadingButton(
            loading: _submitting,
            onPressed: _estimate,
            child: const Text('Estimate'),
          ),
          const SizedBox(height: 20),
          if (_error != null)
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
          if (_result != null) _ResultCard(result: _result!),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final EstimateResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final price = result.priceDisplay ??
        (result.priceCents != null
            ? MoneyFormatter.fromCents(result.priceCents!)
            : '—');
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estimated price', style: theme.textTheme.titleSmall),
            const SizedBox(height: 4),
            Text(
              '$price /mo',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 24),
            _row(theme, 'vCPU', '${result.vcpu ?? '—'}'),
            _row(
                theme, 'RAM', result.ramGb != null ? '${result.ramGb} GB' : '—'),
            _row(
                theme, 'SSD', result.ssdGb != null ? '${result.ssdGb} GB' : '—'),
            _row(theme, 'Region', result.region ?? result.regionSlug ?? '—'),
          ],
        ),
      ),
    );
  }

  Widget _row(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
