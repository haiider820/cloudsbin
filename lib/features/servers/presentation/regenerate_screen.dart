import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../shared/widgets/reauth_sheet.dart';
import '../data/server_repository.dart';

/// Regenerates the server root password — requires a re-auth grant (§6.21).
/// The new value is never returned here; reveal it afterwards.
class RegenerateScreen extends ConsumerStatefulWidget {
  const RegenerateScreen({super.key, required this.serverId});

  final int serverId;

  @override
  ConsumerState<RegenerateScreen> createState() => _RegenerateScreenState();
}

class _RegenerateScreenState extends ConsumerState<RegenerateScreen> {
  bool _busy = false;
  String? _message;
  ApiError? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _regenerate());
  }

  Future<void> _regenerate() async {
    final grant = await showReauthSheet(context);
    if (!mounted || grant == null) return;
    setState(() {
      _busy = true;
      _error = null;
      _message = null;
    });
    try {
      final result = await ref
          .read(serverRepositoryProvider)
          .credentialsRegenerate(
            serverId: widget.serverId,
            reauthToken: grant,
          );
      if (!mounted) return;
      setState(() {
        _message = result.message;
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
      appBar: AppBar(title: const Text('Regenerate password')),
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
    if (_busy) {
      return const CircularProgressIndicator();
    }
    if (_error != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 56, color: theme.colorScheme.error),
          const SizedBox(height: 16),
          Text(_error!.userMessage, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton(onPressed: _regenerate, child: const Text('Try again')),
        ],
      );
    }
    if (_message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 56, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(_message!, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () =>
                context.go(Routes.serverCredentialsPath(widget.serverId)),
            child: const Text('Reveal new password'),
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.autorenew, size: 56, color: theme.colorScheme.outline),
        const SizedBox(height: 16),
        const Text('Confirmation required to regenerate the password.'),
        const SizedBox(height: 24),
        FilledButton(onPressed: _regenerate, child: const Text('Confirm password')),
      ],
    );
  }
}
