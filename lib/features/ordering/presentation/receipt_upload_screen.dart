import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/idempotency_key.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Upload receipt')),
      body: _result != null
          ? _SuccessView(result: _result!)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Paid by bank transfer? Upload the receipt for admin review. No server is provisioned until it is approved.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 16),
                _loadingPlans
                    ? const LinearProgressIndicator()
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
                const SizedBox(height: 16),
                TextField(
                  controller: _planNameController,
                  decoration: const InputDecoration(
                    labelText: 'Plan name (optional)',
                    hintText: 'Defaults to the plan slug',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Paid amount (cents)',
                    hintText: 'e.g. 800 for \$8.00',
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                  label: Text(_file == null
                      ? 'Attach receipt (JPG/PNG/WEBP/PDF, ≤5 MB)'
                      : _file!.name),
                ),
                if (_fileError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _fileError!,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                ],
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
                  onPressed: _submit,
                  child: const Text('Submit receipt'),
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
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.mark_email_read_outlined,
                size: 56, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Receipt received — request #${result.requestId} is pending review.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${result.status.raw}. Nothing is charged or provisioned until an admin approves it.',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
