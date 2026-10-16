import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_session.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/servers/presentation/credentials_screen.dart';
import '../../features/servers/presentation/regenerate_screen.dart';
import '../../features/servers/presentation/server_detail_screen.dart';
import '../../features/servers/presentation/server_list_screen.dart';
import '../../features/servers/presentation/server_usage_screen.dart';
import '../../features/servers/presentation/whitelist_screen.dart';
import '../../shared/widgets/coming_soon_screen.dart';
import 'routes.dart';

/// Single GoRouter instance with an auth-aware redirect.
///
/// Redirect rules:
///   * session unknown   → splash
///   * unauthenticated   → any auth screen, else /login
///   * authenticated     → auth screens redirect to /home
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen<SessionState>(sessionProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final status = ref.read(sessionProvider).status;
      final location = state.matchedLocation;
      final onAuthScreen = location == Routes.login ||
          location == Routes.register ||
          location == Routes.forgotPassword;
      final onSplash = location == Routes.splash;

      switch (status) {
        case SessionStatus.unknown:
          return onSplash ? null : Routes.splash;
        case SessionStatus.unauthenticated:
          return onAuthScreen ? null : Routes.login;
        case SessionStatus.authenticated:
          if (onAuthScreen || onSplash) return Routes.home;
          return null;
      }
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.servers,
        builder: (context, state) => const ServerListScreen(),
      ),
      GoRoute(
        path: Routes.serverDetail,
        builder: (context, state) => ServerDetailScreen(
          serverId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.serverUsage,
        builder: (context, state) => ServerUsageScreen(
          serverId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.serverWhitelist,
        builder: (context, state) => WhitelistScreen(
          serverId: int.parse(state.pathParameters['id']!),
        ),
      ),
      _comingSoon(Routes.serverFirewall, 'Firewall'),
      GoRoute(
        path: Routes.serverCredentials,
        builder: (context, state) => CredentialsScreen(
          serverId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: Routes.serverRegenerate,
        builder: (context, state) => RegenerateScreen(
          serverId: int.parse(state.pathParameters['id']!),
        ),
      ),
      _comingSoon(Routes.serverAccessPort, 'Access port'),
      _comingSoon(Routes.serverDestroy, 'Destroy server'),
    ],
  );
});

GoRoute _comingSoon(String path, String title) => GoRoute(
      path: path,
      builder: (context, state) => ComingSoonScreen(title: title),
    );
