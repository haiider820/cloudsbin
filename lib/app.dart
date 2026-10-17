import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/router/routes.dart';
import 'core/theme/app_theme.dart';

class CloudsBinApp extends ConsumerStatefulWidget {
  const CloudsBinApp({super.key});

  @override
  ConsumerState<CloudsBinApp> createState() => _CloudsBinAppState();
}

class _CloudsBinAppState extends ConsumerState<CloudsBinApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    // The stream includes the cold-start (initial) link and any warm links.
    _linkSubscription =
        _appLinks.uriLinkStream.listen(_handleDeepLink, onError: (_) {});
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  /// Routes email links (`.../verify-email?token=`, `.../reset-password?token=`)
  /// into the matching in-app screen.
  void _handleDeepLink(Uri uri) {
    final token = uri.queryParameters['token'];
    if (token == null || token.isEmpty) return;

    final path = _pathOf(uri);
    final router = ref.read(routerProvider);
    if (path == Routes.verifyEmail) {
      router.go(Routes.verifyEmailPath(token));
    } else if (path == Routes.resetPassword) {
      router.go(Routes.resetPasswordPath(token));
    }
  }

  /// `cloudsbin://verify-email?...` carries the route in the host, while
  /// `https://cloudsbin.duckdns.org/verify-email?...` carries it in the path.
  /// Normalise both to a leading-slash path.
  String _pathOf(Uri uri) {
    final raw = uri.path.isNotEmpty ? uri.path : uri.host;
    if (raw.isEmpty) return '/';
    return raw.startsWith('/') ? raw : '/$raw';
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'CloudsBin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
