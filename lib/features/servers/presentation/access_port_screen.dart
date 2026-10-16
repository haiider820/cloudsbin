import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
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
      setState(() {
        _currentPort = result.newPort ?? port;
        _submitting = false;
      });
      showInfoSnackBar(
        context,
        result.message ?? 'Access-port change queued.',
      );
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Access port')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings_ethernet),
              title: const Text('Current port'),
              trailing: _loadingCurrent
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      _currentPort?.toString() ?? '—',
                      style: theme.textTheme.titleMedium,
                    ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _portController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'New port',
              helperText: 'Allowed range 1024–65535; reserved ports are rejected.',
              errorText: _portError,
            ),
          ),
          const SizedBox(height: 24),
          LoadingButton(
            loading: _submitting,
            onPressed: _submit,
            icon: const Icon(Icons.save_outlined),
            child: const Text('Queue change'),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'The agent applies the change within a minute. '
                  'Limited to 3 changes per server per day.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
