import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../shared/utils/money_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
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
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final err = snapshot.error;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      err is ApiError ? err.userMessage : 'Could not load plans.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _reload,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          final plans = snapshot.data?.items ?? [];
          if (plans.isEmpty) {
            return const EmptyState(
              icon: Icons.inventory_2_outlined,
              title: 'No plans available',
              message: 'Check back later for available plans.',
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: plans.length,
            itemBuilder: (context, i) => _PlanCard(plan: plans[i]),
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan});

  final Plan plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final specs = plan.specs;
    final price = plan.priceDisplay ??
        (plan.priceCents != null
            ? MoneyFormatter.fromCents(plan.priceCents!)
            : null);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(
          Routes.createServer,
          extra: {
            'planSlug': plan.slug,
            'planName': plan.displayName ?? plan.name,
          },
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.displayName ?? plan.name,
                style: theme.textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              if (specs?.vcpuLabel != null)
                _spec(theme, Icons.memory, specs!.vcpuLabel!),
              if (specs?.ramLabel != null)
                _spec(theme, Icons.sd_card_outlined, specs!.ramLabel!),
              if (specs?.ssdLabel != null)
                _spec(theme, Icons.storage_outlined, specs!.ssdLabel!),
              if (specs?.transfer != null)
                _spec(theme, Icons.swap_vert, specs!.transfer!),
              const Spacer(),
              if (price != null)
                Text(
                  '$price /mo',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 4),
              Text(
                'Tap to configure',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spec(ThemeData theme, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.outline),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
