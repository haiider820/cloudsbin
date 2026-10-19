import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/auth_session.dart';
import '../../features/auth/presentation/email_verification_screen.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/verify_email_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/servers/presentation/access_port_screen.dart';
import '../../features/servers/presentation/credentials_screen.dart';
import '../../features/servers/presentation/destroy_screen.dart';
import '../../features/servers/presentation/firewall_screen.dart';
import '../../features/servers/presentation/regenerate_screen.dart';
import '../../features/servers/presentation/server_detail_screen.dart';
import '../../features/servers/presentation/server_list_screen.dart';
import '../../features/servers/presentation/server_usage_screen.dart';
import '../../features/servers/presentation/whitelist_screen.dart';
import '../../features/ordering/presentation/create_server_screen.dart';
import '../../features/ordering/presentation/crypto_checkout_screen.dart';
import '../../features/ordering/presentation/crypto_order_status_screen.dart';
import '../../features/ordering/presentation/estimate_screen.dart';
import '../../features/ordering/presentation/orders_screen.dart';
import '../../features/ordering/presentation/plans_screen.dart';
import '../../features/ordering/presentation/receipt_upload_screen.dart';
import '../../features/account/presentation/change_password_screen.dart';
import '../../features/account/presentation/profile_screen.dart';
import '../../features/account/presentation/sessions_screen.dart';
import '../../features/account/presentation/settings_screen.dart';
import '../../features/admin/presentation/admin_dashboard_screen.dart';
import '../../features/admin/presentation/admin_login_screen.dart';
import '../../features/admin/presentation/admin_notifications_screen.dart';
import '../../features/admin/presentation/admin_orders_screen.dart';
import '../../features/admin/presentation/admin_profile_screen.dart';
import '../../features/admin/presentation/admin_server_detail_screen.dart';
import '../../features/admin/presentation/admin_servers_screen.dart';
import '../../features/admin/presentation/admin_sessions_screen.dart';
import '../../features/admin/presentation/admin_ticket_detail_screen.dart';
import '../../features/admin/presentation/admin_tickets_screen.dart';
import '../../features/admin/presentation/admin_topups_screen.dart';
import '../../features/admin/presentation/admin_user_detail_screen.dart';
import '../../features/admin/presentation/admin_users_screen.dart';
import '../../features/admin/presentation/admin_withdrawals_screen.dart';
import '../../shared/widgets/coming_soon_screen.dart';
import 'routes.dart';

/// Parses the `:id` path parameter safely. A malformed deep link
/// (e.g. `/servers/abc`) yields 0 instead of throwing a `FormatException`.
int _serverIdOf(GoRouterState state) =>
    int.tryParse(state.pathParameters['id'] ?? '') ?? 0;

/// Route-level guard: an invalid or missing server id bounces to the list.
String? _requireServerId(BuildContext context, GoRouterState state) =>
    _serverIdOf(state) <= 0 ? Routes.servers : null;

