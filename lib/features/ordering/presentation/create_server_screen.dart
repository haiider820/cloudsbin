import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
import '../data/models/cloud_image.dart';
import '../data/models/plan.dart';
import '../data/models/server_create_result.dart';
import '../data/order_repository.dart';

/// Phase 8 — `POST /servers/create` (§6.15).
///
/// The `Idempotency-Key` is generated once per screen instance and reused
/// on retry — never resubmitted with a new key for the same logical
/// operation. On `409` (key in-flight) we poll nothing and tell the user to
/// check orders instead of resubmitting.
class CreateServerScreen extends ConsumerStatefulWidget {
  const CreateServerScreen({super.key, this.initialPlanSlug});

  /// Preselected when arriving from [PlansScreen].
  final String? initialPlanSlug;

  @override
  ConsumerState<CreateServerScreen> createState() => _CreateServerScreenState();
}

class _CreateServerScreenState extends ConsumerState<CreateServerScreen> {
  final _sshController = TextEditingController();
  final _vcpuController = TextEditingController(text: '1');
  final _ramController = TextEditingController(text: '1');
  final _ssdController = TextEditingController(text: '25');

  /// One key per logical operation — survives retries of this screen.
  late final String _idempotencyKey = IdempotencyKey.generate();

  List<Plan> _plans = [];
  List<CloudImage> _images = [];
  bool _loading = true;
  bool _loadingImages = false;
  bool _submitting = false;

  String? _planSlug;
  String? _region;
  String? _image;
  bool _autoscale = false;
  bool _customSpecs = false;

  ServerCreateResult? _result;
  ApiError? _error;

