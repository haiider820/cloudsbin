import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/server_repository.dart';

/// Changes the server access port (§6.26). Queues an agent command.
class AccessPortScreen extends ConsumerStatefulWidget {
  const AccessPortScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<AccessPortScreen> createState() => _AccessPortScreenState();
}

class _AccessPortScreenState extends ConsumerState<AccessPortScreen> {
  final _portController = TextEditingController();

  int? _currentPort;
  bool _loadingCurrent = true;
  bool _submitting = false;
  String? _portError;

  @override
  void initState() {
    super.initState();
    _loadCurrentPort();
  }

  @override
  void dispose() {
    _portController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentPort() async {
    setState(() => _loadingCurrent = true);
    try {
      final whitelist =
          await ref.read(serverRepositoryProvider).ipWhitelist(widget.serverId);
      if (!mounted) return;
      setState(() {
        _currentPort = whitelist.accessPort;
        _portController.text = whitelist.accessPort?.toString() ?? '';
      });
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } catch (_) {
      if (mounted) {
        showErrorMessageSnackBar(
            context, 'Something went wrong. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _loadingCurrent = false);
    }
  }

  Future<void> _submit() async {
    final port = int.tryParse(_portController.text.trim());
    if (port == null || port < 1 || port > 65535) {
      setState(() => _portError = 'Enter a port between 1 and 65535.');
      return;
    }
    setState(() {
      _submitting = true;
      _portError = null;
    });
    try {
      final result = await ref
          .read(serverRepositoryProvider)
          .accessPort(serverId: widget.serverId, port: port);
      if (!mounted) return;
      setState(() => _currentPort = result.newPort ?? port);
      showInfoSnackBar(
        context,
        result.message ?? 'Access-port change queued.',
      );
      // Queue a delayed refresh of the server detail to show the new port.
      if (mounted) {
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            ref.invalidate(serverDetailProvider(widget.serverId));
            // Pop back to the server detail screen; the detail will reload
            // with the updated access port.
            if (!context.mounted) return;
            Navigator.of(context).pop();
          }
        });
      }
    } on ApiError catch (e) {
      if (!mounted) return;
      switch (e.code) {
        case 'SAME_PORT':
          // No-op success: the requested port equals the current one.
          showInfoSnackBar(context, 'That is already the access port.');
        case 'BUSY':
          showInfoSnackBar(context, 'Change already queued.');
        case 'RATE_LIMITED':
          showInfoSnackBar(context, 'Daily limit reached.');
        case 'NOT_ACTIVE':
          showInfoSnackBar(context, 'Server is not ready yet.');
        case 'INVALID_PORT':
        case 'RESERVED_PORT':
        case 'VALIDATION_FAILED':
          setState(() => _portError = e.message);
        default:
          showErrorSnackBar(context, e);
      }
    } catch (_) {
      if (!mounted) return;
      showErrorMessageSnackBar(
          context, 'Something went wrong. Please try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Access port')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          AppCard(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.settings_ethernet,
                    size: 20,
                    color: AppColors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Text(
                    'Current port',
                    style: AppTypography.title,
                  ),
                ),
                _loadingCurrent
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _currentPort?.toString() ?? '—',
                        style: AppTypography.mono.copyWith(fontSize: 16),
                      ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            controller: _portController,
            label: 'New port',
            hint: '1024 – 65535',
            keyboardType: TextInputType.number,
            errorText: _portError,
            onFieldSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Allowed range 1024–65535; reserved ports are rejected.',
            style: AppTypography.caption,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Queue change',
            icon: Icons.save_outlined,
            loading: _submitting,
            onPressed: _submit,
          ),
          const SizedBox(height: AppSpacing.md),
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 18,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    'The agent applies the change within a minute. '
                    'Limited to 3 changes per server per day.',
                    style: AppTypography.caption,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
