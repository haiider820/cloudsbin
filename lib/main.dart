import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'app.dart';
import 'core/api/api_client.dart';
import 'core/demo/demo_adapter.dart';
import 'core/demo/demo_mode.dart';
import 'features/auth/data/auth_session.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appVersion = await _resolveAppVersion();

  final container = ProviderContainer(
    overrides: [appVersionProvider.overrideWithValue(appVersion)],
  );

  // Wire the interceptor's unrecoverable-401 bounce into the session, keeping
  // core/api free of any dependency on the auth feature.
  container.read(apiClientProvider).onSessionExpired = () {
    container.read(sessionProvider.notifier).logoutLocal();
  };

  if (kDemoMode) {
    // Demo: serve sample data locally and skip the login gate so every built
    // screen can be explored without a backend.
    container.read(apiClientProvider).dio.httpClientAdapter = DemoAdapter();
    container
        .read(sessionProvider.notifier)
        .markAuthenticated(email: 'demo-user@cloudsbin.local');
  } else {
    // Real API: resolve the initial route from persisted tokens.
    await container.read(sessionProvider.notifier).bootstrap();
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const CloudsBinApp(),
    ),
  );
}

Future<String> _resolveAppVersion() async {
  try {
    final info = await PackageInfo.fromPlatform();
    return info.version.isEmpty ? '1.0.0' : info.version;
  } catch (_) {
    return '1.0.0';
  }
}
