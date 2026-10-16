import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/demo/demo_adapter.dart';
import 'package:cloudsbin/core/router/app_router.dart';
import 'package:cloudsbin/core/router/routes.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/admin/data/admin_auth_repository.dart';
import 'package:cloudsbin/features/admin/presentation/admin_dashboard_screen.dart';
import 'package:cloudsbin/features/admin/presentation/admin_login_screen.dart';
import 'package:cloudsbin/features/auth/data/auth_session.dart';
import 'package:cloudsbin/features/auth/presentation/login_screen.dart';
import 'package:cloudsbin/features/auth/presentation/splash_screen.dart';
import 'package:cloudsbin/features/home/presentation/home_screen.dart';

import '../helpers/fakes.dart';

class _FixedUserSession extends SessionNotifier {
  _FixedUserSession(this.initial);

  final SessionStatus initial;

  @override
  SessionState build() => SessionState(status: initial);
}

class _FixedAdminSession extends AdminSessionNotifier {
  _FixedAdminSession(this.initial);

  final SessionStatus initial;

  @override
  SessionState build() => SessionState(status: initial);
}

class _App extends ConsumerWidget {
  const _App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(routerConfig: ref.watch(routerProvider));
  }
}

List<Override> _overrides({
  SessionStatus user = SessionStatus.unauthenticated,
  SessionStatus admin = SessionStatus.unauthenticated,
}) {
  final storage = MemorySecureStorage();
  final client = ApiClient(storage: storage, appVersion: '1.0.0')
    ..dio.httpClientAdapter = DemoAdapter(latency: Duration.zero);
  final adminClient = ApiClient(
    storage: storage,
    appVersion: '1.0.0',
    tokenKeys: TokenKeys.admin,
  )..dio.httpClientAdapter = DemoAdapter(latency: Duration.zero);
  addTearDown(() => (client.dio.httpClientAdapter as DemoAdapter).close());
  addTearDown(() => (adminClient.dio.httpClientAdapter as DemoAdapter).close());
  return [
    sessionProvider.overrideWith(() => _FixedUserSession(user)),
    adminSessionProvider.overrideWith(() => _FixedAdminSession(admin)),
    secureStorageProvider.overrideWithValue(storage),
    apiClientProvider.overrideWithValue(client),
    adminApiClientProvider.overrideWithValue(adminClient),
  ];
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

/// Flushes flutter_animate delay timers, then unmounts the whole tree so
/// router listeners and screen timers are disposed before the fake-async
/// test zone tears down.
Future<void> _unmount(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpWidget(const SizedBox());
  await tester.pump();
}

GoRouter _router(WidgetTester tester) {
  final container = ProviderScope.containerOf(
    tester.element(find.byType(MaterialApp)),
  );
  return container.read(routerProvider);
}

void main() {
  group('router redirect', () {
    testWidgets('unknown session stays on splash', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(user: SessionStatus.unknown),
          child: const _App(),
        ),
      );
      await _settle(tester);

      expect(find.byType(SplashScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
      await _unmount(tester);
    });

    testWidgets('unauthenticated lands on login; deep links bounce back',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(overrides: _overrides(), child: const _App()),
      );
      await _settle(tester);
      expect(find.byType(LoginScreen), findsOneWidget);

      _router(tester).go(Routes.servers);
      await _settle(tester);
      expect(find.byType(LoginScreen), findsOneWidget);

      _router(tester).go(Routes.home);
      await _settle(tester);
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
      await _unmount(tester);
    });

    testWidgets('authenticated lands on home; auth screens bounce away',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(user: SessionStatus.authenticated),
          child: const _App(),
        ),
      );
      await _settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);

      _router(tester).go(Routes.login);
      await _settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);
      await _unmount(tester);
    });

    testWidgets('admin audience redirects independently of the user session',
        (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(
            user: SessionStatus.authenticated,
            admin: SessionStatus.unknown,
          ),
          child: const _App(),
        ),
      );
      await _settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);

      _router(tester).go(Routes.adminDashboard);
      await _settle(tester);
      expect(find.byType(AdminLoginScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);

      _router(tester).go(Routes.home);
      await _settle(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      await _unmount(tester);
    });

    testWidgets('authenticated admin lands on the dashboard', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: _overrides(
            user: SessionStatus.unauthenticated,
            admin: SessionStatus.authenticated,
          ),
          child: const _App(),
        ),
      );
      await _settle(tester);
      expect(find.byType(LoginScreen), findsOneWidget);

      _router(tester).go(Routes.adminLogin);
      await _settle(tester);
      expect(find.byType(AdminDashboardScreen), findsOneWidget);
      expect(find.byType(AdminLoginScreen), findsNothing);
      await _unmount(tester);
    });
  });
}
