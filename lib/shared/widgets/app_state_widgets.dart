import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'app_button.dart';

/// Premium state widgets: shimmer loading, empty states and error views.
///
/// Nothing in the app shows a bare [CircularProgressIndicator] or a blank
/// screen anymore — screens compose these instead.
class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    this.itemCount = 4,
    this.itemHeight = 92,
  });

  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.bg2,
      highlightColor: AppColors.bg3,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Render only the placeholders that fit the available height so the
          // shimmer never overflows a bounded slot (e.g. a list area).
          var count = itemCount;
          if (constraints.maxHeight.isFinite) {
            final slot = itemHeight + AppSpacing.sm;
            final fit = (constraints.maxHeight / slot).floor();
            count = fit > itemCount ? itemCount : fit;
          }
          if (count <= 0) return const SizedBox.shrink();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              count,
              (_) => Container(
                height: itemHeight,
                margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Centered loading view with a branded message.
class AppLoadingView extends StatelessWidget {
  const AppLoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 34,
            width: 34,
            child: CircularProgressIndicator(strokeWidth: 3),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.md),
            Text(message!, style: AppTypography.bodySecondary),
          ],
        ],
      ),
    );
  }
}

/// Friendly placeholder for empty lists.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.bg2,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.line),
              ),
              child: Icon(icon, size: 40, color: AppColors.textMuted),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title,
                textAlign: TextAlign.center, style: AppTypography.title),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(message!,
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySecondary),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: AppButtonVariant.secondary,
                fullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Error view with a retry action — used instead of dumping errors in text.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    required this.message,
    this.title = 'Something went wrong',
    this.onRetry,
    this.retryLabel = 'Try again',
  });

  final String message;
  final String title;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.dangerBg,
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.danger.withValues(alpha: 0.4)),
              ),
              child: const Icon(Icons.cloud_off_outlined,
                  size: 38, color: AppColors.danger),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(title,
                textAlign: TextAlign.center, style: AppTypography.title),
            const SizedBox(height: AppSpacing.xs),
            Text(message,
                textAlign: TextAlign.center,
                style: AppTypography.bodySecondary),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppButton(
                label: retryLabel,
                icon: Icons.refresh_outlined,
                onPressed: onRetry,
                variant: AppButtonVariant.secondary,
                fullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