  List<String> get _regionsForPlan {
    if (_planSlug == 'custom') {
      // Custom builds can target any region any plan serves.
      final all = <String>{};
      for (final p in _plans) {
        all.addAll(p.regions.map((r) => r.slug));
      }
      return all.toList();
    }
    final plan = _plans.where((p) => p.slug == _planSlug);
    if (plan.isEmpty) return [];
    return plan.first.regions.map((r) => r.slug).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  @override
  void dispose() {
    _sshController.dispose();
    _vcpuController.dispose();
    _ramController.dispose();
    _ssdController.dispose();
    super.dispose();
  }

  Future<void> _loadPlans() async {
    try {
      final response = await ref.read(orderRepositoryProvider).plans();
      if (!mounted) return;
      setState(() {
        _plans = response.items;
        _planSlug = widget.initialPlanSlug ??
            (response.items.isNotEmpty ? response.items.first.slug : null);
        final regions = _regionsForPlan;
        _region = regions.isNotEmpty ? regions.first : null;
        _loading = false;
      });
      await _loadImages();
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _loadImages() async {
    final slug = _planSlug;
    if (slug == null || slug == 'custom') {
      setState(() {
        _images = [];
        _image = null;
      });
      return;
    }
    setState(() => _loadingImages = true);
    try {
      final response = await ref.read(orderRepositoryProvider).images(
            planSlug: slug,
            region: _region,
          );
      if (!mounted) return;
      setState(() {
        _images = response.images;
        _image = response.defaultSlug ??
            (response.images.isNotEmpty ? response.images.first.slug : null);
        _loadingImages = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loadingImages = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _submit() async {
    final planSlug = _planSlug;
    if (planSlug == null) {
      showInfoSnackBar(context, 'Pick a plan first.');
      return;
    }
    if (_region == null || _region!.isEmpty) {
      showInfoSnackBar(context, 'Pick a region first.');
      return;
    }
    Map<String, dynamic>? customSpecs;
    if (_customSpecs) {
      final vcpu = int.tryParse(_vcpuController.text.trim());
      final ram = double.tryParse(_ramController.text.trim());
      final ssd = int.tryParse(_ssdController.text.trim());
      if (vcpu == null || vcpu <= 0 || ram == null || ram <= 0 || ssd == null || ssd <= 0) {
        showInfoSnackBar(context, 'Enter valid custom specs.');
        return;
      }
      customSpecs = {'vcpu': vcpu, 'ram_gb': ram, 'ssd_gb': ssd};
    }
    setState(() {
      _submitting = true;
      _error = null;
      _result = null;
    });
    try {
      final result = await ref.read(orderRepositoryProvider).createServer(
            planSlug: _customSpecs ? 'custom' : planSlug,
            region: _region!,
            image: _image,
            sshPublicKey: _sshController.text.trim().isEmpty
                ? null
                : _sshController.text.trim(),
            autoscale: _autoscale,
            customSpecs: customSpecs,
            idempotencyKey: _idempotencyKey,
          );
      if (!mounted) return;
      setState(() => _result = result);
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.code == 'INSUFFICIENT_BALANCE') {
        // 402 → (stub) top-up screen.
        if (mounted) context.push(Routes.walletTopup);
        return;
      }
      setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Create server')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _result != null
              ? _SuccessView(result: _result!)
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: _planSlug,
                      decoration: const InputDecoration(labelText: 'Plan'),
                      items: [
                        ..._plans.map((p) => DropdownMenuItem(
                              value: p.slug,
                              child: Text(
                                '${p.displayName ?? p.name}'
                                '${p.priceDisplay != null ? ' · ${p.priceDisplay}' : ''}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        const DropdownMenuItem(
                          value: 'custom',
                          child: Text('Custom specs'),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          _planSlug = v;
                          _customSpecs = v == 'custom';
                          final regions = _regionsForPlan;
                          _region =
                              regions.isNotEmpty ? regions.first : null;
                        });
                        _loadImages();
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: _region,
                      decoration: const InputDecoration(labelText: 'Region'),
                      items: _regionsForPlan
                          .map((r) => DropdownMenuItem(
                                value: r,
                                child: Text(r),
                              ))
                          .toList(),
                      onChanged: (v) {
                        setState(() => _region = v);
                        _loadImages();
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_customSpecs) ...[
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _vcpuController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'vCPU'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _ramController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              decoration:
                                  const InputDecoration(labelText: 'RAM (GB)'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _ssdController,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(labelText: 'SSD (GB)'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ] else
                      _loadingImages
                          ? const LinearProgressIndicator()
                          : DropdownButtonFormField<String>(
                              initialValue: _image,
                              decoration:
                                  const InputDecoration(labelText: 'Image'),
                              items: _images
                                  .map((i) => DropdownMenuItem(
                                        value: i.slug,
                                        child: Text(i.name,
                                            overflow: TextOverflow.ellipsis),
                                      ))
                                  .toList(),
                              onChanged: (v) => setState(() => _image = v),
                            ),
                    if (!_customSpecs) const SizedBox(height: 16),
                    TextField(
                      controller: _sshController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'SSH public key (optional)',
                        hintText: 'ssh-ed25519 AAAA…',
                      ),
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      title: const Text('Autoscale'),
                      value: _autoscale,
                      onChanged: (v) => setState(() => _autoscale = v),
                    ),
                    const SizedBox(height: 8),
                    if (_error != null) ...[
                      Card(
                        color: theme.colorScheme.errorContainer,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _error!.code == 'CONFLICT'
                                ? 'This request is already being processed. Check your orders instead of resubmitting.'
                                : _error!.userMessage,
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
                      onPressed: _submit,
                      child: const Text('Create server'),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'The wallet is debited server-side. The price is never computed on this device.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.result});

  final ServerCreateResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline,
                size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text('Server #${result.serverId} is provisioning.',
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            if (result.totalCents != null)
              Text(
                'Charged ${MoneyFormatter.fromCents(result.totalCents!)} from your wallet.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () =>
                  context.go(Routes.serverDetailPath(result.serverId)),
              child: const Text('View server'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.go(Routes.servers),
              child: const Text('Back to servers'),
            ),
          ],
        ),
      ),
    );
  }
}
