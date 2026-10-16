import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/utils/byte_formatter.dart';
import '../../../shared/utils/date_formatter.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../data/models/server_usage.dart';
import '../data/server_repository.dart';

/// `GET /servers/usage?id=` with a `force=1` bypass (§6.19).
class ServerUsageScreen extends ConsumerStatefulWidget {
  const ServerUsageScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<ServerUsageScreen> createState() => _ServerUsageScreenState();
}

class _ServerUsageScreenState extends ConsumerState<ServerUsageScreen> {
  ServerUsage? _usage;
  ApiError? _error;
  bool _loading = false;

  Timer? _ticker;
  int _rateLimitRemaining = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _load({bool force = false}) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      if (!force) _error = null;
    });
    try {
      final usage = await ref.read(serverRepositoryProvider).usage(
            serverId: widget.serverId,
            force: force,
          );
      if (!mounted) return;
      setState(() {
        _usage = usage;
        _error = null;
      });
    } on ApiError catch (e) {
      if (!mounted) return;
      if (e.code == 'RATE_LIMITED' && e.retryAfterSeconds != null) {
        _startRateLimit(e.retryAfterSeconds!);
        showErrorSnackBar(context, e);
      } else {
        setState(() => _error = e);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _startRateLimit(int seconds) {
    _ticker?.cancel();
    setState(() => _rateLimitRemaining = seconds);
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() => _rateLimitRemaining -= 1);
      if (_rateLimitRemaining <= 0) {
        timer.cancel();
        setState(() => _rateLimitRemaining = 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final forced = _rateLimitRemaining > 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Usage')),
      body: _buildBody(context),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _loading || forced ? null : () => _load(force: true),
            icon: const Icon(Icons.bolt),
            label: Text(
              forced ? 'Rate limited · ${_rateLimitRemaining}s' : 'Force refresh',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_loading && _usage == null && _error == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return EmptyState(
        icon: Icons.error_outline,
        title: 'Usage unavailable',
        message: _error!.userMessage,
        action: FilledButton(
          onPressed: () => _load(),
          child: const Text('Retry'),
        ),
      );
    }
    final usage = _usage;
    if (usage == null) {
      return const Center(child: Text('No data.'));
    }

    final theme = Theme.of(context);
    final usedFraction = (usage.limitBytes ?? 0) > 0
        ? ((usage.totalBytes ?? 0) / usage.limitBytes!).clamp(0.0, 1.0)
        : null;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Bandwidth', style: theme.textTheme.titleMedium),
                    const Spacer(),
                    if (usage.cached == true)
                      const Chip(
                        label: Text('cached'),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                _UsageBar(
                  label: 'In',
                  bytes: usage.bandwidthInBytes,
                  fraction: usedFraction,
                ),
                const SizedBox(height: 12),
                _UsageBar(
                  label: 'Out',
                  bytes: usage.bandwidthOutBytes,
                  fraction: usedFraction,
                ),
                const SizedBox(height: 12),
                _UsageBar(
                  label: 'Total',
                  bytes: usage.totalBytes,
                  fraction: usedFraction,
                  emphasize: true,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _KeyValue(
                  label: 'Limit',
                  value: ByteFormatter.toGb(usage.limitBytes),
                ),
                _KeyValue(
                  label: 'Fetched at',
                  value: usage.fetchedAt == null
                      ? '—'
                      : DateFormatter.isoToLocal(usage.fetchedAt!.toIso8601String()),
                ),
                _KeyValue(label: 'Server ID', value: usage.serverId?.toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UsageBar extends StatelessWidget {
  const _UsageBar({
    required this.label,
    required this.bytes,
    required this.fraction,
    this.emphasize = false,
  });

  final String label;
  final int? bytes;
  final double? fraction;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
                fontWeight: emphasize ? FontWeight.bold : null,
              ),
            ),
            const Spacer(),
            Text(
              ByteFormatter.toGb(bytes),
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: emphasize ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        if (emphasize && fraction != null) ...[
          const SizedBox(height: 6),
          LinearProgressIndicator(value: fraction),
        ],
      ],
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          Expanded(child: Text(value ?? '—', style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
