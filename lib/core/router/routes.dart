/// Named route paths. All navigation goes through these constants.
class Routes {
  const Routes._();

  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  static const String home = '/home';

  static const String servers = '/servers';
  static const String serverDetail = '/servers/:id';
  static const String serverUsage = '/servers/:id/usage';
  static const String serverCredentials = '/servers/:id/credentials';
  static const String serverRegenerate = '/servers/:id/regenerate';
  static const String serverWhitelist = '/servers/:id/whitelist';
  static const String serverFirewall = '/servers/:id/firewall';
  static const String serverAccessPort = '/servers/:id/access-port';
  static const String serverDestroy = '/servers/:id/destroy';

  static const String plans = '/plans';
  static const String regions = '/regions';
  static const String images = '/images';
  static const String estimate = '/estimate';
  static const String createServer = '/create';
  static const String orders = '/orders';
  static const String receiptUpload = '/orders/receipt';

  static const String cryptoCheckout = '/crypto/checkout';
  static const String cryptoOrderStatus = '/crypto/order';

  static const String profile = '/account/profile';
  static const String sessions = '/account/sessions';
  static const String changePassword = '/account/password';

  static const String adminLogin = '/admin/login';
  static const String adminDashboard = '/admin/dashboard';

  static const String settings = '/settings';

  // Phase 12 coming-soon stubs (no v1 endpoints yet).
  static const String walletTopup = '/wallet/topup';
  static const String walletWithdraw = '/wallet/withdraw';
  static const String walletHistory = '/wallet/history';
  static const String tickets = '/support/tickets';
  static const String notificationsList = '/notifications';
  static const String terminal = '/terminal';

  static String serverDetailPath(int id) => '/servers/$id';
  static String serverUsagePath(int id) => '/servers/$id/usage';
  static String serverCredentialsPath(int id) => '/servers/$id/credentials';
  static String serverRegeneratePath(int id) => '/servers/$id/regenerate';
  static String serverWhitelistPath(int id) => '/servers/$id/whitelist';
  static String serverFirewallPath(int id) => '/servers/$id/firewall';
  static String serverAccessPortPath(int id) => '/servers/$id/access-port';
  static String serverDestroyPath(int id) => '/servers/$id/destroy';
}
