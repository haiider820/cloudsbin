import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
import '../../../shared/widgets/info_card.dart';
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

  Plan? get _selectedPlan {
    for (final p in _plans) {
      if (p.slug == _planSlug) return p;
    }
    return null;
  }

  String? get _priceDisplay {
    final plan = _selectedPlan;
    if (plan == null) return null;
    return plan.priceDisplay ??
        (plan.priceCents != null
            ? MoneyFormatter.fromCents(plan.priceCents!)
            : null);
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
      showErrorSnackBar(context, e);
    } catch (_) {
      if (!mounted) return;
      showErrorMessageSnackBar(
          context, 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loading = false);
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
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      showErrorSnackBar(context, e);
    } catch (_) {
      if (!mounted) return;
      showErrorMessageSnackBar(
          context, 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _loadingImages = false);
    }
  }

  void _selectPlan(String? slug) {
    setState(() {
      _planSlug = slug;
      _customSpecs = slug == 'custom';
      final regions = _regionsForPlan;
      _region = regions.isNotEmpty ? regions.first : null;
    });
    _loadImages();
  }

  void _selectRegion(String? slug) {
    setState(() => _region = slug);
    _loadImages();
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
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = const ApiError(
            code: 'CLIENT_ERROR',
            message: 'Something went wrong. Please try again.',
          ));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create server')),
      body: _loading
          ? const AppLoadingView(message: 'Loading plans…')
          : _result != null
              ? _SuccessView(result: _result!)
              : Column(
                  children: [
                    Expanded(child: _buildForm()),
                    _buildBottomBar(),
                  ],
                ),
    );
  }

  Widget _buildForm() {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        const HeroHeader(
          eyebrow: 'New server',
          title: 'Create server',
          subtitle: 'Configure your server. The wallet is debited server-side.',
          icon: Icons.add_to_queue_outlined,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Plan',
                subtitle: 'The size of your server',
                icon: Icons.dns_outlined,
              ),
              const SizedBox(height: AppSpacing.md),
              ..._plans.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: _PlanOption(
                        plan: e.value,
                        selected: _planSlug == e.value.slug,
                        onTap: () => _selectPlan(e.value.slug),
                      ).animate().fadeIn(duration: 300.ms).slideY(
                            begin: 0.06,
                            end: 0,
                          ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  onTap: () => _selectPlan('custom'),
                  gradientBorder: _customSpecs,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.accentViolet
                              .withValues(alpha: 0.12),
                          borderRadius:
                              BorderRadius.circular(AppRadius.sm),
                        ),
                        child: const Icon(
                          Icons.tune_outlined,
                          size: 20,
                          color: AppColors.accentViolet,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Custom specs',
                                style: AppTypography.title),
                            SizedBox(height: 2),
                            Text(
                              'Enter your own vCPU / RAM / SSD below',
                              style: AppTypography.caption,
                            ),
                          ],
                        ),
                      ),
                      if (_customSpecs)
                        const Icon(Icons.check_circle,
                            size: 22, color: AppColors.accent),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Region',
                subtitle: 'Where your server will live',
                icon: Icons.public_outlined,
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: _regionsForPlan
                    .map((r) => _OptionPill(
                          label: r,
                          selected: _region == r,
                          onTap: () => _selectRegion(r),
                        ))
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_customSpecs) ...[
                const SectionHeader(
                  title: 'Custom specs',
                  subtitle: 'All values must be greater than zero',
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
              ] else ...[
                const SectionHeader(
                  title: 'Image',
                  subtitle: 'The operating system',
                  icon: Icons.disc_full_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                if (_loadingImages)
                  const AppShimmer(itemCount: 2, itemHeight: 48)
                else if (_images.isEmpty)
                  const Text(
                    'No images available for this plan and region.',
                    style: AppTypography.caption,
                  )
                else
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: _images
                        .map((i) => _OptionPill(
                              label: i.name,
                              selected: _image == i.slug,
                              onTap: () => setState(() => _image = i.slug),
                            ))
                        .toList(),
                  ),
              ],
              const SizedBox(height: AppSpacing.lg),
              const SectionHeader(
                title: 'Access',
                subtitle: 'Optional extras',
                icon: Icons.key_outlined,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                controller: _sshController,
                label: 'SSH Public Key (optional)',
                hint: 'Leave empty to use root password authentication',
                prefixIcon: Icons.key_outlined,
                maxLines: 2,
              ),
              const SizedBox(height: AppSpacing.sm),
              const InfoCard(
                icon: Icons.info_outline,
                text: "If you don't provide an SSH key, your server "
                    "will use root password authentication. "
                    "You can retrieve credentials after provisioning "
                    "from the server detail screen.",
              ),
              const SizedBox(height: AppSpacing.sm),
              AppCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Autoscale',
                      style: AppTypography.body),
                  subtitle: const Text(
                    'Let the server scale automatically',
                    style: AppTypography.caption,
                  ),
                  value: _autoscale,
                  onChanged: (v) => setState(() => _autoscale = v),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
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
                          _error!.code == 'CONFLICT'
                              ? 'This request is already being processed. Check your orders instead of resubmitting.'
                              : _error!.userMessage,
                          style: AppTypography.bodySecondary.copyWith(
                            color: AppColors.dangerFg,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'The wallet is debited server-side. The price is never computed on this device.',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    final price = _customSpecs ? null : _priceDisplay;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bg1,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (price != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: AppTypography.bodySecondary),
                    Text(
                      '$price /mo',
                      style: AppTypography.title.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              AppButton(
                label: 'Create server',
                icon: Icons.add,
                loading: _submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Selectable plan card with a gradient border when selected.
class _PlanOption extends StatelessWidget {
  const _PlanOption({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  final Plan plan;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final specs = plan.specs;
    final specLine = [
      specs?.vcpuLabel,
      specs?.ramLabel,
      specs?.ssdLabel,
    ].whereType<String>().join(' · ');
    final price = plan.priceDisplay ??
        (plan.priceCents != null
            ? MoneyFormatter.fromCents(plan.priceCents!)
            : null);
    return AppCard(
      onTap: onTap,
      gradientBorder: selected,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(
              Icons.dns_outlined,
              size: 20,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.displayName ?? plan.name,
                  style: AppTypography.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (specLine.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    specLine,
                    style: AppTypography.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (price != null)
            Text(
              price,
              style: AppTypography.title.copyWith(
                color: AppColors.accent,
              ),
            ),
          const SizedBox(width: AppSpacing.xs),
          Icon(
            selected ? Icons.check_circle : Icons.circle_outlined,
            size: 22,
            color: selected ? AppColors.accent : AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}

/// Compact selectable pill for region / image options.
class _OptionPill extends StatelessWidget {
  const _OptionPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      gradientBorder: selected,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Text(
        label,
        style: AppTypography.bodySecondary.copyWith(
          color: selected ? AppColors.textPrimary : null,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.result});

  final ServerCreateResult result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.glowCyan,
                    blurRadius: 48,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                size: 44,
                color: AppColors.onAccent,
              ),
            )
                .animate()
                .fadeIn(duration: 300.ms)
                .slideY(begin: 0.06, end: 0),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Server #${result.serverId} is provisioning.',
              style: AppTypography.headline,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            if (result.totalCents != null)
              Text(
                'Charged ${MoneyFormatter.fromCents(result.totalCents!)} from your wallet.',
                style: AppTypography.bodySecondary,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'View server',
              icon: Icons.dns_outlined,
              onPressed: () =>
                  context.go(Routes.serverDetailPath(result.serverId)),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Back to servers',
              variant: AppButtonVariant.secondary,
              onPressed: () => context.go(Routes.servers),
            ),
          ],
        ),
      ),
    );
  }
}
