import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_state_widgets.dart';
import '../../../shared/widgets/hero_header.dart';
import '../data/models/plan.dart';
import '../data/order_repository.dart';

/// Phase 8 — catalog entry. `GET /plans/list` → plans grid (name, specs,
/// `price_display`). Tapping a plan opens [CreateServerScreen] with it
/// preselected; the app bar also links to the estimate tool and orders.
class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  late Future<PlansResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = ref.read(orderRepositoryProvider).plans();
  }

  void _reload() {
    setState(() {
      _future = ref.read(orderRepositoryProvider).plans();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plans'),
        actions: [
          IconButton(
            tooltip: 'Estimate custom specs',
            icon: const Icon(Icons.calculate_outlined),
            onPressed: () => context.push(Routes.estimate),
          ),
          IconButton(
            tooltip: 'My orders',
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => context.push(Routes.orders),
          ),
        ],
      ),
      body: FutureBuilder<PlansResponse>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoadingView(message: 'Loading plans…');
          }
          if (snapshot.hasError) {
            final err = snapshot.error;
            return AppErrorView(
              message: err is ApiError
                  ? err.userMessage
                  : 'Could not load plans.',
              onRetry: _reload,
            );
          }
          final plans = snapshot.data?.items ?? [];
          if (plans.isEmpty) {
            return AppEmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'No plans available',
              message: 'Check back later for available plans.',
              actionLabel: 'Retry',
              onAction: _reload,
            );
          }
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HeroHeader(
                  eyebrow: 'Catalog',
                  title: 'Server plans',
                  subtitle:
                      'Pick a plan to configure your server. Prices are billed monthly from your wallet.',
                  icon: Icons.dns_outlined,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  AppSpacing.lg,
                ),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.sm,
                    crossAxisSpacing: AppSpacing.sm,
                    childAspectRatio: 0.78,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _PlanCard(plan: plans[i], index: i),
                    childCount: plans.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.index});

  final Plan plan;
  final int index;

  @override
  Widget build(BuildContext context) {
    final specs = plan.specs;
    final price = plan.priceDisplay ??
        (plan.priceCents != null
            ? MoneyFormatter.fromCents(plan.priceCents!)
            : null);
    return AppCard(
      onTap: () => context.push(
        Routes.createServer,
        extra: {
          'planSlug': plan.slug,
          'planName': plan.displayName ?? plan.name,
        },
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.displayName ?? plan.name,
            style: AppTypography.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.xs),
          if (specs?.vcpuLabel != null)
            _spec(Icons.memory, specs!.vcpuLabel!),
          if (specs?.ramLabel != null)
            _spec(Icons.sd_card_outlined, specs!.ramLabel!),
          if (specs?.ssdLabel != null)
            _spec(Icons.storage_outlined, specs!.ssdLabel!),
          if (specs?.transfer != null)
            _spec(Icons.swap_vert, specs!.transfer!),
          const Spacer(),
          if (price != null) ...[
            Text(
              price,
              style: AppTypography.display.copyWith(
                fontSize: 22,
                color: AppColors.accent,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Text('/month', style: AppTypography.caption),
          ] else
            const Text('Custom pricing', style: AppTypography.caption),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            children: [
              Text(
                'Tap to configure',
                style: AppTypography.caption.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_forward,
                size: 13,
                color: AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    )
        .animate(delay: (index * 50).ms)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.06, end: 0);
  }

  Widget _spec(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textMuted),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: AppTypography.caption
                  .copyWith(color: AppColors.textSecondary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