/// Single GoRouter instance with an auth-aware redirect.
///
/// Redirect rules:
///   * session unknown   → splash
///   * unauthenticated   → any auth screen, else /login
///   * authenticated     → auth screens redirect to /home
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref.listen<SessionState>(sessionProvider, (_, __) => refresh.value++);
  ref.listen<SessionState>(adminSessionProvider, (_, __) => refresh.value++);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final status = ref.read(sessionProvider).status;
      final adminStatus = ref.read(adminSessionProvider).status;
      final location = state.matchedLocation;
      final onAuthScreen = location == Routes.login ||
          location == Routes.register ||
          location == Routes.forgotPassword;
      // Deep-link / post-register screens stay reachable while signed out
      // (and while signed in, so an email link is never silently dropped).
      final onPublicLink = location == Routes.emailVerificationSent ||
          location == Routes.verifyEmail ||
          location == Routes.resetPassword;
      final onSplash = location == Routes.splash;
      final onAdmin = location.startsWith('/admin');

      // Admin audience has its own auth state and redirect.
      if (onAdmin) {
        switch (adminStatus) {
          case SessionStatus.unknown:
            return Routes.adminLogin;
          case SessionStatus.unauthenticated:
            return location == Routes.adminLogin ? null : Routes.adminLogin;
          case SessionStatus.authenticated:
            return location == Routes.adminLogin
                ? Routes.adminDashboard
                : null;
        }
      }

      switch (status) {
        case SessionStatus.unknown:
          return (onSplash || onPublicLink) ? null : Routes.splash;
        case SessionStatus.unauthenticated:
          return (onAuthScreen || onPublicLink) ? null : Routes.login;
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
        path: Routes.emailVerificationSent,
        builder: (context, state) => EmailVerificationScreen(
          email: state.uri.queryParameters['email'] ?? '',
        ),
      ),
      GoRoute(
        path: Routes.verifyEmail,
        builder: (context, state) => VerifyEmailScreen(
          token: state.uri.queryParameters['token'] ?? '',
        ),
      ),
      GoRoute(
        path: Routes.resetPassword,
        builder: (context, state) => ResetPasswordScreen(
          token: state.uri.queryParameters['token'] ?? '',
        ),
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
        redirect: _requireServerId,
        builder: (context, state) =>
            ServerDetailScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverUsage,
        redirect: _requireServerId,
        builder: (context, state) =>
            ServerUsageScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverWhitelist,
        redirect: _requireServerId,
        builder: (context, state) =>
            WhitelistScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverFirewall,
        redirect: _requireServerId,
        builder: (context, state) =>
            FirewallScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverCredentials,
        redirect: _requireServerId,
        builder: (context, state) =>
            CredentialsScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverRegenerate,
        redirect: _requireServerId,
        builder: (context, state) =>
            RegenerateScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverAccessPort,
        redirect: _requireServerId,
        builder: (context, state) =>
            AccessPortScreen(serverId: _serverIdOf(state)),
      ),
      GoRoute(
        path: Routes.serverDestroy,
        redirect: _requireServerId,
        builder: (context, state) =>
            DestroyScreen(serverId: _serverIdOf(state)),
      ),
      // Ordering (Phase 8).
      GoRoute(
        path: Routes.plans,
        builder: (context, state) => const PlansScreen(),
      ),
      GoRoute(
        path: Routes.estimate,
        builder: (context, state) => const EstimateScreen(),
      ),
      GoRoute(
        path: Routes.createServer,
        builder: (context, state) => CreateServerScreen(
          initialPlanSlug: (state.extra is Map)
              ? (state.extra as Map)['planSlug'] as String?
              : null,
        ),
      ),
      GoRoute(
        path: Routes.orders,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: Routes.receiptUpload,
        builder: (context, state) => const ReceiptUploadScreen(),
      ),
      // Crypto (Phase 9).
      GoRoute(
        path: Routes.cryptoCheckout,
        builder: (context, state) => CryptoCheckoutScreen(
          planSlug: (state.extra is Map)
              ? (state.extra as Map)['planSlug'] as String?
              : null,
          region: (state.extra is Map)
              ? (state.extra as Map)['region'] as String?
              : null,
        ),
      ),
      GoRoute(
        path: Routes.cryptoOrderStatus,
        builder: (context, state) => CryptoOrderStatusScreen(
          orderId: (state.extra is Map)
              ? ((state.extra as Map)['orderId'] as String? ?? '')
              : '',
        ),
      ),
      // Account (Phase 10).
      GoRoute(
        path: Routes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: Routes.sessions,
        builder: (context, state) => const SessionsScreen(),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        path: Routes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      // Admin (Phase 11) — separate audience, separate auth state.
      GoRoute(
        path: Routes.adminLogin,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: Routes.adminDashboard,
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: Routes.adminProfile,
        builder: (context, state) => const AdminProfileScreen(),
      ),
      GoRoute(
        path: Routes.adminSessions,
        builder: (context, state) => const AdminSessionsScreen(),
      ),
      GoRoute(
        path: Routes.adminUsers,
        builder: (context, state) => const AdminUsersScreen(),
      ),
      GoRoute(
        path: Routes.adminUserDetail,
        builder: (context, state) => AdminUserDetailScreen(
          userId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: Routes.adminServers,
        builder: (context, state) => const AdminServersScreen(),
      ),
      GoRoute(
        path: Routes.adminServerDetail,
        builder: (context, state) => AdminServerDetailScreen(
          serverId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: Routes.adminOrders,
        builder: (context, state) => const AdminOrdersScreen(),
      ),
      GoRoute(
        path: Routes.adminTopups,
        builder: (context, state) => const AdminTopupsScreen(),
      ),
      GoRoute(
        path: Routes.adminWithdrawals,
        builder: (context, state) => const AdminWithdrawalsScreen(),
      ),
      GoRoute(
        path: Routes.adminTickets,
        builder: (context, state) => const AdminTicketsScreen(),
      ),
      GoRoute(
        path: Routes.adminTicketDetail,
        builder: (context, state) => AdminTicketDetailScreen(
          ticketId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
        ),
      ),
      GoRoute(
        path: Routes.adminNotifications,
        builder: (context, state) => const AdminNotificationsScreen(),
      ),
      // Phase 12 coming-soon stubs (no v1 endpoints yet).
      GoRoute(
        path: Routes.walletTopup,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Top up wallet',
          subtitle: 'Manual top-up via bank transfer receipt is coming soon.',
        ),
      ),
      GoRoute(
        path: Routes.walletWithdraw,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Withdraw from wallet',
          subtitle: 'Wallet withdrawals are coming soon.',
        ),
      ),
      GoRoute(
        path: Routes.walletHistory,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Wallet history',
          subtitle: 'Transaction history is coming soon.',
        ),
      ),
      GoRoute(
        path: Routes.tickets,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Support tickets',
          subtitle: 'Support tickets are coming soon.',
        ),
      ),
      GoRoute(
        path: Routes.notificationsList,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Notifications',
          subtitle: 'Notifications are coming soon.',
        ),
      ),
      GoRoute(
        path: Routes.terminal,
        builder: (context, state) => const ComingSoonScreen(
          title: 'Terminal / desktop',
          subtitle:
              'Browser terminal access is not part of the v1 API. Use SSH with the credentials from the credentials screen.',
        ),
      ),
    ],
  );
});
