import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../enums/app_enums.dart';

/// Colour-coded server status pill, tuned for the dark brand theme.
/// active=green · provisioning/booting=amber · destroyed/terminated=grey ·
/// suspended/locked=red · offline=grey · stopping=amber · others=orange.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final ServerStatus status;

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status.raw) {
      'active' => (AppColors.activeBg, AppColors.activeFg),
      'provisioning' || 'booting' || 'stopping' =>
        (AppColors.pendingBg, AppColors.pendingFg),
      'destroyed' || 'terminated' =>
        (AppColors.inactiveBg, AppColors.inactiveFg),
      'suspended' || 'locked' =>
        (AppColors.dangerBg, AppColors.dangerFg),
      'offline' =>
        (AppColors.inactiveBg, AppColors.inactiveFg),
      _ => (AppColors.attentionBg, AppColors.attentionFg),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: fg,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status.label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
