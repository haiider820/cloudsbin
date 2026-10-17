import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/app_dialog.dart';
import '../../../shared/widgets/app_state_widgets.dart';
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

    final confirmed = await confirmDialog(
      context,
      title: 'Regenerate password?',
      message: 'The current password will be replaced. '
          'You can reveal the new one right after.',
      confirmLabel: 'Regenerate',
      danger: true,
      icon: Icons.autorenew,
    );
    if (!mounted || !confirmed) return;

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
      setState(() => _message = result.message);
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() => _error = e);
    } catch (_) {
      if (!mounted) return;
      setState(() => _error = const ApiError(
            code: 'CLIENT_ERROR',
            message: 'Something went wrong. Please try again.',
          ));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regenerate password')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_busy) {
      return const AppLoadingView(message: 'Regenerating password…');
    }
    if (_error != null) {
      return AppErrorView(
        message: _error!.userMessage,
        retryLabel: 'Try again',
        onRetry: _regenerate,
      );
    }
    if (_message != null) {
      return AppEmptyState(
        icon: Icons.check_circle_outline,
        title: 'Password regenerated',
        message: _message,
        actionLabel: 'Reveal new password',
        onAction: () =>
            context.go(Routes.serverCredentialsPath(widget.serverId)),
      );
    }
    return AppEmptyState(
      icon: Icons.autorenew,
      title: 'Confirmation required to regenerate the password.',
      actionLabel: 'Confirm password',
      onAction: _regenerate,
    );
  }
}
