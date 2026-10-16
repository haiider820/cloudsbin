import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/hero_header.dart';
import '../data/models/order.dart';
import '../data/models/plan.dart';
import '../data/order_repository.dart';

const _allowedExtensions = ['jpg', 'jpeg', 'png', 'webp', 'pdf'];
const _maxBytes = 5 * 1024 * 1024;

/// Phase 8 — multipart `POST /orders/receipt` (§6.31).
///
/// Client-side validation: JPG/PNG/WEBP/PDF, ≤5 MB (the server sniffs the
/// real type with finfo). `Idempotency-Key` generated once per screen.
/// 201 → shows `request_id` + `pending` status (admin-review flow: no money
/// moves, no provisioning).
class ReceiptUploadScreen extends ConsumerStatefulWidget {
  const ReceiptUploadScreen({super.key});

  @override
  ConsumerState<ReceiptUploadScreen> createState() =>
      _ReceiptUploadScreenState();
}

class _ReceiptUploadScreenState extends ConsumerState<ReceiptUploadScreen> {
  final _planNameController = TextEditingController();
  final _priceController = TextEditingController();

  /// One key per logical operation — survives retries of this screen.
  late final String _idempotencyKey = IdempotencyKey.generate();

  List<Plan> _plans = [];
  String? _planSlug;
  bool _loadingPlans = true;
  bool _submitting = false;
  PlatformFile? _file;
  String? _fileError;

  ReceiptResult? _result;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    _loadPlans();
  }

  @override
  void dispose() {
    _planNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _loadPlans() async {
    try {
      final response = await ref.read(orderRepositoryProvider).plans();
      if (!mounted) return;
      setState(() {
        _plans = response.items;
        _planSlug =
            response.items.isNotEmpty ? response.items.first.slug : null;
        _loadingPlans = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _loadingPlans = false);
      showErrorSnackBar(context, e);
    }
  }

  Future<void> _pickFile() async {
    setState(() => _fileError = null);
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      withData: false,
    );
    final files = picked?.files;
    final file = (files != null && files.isNotEmpty) ? files.first : null;
    if (file == null) return;
    if (file.path == null) {
      setState(() => _fileError = 'Could not read that file.');
      return;
    }
    if (file.size > _maxBytes) {
      setState(() => _fileError = 'File is too large (max 5 MB).');
      return;
    }
    setState(() => _file = file);
  }

  Future<void> _submit() async {
    if (_planSlug == null) {
      showInfoSnackBar(context, 'Pick a plan first.');
      return;
    }
    if (_file == null) {
      setState(() => _fileError = 'Attach your payment receipt.');
      return;
    }
    final priceCents = int.tryParse(_priceController.text.trim());
    if (priceCents == null || priceCents <= 0) {
      showInfoSnackBar(context, 'Enter the paid amount in cents.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
      _result = null;
    });
    try {
      final result = await ref.read(orderRepositoryProvider).uploadReceipt(
            planSlug: _planSlug!,
            planName: _planNameController.text.trim().isEmpty
                ? _planSlug!
                : _planNameController.text.trim(),
            priceCents: priceCents,
            file: _file!,
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

  String get _fileSizeLabel {
    final size = _file?.size ?? 0;
    if (size >= 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(size / 1024).toStringAsFixed(0)} KB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload receipt')),
      body: _result != null
          ? _SuccessView(result: _result!)
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                const HeroHeader(
                  eyebrow: 'Bank transfer',
                  title: 'Upload receipt',
                  subtitle:
                      'Paid by bank transfer? Upload the receipt for admin review. No server is provisioned until it is approved.',
                  icon: Icons.receipt_long_outlined,
                ),
                const SectionHeader(
                  title: 'Order details',
                  subtitle: 'What this receipt is for',
                ),
                const SizedBox(height: AppSpacing.sm),
                _loadingPlans
                    ? const AppShimmer(itemCount: 1, itemHeight: 76)
                    : DropdownButtonFormField<String>(
                        initialValue: _planSlug,
                        decoration:
                            const InputDecoration(labelText: 'Plan'),
                        items: _plans
                            .map((p) => DropdownMenuItem(
                                  value: p.slug,
                                  child: Text(p.displayName ?? p.name,
                                      overflow: TextOverflow.ellipsis),
                                ))
                            .toList(),
                        onChanged: (v) => setState(() => _planSlug = v),
                      ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _planNameController,
                  label: 'Plan name (optional)',
                  hint: 'Defaults to the plan slug',
                  prefixIcon: Icons.badge_outlined,
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _priceController,
                  label: 'Paid amount (cents)',
                  hint: 'e.g. 800 for \$8.00',
                  prefixIcon: Icons.attach_money_outlined,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(
                  title: 'Receipt file',
                  subtitle: 'JPG, PNG, WEBP or PDF · max 5 MB',
                ),
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.bg2,
                      borderRadius:
                          BorderRadius.circular(AppRadius.lg),
                      border: Border.all(
                        color: _file == null
                            ? AppColors.accent.withValues(alpha: 0.45)
                            : AppColors.success.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: _file == null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.accent
                                      .withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.cloud_upload_outlined,
                                  size: 30,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              const Text('Tap to attach your receipt',
                                  style: AppTypography.title),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'JPG, PNG, WEBP or PDF · up to 5 MB',
                                style: AppTypography.caption,
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.success
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(
                                      AppRadius.sm),
                                ),
                                child: const Icon(
                                  Icons.description_outlined,
                                  size: 26,
                                  color: AppColors.success,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _file!.name,
                                      style: AppTypography.mono,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '$_fileSizeLabel · tap to replace',
                                      style: AppTypography.caption,
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppColors.success,
                              ),
                            ],
                          ),
                  ),
                ).animate().fadeIn(duration: 220.ms),
                if (_fileError != null) ...[
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _fileError!,
                    style: AppTypography.caption
                        .copyWith(color: AppColors.danger),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                if (_error != null) ...[
                  AppErrorView(
                    title: 'Upload failed',
                    message: _error!.userMessage,
                    onRetry: _submit,
                    retryLabel: 'Try again',
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                AppButton(
                  label: 'Submit receipt',
                  icon: Icons.send_outlined,
                  loading: _submitting,
                  onPressed: _submit,
                ),
              ],
            ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.result});

  final ReceiptResult result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.glowCyan,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.activeBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        AppColors.success.withValues(alpha: 0.4),
                  ),
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 44,
                  color: AppColors.success,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Receipt received',
              textAlign: TextAlign.center,
              style: AppTypography.headline,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Nothing is charged or provisioned until an admin approves it.',
              textAlign: TextAlign.center,
              style: AppTypography.bodySecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppCard(
              child: Column(
                children: [
                  InfoRow(
                    label: 'Request',
                    value: '#${result.requestId}',
                    mono: true,
                  ),
                  InfoRow(
                    label: 'Status',
                    value: result.status.raw,
                    valueColor: AppColors.pendingFg,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.05, end: 0),
          ],
        ),
      ),
    );
  }
}
