import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Signature hero header: brand-gradient glow, optional icon medallion,
/// eyebrow + title + subtitle. Used at the top of key screens.
class HeroHeader extends StatelessWidget {
  const HeroHeader({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
  });

  final String? eyebrow;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ambient glow.
        Positioned(
          top: -70,
          right: -50,
          child: Container(
            width: 220,
            height: 220,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.glowCyan, Colors.transparent],
              ),
            ),
          ),
        ),
        Positioned(
          top: -40,
          left: -70,
          child: Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.glowViolet, Colors.transparent],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    gradient: AppColors.brandGradient,
                    borderRadius:
                        BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Icon(icon,
                      size: 26, color: AppColors.onAccent),
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (eyebrow != null)
                      Text(eyebrow!.toUpperCase(),
                          style: AppTypography.sectionEyebrow),
                    if (eyebrow != null)
                      const SizedBox(height: AppSpacing.xxs),
                    Text(title, style: AppTypography.headline),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(subtitle!,
                          style: AppTypography.bodySecondary),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}

/// Gradient wordmark used on auth screens and the splash.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 64});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: AppColors.glowCyan,
            blurRadius: size * 0.5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(
        Icons.cloud_outlined,
        size: size * 0.52,
        color: AppColors.onAccent,
      ),
    );
  }
}
