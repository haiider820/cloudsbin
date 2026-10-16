import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/reauth_sheet.dart';
import '../data/server_repository.dart';

/// Destroys a server: re-auth grant → irreversible confirmation → call (§6.22).
class DestroyScreen extends ConsumerStatefulWidget {
  const DestroyScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<DestroyScreen> createState() => _DestroyScreenState();
}

class _DestroyScreenState extends ConsumerState<DestroyScreen> {
  bool _busy = false;
  bool _done = false;
  bool _awaiting = false;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  Future<void> _start() async {
    setState(() => _awaiting = false);
    final grant = await showReauthSheet(context);
    if (!mounted) return;
    if (grant == null) {
      setState(() => _awaiting = true);
      return;
    }
    final confirmed = await confirmDialog(
      context,
      title: 'Destroy this server?',
      message: 'This cannot be undone. The provider instance will be '
          'permanently deleted.',
      confirmLabel: 'Destroy',
      danger: true,
      icon: Icons.warning_amber_rounded,
    );
    if (!mounted) return;
    if (!confirmed) {
      setState(() => _awaiting = true);
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(serverRepositoryProvider).destroy(
            serverId: widget.serverId,
            reauthToken: grant,
          );
      if (!mounted) return;
      ref.invalidate(serverDetailProvider(widget.serverId));
      setState(() {
        _done = true;
        _busy = false;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Destroy server')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_busy) {
      return const AppLoadingView(message: 'Destroying server…');
    }

    if (_done) {
      return AppEmptyState(
        icon: Icons.check_circle_outline,
        title: 'Server destroyed.',
        actionLabel: 'Back to servers',
        onAction: () => context.go(Routes.servers),
      );
    }

    if (_error != null) {
      // 409 CONFLICT = already destroyed (§6.22).
      final already = _error!.code == 'CONFLICT';
      return AppErrorView(
        message: already ? 'Already destroyed.' : _error!.userMessage,
        retryLabel: 'Back to servers',
        onRetry: () => context.go(Routes.servers),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.danger.withValues(alpha: 0.45),
        ),
      ),
      child: AppCard(
        color: AppColors.dangerBg,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 40,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Destroy this server?',
              textAlign: TextAlign.center,
              style: AppTypography.headline,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _awaiting
                  ? 'Confirmation required to destroy this server.'
                  : 'Preparing…',
              textAlign: TextAlign.center,
              style: AppTypography.bodySecondary,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Continue',
              icon: Icons.delete_outline,
              variant: AppButtonVariant.danger,
              onPressed: _start,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.06, end: 0);
  }
}
