import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_error.dart';
import '../../../shared/widgets/error_snackbar.dart';
import '../../../shared/widgets/loading_button.dart';
import '../../auth/data/auth_session.dart';
import '../data/admin_auth_repository.dart';

/// Phase 11 — admin sign-in (§5.1).
class AdminLoginScreen extends ConsumerStatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  ConsumerState<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends ConsumerState<AdminLoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref.read(adminAuthRepositoryProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      await ref.read(adminSessionProvider.notifier).refresh();
    } on ApiError catch (e) {
      if (mounted) showErrorSnackBar(context, e);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Admin sign in')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            color: theme.colorScheme.secondaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'This is the admin audience, not the user app. '
                'Admin tokens are stored separately and never shared.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Admin email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          LoadingButton(
            loading: _submitting,
            onPressed: _submit,
            child: const Text('Sign in as admin'),
          ),
        ],
      ),
    );
  }
}
