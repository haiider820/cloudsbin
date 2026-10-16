import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/router/routes.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../shared/widgets/loading_button.dart';
import '../data/auth_repository.dart';
import '../data/auth_session.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitting = false;
  bool _obscure = true;
  String? _formError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String get _platform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
      default:
        return 'android';
    }
  }

  Future<void> _submit() async {
    setState(() {
      _formError = null;
      _emailError = null;
      _passwordError = null;
    });
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _submitting = true);
    try {
      final storage = ref.read(secureStorageProvider);
      final deviceId = await storage.getOrCreateDeviceId();
      final response = await ref.read(authRepositoryProvider).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            deviceId: deviceId,
            platform: _platform,
            appVersion: ref.read(appVersionProvider),
          );
      if (!mounted) return;
      ref.read(sessionProvider.notifier).markAuthenticated(
            email: response.user?.email ?? _emailController.text.trim(),
          );
      // The router redirect reacts to the session change.
    } on ApiError catch (e) {
      if (!mounted) return;
      setState(() {
        if (e.code == 'AUTH_REQUIRED') {
          _formError = e.message;
        } else if (e.code == 'VALIDATION_FAILED') {
          final msg = e.message.toLowerCase();
          if (msg.contains('email')) {
            _emailError = e.message;
          } else if (msg.contains('password')) {
            _passwordError = e.message;
          } else {
            _formError = e.message;
          }
        } else {
          _formError = e.userMessage;
        }
      });
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(Icons.cloud_outlined, size: 56, color: theme.colorScheme.primary),
                    const SizedBox(height: 16),
                    Text('CloudsBin', textAlign: TextAlign.center, style: theme.textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to manage your servers',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                    ),
                    const SizedBox(height: 32),
                    if (_formError != null) ...[
                      _ErrorBanner(message: _formError!),
                      const SizedBox(height: 16),
                    ],
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.mail_outline),
                        errorText: _emailError,
                      ),
                      validator: (value) {
                        final v = value?.trim() ?? '';
                        if (v.isEmpty) return 'Email is required';
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscure,
                      autofillHints: const [AutofillHints.password],
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        errorText: _passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (value) =>
                          (value == null || value.isEmpty) ? 'Password is required' : null,
                    ),
                    const SizedBox(height: 24),
                    LoadingButton(
                      loading: _submitting,
                      onPressed: _submit,
                      child: const Text('Sign in'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _submitting ? null : () => context.go(Routes.forgotPassword),
                      child: const Text('Forgot password?'),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: _submitting ? null : () => context.go(Routes.register),
                          child: const Text('Sign up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: scheme.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: TextStyle(color: scheme.onErrorContainer)),
          ),
        ],
      ),
    );
  }
}
