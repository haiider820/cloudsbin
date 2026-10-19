// API enums (FLUTTER_API_GUIDE §5) modelled as open value classes so unknown
// values never throw — every type keeps the raw wire string and exposes an
// `unknown`-safe fallback.

/// server `status` (§6.16, §6.17).
class ServerStatus {
  const ServerStatus._(this.raw);

  final String raw;

  static const ServerStatus provisioning = ServerStatus._('provisioning');
  static const ServerStatus booting = ServerStatus._('booting');
  static const ServerStatus stopped = ServerStatus._('stopped');
  static const ServerStatus stopping = ServerStatus._('stopping');
  static const ServerStatus rebooting = ServerStatus._('rebooting');
  static const ServerStatus active = ServerStatus._('active');
  static const ServerStatus destroyed = ServerStatus._('destroyed');
  static const ServerStatus passwordPending = ServerStatus._('password_pending');
  static const ServerStatus suspended = ServerStatus._('suspended');
  static const ServerStatus offline = ServerStatus._('offline');
  static const ServerStatus terminated = ServerStatus._('terminated');
  static const ServerStatus failed = ServerStatus._('failed');
  static const ServerStatus scaling = ServerStatus._('scaling');

  static const List<ServerStatus> known = [
    provisioning,
    booting,
    stopped,
    stopping,
    rebooting,
    active,
    destroyed,
    offline,
    passwordPending,
    suspended,
    terminated,
    failed,
    scaling,
  ];

  factory ServerStatus.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    for (final status in known) {
      if (status.raw == value) return status;
    }
    return ServerStatus._(value.isEmpty ? 'unknown' : value);
  }

  static String? toJson(ServerStatus? status) => status?.raw;

  bool get isActive => raw == 'active';
  bool get isProvisioning => raw == 'provisioning';
  bool get isDestroyed => raw == 'destroyed';

  String get label => raw
      .split('_')
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');

  @override
  bool operator ==(Object other) =>
      other is ServerStatus && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// `payment_requests.status` (§6.31).
class PaymentRequestStatus {
  const PaymentRequestStatus._(this.raw);

  final String raw;

  static const PaymentRequestStatus pending = PaymentRequestStatus._('pending');
  static const PaymentRequestStatus serverCreated =
      PaymentRequestStatus._('server_created');
  static const PaymentRequestStatus rejected = PaymentRequestStatus._('rejected');

  factory PaymentRequestStatus.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    switch (value) {
      case 'pending':
        return pending;
      case 'server_created':
        return serverCreated;
      case 'rejected':
        return rejected;
      default:
        return PaymentRequestStatus._(value.isEmpty ? 'unknown' : value);
    }
  }

  static String? toJson(PaymentRequestStatus? status) => status?.raw;

  @override
  bool operator ==(Object other) =>
      other is PaymentRequestStatus && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// `crypto_payments.status` (§6.34) — UPPERCASE on the wire.
class CryptoPaymentStatus {
  const CryptoPaymentStatus._(this.raw);

  final String raw;

  static const CryptoPaymentStatus pending = CryptoPaymentStatus._('PENDING');
  static const CryptoPaymentStatus paid = CryptoPaymentStatus._('PAID');
  static const CryptoPaymentStatus expired = CryptoPaymentStatus._('EXPIRED');

  factory CryptoPaymentStatus.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    switch (value) {
      case 'PENDING':
        return pending;
      case 'PAID':
        return paid;
      case 'EXPIRED':
        return expired;
      default:
        return CryptoPaymentStatus._(value.isEmpty ? 'UNKNOWN' : value);
    }
  }

  static String? toJson(CryptoPaymentStatus? status) => status?.raw;

  bool get isTerminal => raw != 'PENDING';

  @override
  bool operator ==(Object other) =>
      other is CryptoPaymentStatus && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// `orders.status` (§6.30).
class OrderStatus {
  const OrderStatus._(this.raw);

  final String raw;

  static const OrderStatus active = OrderStatus._('active');
  static const OrderStatus cancelled = OrderStatus._('cancelled');

  factory OrderStatus.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    switch (value) {
      case 'active':
        return active;
      case 'cancelled':
        return cancelled;
      default:
        return OrderStatus._(value.isEmpty ? 'unknown' : value);
    }
  }

  static String? toJson(OrderStatus? status) => status?.raw;

  @override
  bool operator ==(Object other) => other is OrderStatus && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// Device `platform` (§2.2).
class Platform {
  const Platform._(this.raw);

  final String raw;

  static const Platform android = Platform._('android');
  static const Platform ios = Platform._('ios');

  factory Platform.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    return value == 'ios' ? ios : value == 'android' ? android : Platform._(value);
  }

  static String? toJson(Platform? platform) => platform?.raw;

  @override
  bool operator ==(Object other) => other is Platform && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// Firewall `direction` — inbound only by design (§6.27, §6.28).
class FirewallDirection {
  const FirewallDirection._(this.raw);

  final String raw;

  static const FirewallDirection inbound = FirewallDirection._('inbound');

  factory FirewallDirection.fromJson(dynamic raw) =>
      FirewallDirection._(raw?.toString() ?? 'inbound');

  static String? toJson(FirewallDirection? direction) => direction?.raw;

  @override
  bool operator ==(Object other) =>
      other is FirewallDirection && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// Firewall `protocol` (§6.27).
class FirewallProtocol {
  const FirewallProtocol._(this.raw);

  final String raw;

  static const FirewallProtocol tcp = FirewallProtocol._('tcp');
  static const FirewallProtocol udp = FirewallProtocol._('udp');

  factory FirewallProtocol.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    switch (value) {
      case 'tcp':
        return tcp;
      case 'udp':
        return udp;
      default:
        return FirewallProtocol._(value.isEmpty ? 'tcp' : value);
    }
  }

  static String? toJson(FirewallProtocol? protocol) => protocol?.raw;

  @override
  bool operator ==(Object other) =>
      other is FirewallProtocol && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}

/// Credentials reveal `auth_type` (§6.20).
class AuthType {
  const AuthType._(this.raw);

  final String raw;

  static const AuthType password = AuthType._('password');
  static const AuthType ttyd = AuthType._('ttyd');
  static const AuthType vnc = AuthType._('vnc');
  static const AuthType rdp = AuthType._('rdp');

  factory AuthType.fromJson(dynamic raw) {
    final value = raw?.toString() ?? '';
    switch (value) {
      case 'password':
        return password;
      case 'ttyd':
        return ttyd;
      case 'vnc':
        return vnc;
      case 'rdp':
        return rdp;
      default:
        return AuthType._(value.isEmpty ? 'password' : value);
    }
  }

  static String? toJson(AuthType? authType) => authType?.raw;

  @override
  bool operator ==(Object other) => other is AuthType && other.raw == raw;

  @override
  int get hashCode => raw.hashCode;

  @override
  String toString() => raw;
}
