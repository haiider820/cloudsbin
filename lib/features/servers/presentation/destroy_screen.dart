import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
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
    final confirmed = await _confirmIrreversible();
    if (!mounted) return;
    if (confirmed != true) {
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

  Future<bool?> _confirmIrreversible() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.warning_amber_rounded,
            color: Theme.of(context).colorScheme.error),
        title: const Text('Destroy this server?'),
        content: const Text(
          'This cannot be undone. The provider instance will be permanently '
          'deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Destroy'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Destroy server')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final theme = Theme.of(context);
    if (_busy) return const CircularProgressIndicator();

    if (_done) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 56, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          const Text('Server destroyed.', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go(Routes.servers),
            child: const Text('Back to servers'),
          ),
        ],
      );
    }

    if (_error != null) {
      // 409 CONFLICT = already destroyed (§6.22).
      final already = _error!.code == 'CONFLICT';
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 56, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(
            already ? 'Already destroyed.' : _error!.userMessage,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => context.go(Routes.servers),
            child: const Text('Back to servers'),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_outline, size: 56, color: theme.colorScheme.error),
        const SizedBox(height: 16),
        Text(
          _awaiting
              ? 'Confirmation required to destroy this server.'
              : 'Preparing…',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
          ),
          onPressed: _start,
          child: const Text('Continue'),
        ),
      ],
    );
  }
}
