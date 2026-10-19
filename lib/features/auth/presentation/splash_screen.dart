import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/hero_header.dart';

/// Brand splash: glowing brand mark and wordmark with a soft pulse while
/// the app resolves the session.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: Stack(
        children: [
          // Ambient glows behind the brand moment.
          const Positioned(
            top: 120,
            left: -60,
            child: _Glow(color: AppColors.glowViolet, size: 260),
          ),
          const Positioned(
            bottom: 140,
            right: -70,
            child: _Glow(color: AppColors.glowCyan, size: 300),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandMark(size: 104)
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .scaleXY(
                      begin: 0.96,
                      end: 1.04,
                      duration: 1200.ms,
                      curve: Curves.easeInOut,
                    )
                    .fadeIn(duration: 400.ms),
                const SizedBox(height: AppSpacing.lg),
                const Text('CloudsBin', style: AppTypography.display)
                    .animate()
                    .fadeIn(delay: 150.ms, duration: 450.ms)
                    .slideY(begin: 0.25, end: 0, duration: 450.ms),
                const SizedBox(height: AppSpacing.xs),
                Text('Cloud servers, in your pocket',
                        style: AppTypography.bodySecondary)
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 450.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}
