import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// In-memory Dio adapter used by DEMO mode.
///
/// It answers every endpoint built so far with realistic sample data so the
/// app can be explored without a running backend. Only active when
/// `--dart-define=DEMO=true` (debug builds default to it). Never used in
/// release/production.
class DemoAdapter implements HttpClientAdapter {
  DemoAdapter({this.latency = const Duration(milliseconds: 350)});

  final Duration latency;

  /// Live status of the sample server. Power actions move it
  /// (stop→stopping, start→booting, reboot→rebooting); a 3-second timer puts
  /// it back to `active` so the demo loop keeps working.
  String _demoStatus = 'active';
  Timer? _demoStatusTimer;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    await Future<void>.delayed(latency);
    final method = options.method.toUpperCase();
    final path = options.uri.path;

    final response = _route(method, path, options);
    return ResponseBody.fromString(
      jsonEncode(response.body),
      response.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {
    _demoStatusTimer?.cancel();
  }

  _DemoResponse _route(String method, String path, RequestOptions options) {
    // Admin management first — `/admin/servers/detail` would otherwise match
    // the generic `/servers/detail` rule below and leak the user payload.
    if (_ends(path, '/admin/dashboard')) return _ok(_adminDashboard);
    if (_ends(path, '/admin/users/detail')) return _ok(_adminUserDetail);
    if (_ends(path, '/admin/users/toggle-active')) {
      return _ok({'message': 'User status updated.'});
    }
    if (_ends(path, '/admin/users/change-role')) {
      return _ok({'message': 'User role updated.'});
    }
    if (_ends(path, '/admin/users/adjust-wallet')) {
      return _ok({'message': 'Wallet adjusted.'});
    }
    if (_ends(path, '/admin/users')) return _ok(_adminUsersList);
    if (_ends(path, '/admin/servers/detail')) return _ok(_adminServerDetail);
    if (_ends(path, '/admin/servers/force-destroy')) {
      return _ok({'message': 'Server force-destroyed.'});
    }
    if (_ends(path, '/admin/servers/force-refresh')) {
      return _ok({'message': 'Server refreshed.'});
    }
    if (_ends(path, '/admin/servers')) return _ok(_adminServersList);
    if (_ends(path, '/admin/orders/approve')) {
      return _ok({'message': 'Order approved.'});
    }
    if (_ends(path, '/admin/orders/reject')) {
      return _ok({'message': 'Order rejected.'});
    }
    if (_ends(path, '/admin/orders')) return _ok(_adminOrdersList);
    if (_ends(path, '/admin/topups/approve')) {
      return _ok({'message': 'Top-up approved.'});
    }
    if (_ends(path, '/admin/topups/reject')) {
      return _ok({'message': 'Top-up rejected.'});
    }
    if (_ends(path, '/admin/topups')) return _ok(_adminTopupsList);
    if (_ends(path, '/admin/withdrawals/approve')) {
      return _ok({'message': 'Withdrawal approved.'});
    }
    if (_ends(path, '/admin/withdrawals/reject')) {
      return _ok({'message': 'Withdrawal rejected.'});
    }
    if (_ends(path, '/admin/withdrawals')) return _ok(_adminWithdrawalsList);
    if (_ends(path, '/admin/tickets/detail')) return _ok(_adminTicketDetail);
    if (_ends(path, '/admin/tickets/reply')) {
      return _ok({'message': 'Reply sent.'});
    }
    if (_ends(path, '/admin/tickets/close')) {
      return _ok({'message': 'Ticket closed.'});
    }
    if (_ends(path, '/admin/tickets/set-priority')) {
      return _ok({'message': 'Priority updated.'});
    }
    if (_ends(path, '/admin/tickets')) return _ok(_adminTicketsList);
    if (_ends(path, '/admin/notifications/send')) {
      return _ok({'message': 'Notification sent.', 'recipient_count': 150});
    }
    if (_ends(path, '/admin/notifications/history')) {
      return _ok(_adminNotificationsList);
    }

    // Server sub-resources first (more specific paths).
    if (_ends(path, '/servers/power')) return _power(options);
    if (_ends(path, '/servers/ip-whitelist')) return _ok(_ipWhitelist);
    if (_ends(path, '/servers/ip-whitelist-add')) {
      return _ok({
        'message': 'IP added to the whitelist.',
        'ip_cidr': '198.51.100.77/32',
        'access_port': 22,
      });
    }
    if (_ends(path, '/servers/ip-whitelist-remove')) {
      return _ok({'message': 'IP removed from the whitelist.', 'rule_id': 56, 'removed': true});
    }
    if (_ends(path, '/servers/usage')) return _ok(_usage);
    if (_ends(path, '/servers/firewall')) return _ok(_firewall);
    if (_ends(path, '/servers/firewall-add')) {
      return _ok({
        'message': 'Firewall rule added.',
        'direction': 'inbound',
        'protocol': 'tcp',
        'port_start': 8443,
        'port_end': 8443,
        'source_cidr': '198.51.100.0/24',
        'access_port': 22,
      });
    }
    if (_ends(path, '/servers/firewall-remove')) {
      return _ok({'message': 'Firewall rule removed.', 'rule_id': 92, 'removed': true});
    }
    if (_ends(path, '/servers/destroy')) {
      return _ok({'server_id': 9206568, 'status': 'destroyed'});
    }
    if (_ends(path, '/servers/access-port')) {
      return _ok({
        'message':
            'Access-port change queued; the agent applies it within a minute.',
        'access_port': 22,
        'new_port': 2244,
        'server_id': 9206568,
        'command': {'id': 3, 'step': 'open', 'status': 'pending'},
      });
    }
    if (_ends(path, '/servers/detail')) {
      final id = int.tryParse('${options.queryParameters['id']}') ?? 9206568;
      return _ok(_detail(id));
    }
    if (_ends(path, '/servers/refresh')) {
      return _ok({..._refresh, 'status': _demoStatus});
    }
    if (_ends(path, '/servers/credentials-reveal')) {
      return _ok({
        'auth_type': 'password',
        'credential': 'demo-P@ssw0rd-9x4f',
        'ip_address': '203.0.113.10',
      });
    }
    if (_ends(path, '/servers/credentials-regenerate')) {
      return _ok({
        'server_id': 9206568,
        'message': 'A new root password was generated. Reveal it to see the value.',
      });
    }
    if (_ends(path, '/servers/list')) return _ok(_serversListUpdated());
    if (_ends(path, '/servers/estimate')) {
      return _ok({
        'price_cents': 575,
        'price_display': r'$5.75',
        'vcpu': 1,
        'ram_gb': 1,
        'ssd_gb': 25,
        'included_ssd': 25,
        'region': 'US East',
        'region_slug': 'us-east',
      });
    }

    // Auth + account.
    // Admin audience first — its fixtures must never fall through to the
    // user payloads (an admin dashboard showing the demo *user* was a bug).
    if (_ends(path, '/admin/auth/login')) return _ok(_adminLogin);
    if (_ends(path, '/admin/auth/reauth')) return _ok(_adminReauth);
    if (_ends(path, '/admin/auth/sessions')) return _ok(_adminSessions);
    if (_ends(path, '/admin/auth/logout-all')) return _ok({'revoked': 1});
    if (_ends(path, '/admin/me')) return _ok(_adminUser);

    if (_ends(path, '/auth/reauth')) {
      return _ok({
        'reauth_token': 'demo-reauth-grant',
        'expires_at': '2026-10-16T10:09:08Z',
      });
    }
    if (_ends(path, '/auth/login')) {
      return _ok(_login);
    }
    if (_ends(path, '/auth/refresh')) {
      return _ok({
        'access_token': 'demo-access',
        'access_expires_at': '2026-10-16T10:19:07Z',
        'refresh_token': 'demo-refresh',
        'refresh_expires_at': '2026-11-15T10:04:07Z',
        'retried': false,
      });
    }
    if (_ends(path, '/auth/logout')) return _ok({'logged_out': true});
    if (_ends(path, '/auth/logout-all')) return _ok({'revoked': 3});
    if (_ends(path, '/auth/sessions')) return _ok(_sessions);
    if (_ends(path, '/auth/sessions-revoke')) return _ok({'revoked': true});
    if (_ends(path, '/auth/verify-email')) {
      // Demo always verifies instantly; the fake token is accepted.
      return _ok({'verified': true});
    }
    if (_ends(path, '/auth/password-change')) return _ok({'changed': true});
    if (_ends(path, '/auth/password-reset')) return _ok({'reset': true});
    if (_ends(path, '/auth/register') || _ends(path, '/auth/password-forgot')) {
      return _DemoResponse(202, {
        'message':
            'If this email is not already registered, the account has been created.'
      });
    }
    if (_ends(path, '/me')) return _ok(_user);
    if (_ends(path, '/home')) return _ok(_home);

    // Ordering (Phase 8).
    if (_ends(path, '/plans/list')) return _ok(_plansList);
    if (_ends(path, '/regions/list')) return _ok(_regionsList);
    if (_ends(path, '/images/list')) return _ok(_imagesList);
    if (_ends(path, '/servers/create')) {
      return _ok({
        'id': 9206570,
        'status': 'PROVISIONING',
        'name': 'demo-server-6570',
        'plan_slug': 'standard-1',
        'region': 'us-east',
        'region_slug': 'us-east',
        'image': 'ubuntu-24.04',
        'price_cents': 575,
        'price_display': r'$5.75',
      });
    }
    if (_ends(path, '/orders/list')) return _ok(_ordersList);
    if (_ends(path, '/orders/receipt')) {
      return _DemoResponse(201, {
        'request_id': 4205,
        'status': 'PENDING',
      });
    }

    // Crypto (Phase 9).
    if (_ends(path, '/crypto/assets')) return _ok(_cryptoAssets);
    if (_ends(path, '/crypto/checkout')) {
      return _ok({
        'order_id': 'CRY-2026-000042',
        'asset': 'BTC',
        'chain': 'bitcoin',
        'token_symbol': 'BTC',
        'network_name': 'Bitcoin',
        'wallet_address': 'bc1qdemodemo1234567890abcdef',
        'amount_requested': '0.00008621',
        'expires_in_sec': 1800,
      });
    }
    if (_ends(path, '/crypto/order')) {
      return _ok({
        'order_id': 'CRY-2026-000042',
        'asset': 'BTC',
        'chain': 'bitcoin',
        'token_symbol': 'BTC',
        'network_name': 'Bitcoin',
        'amount_requested': '0.00008621',
        'status': 'PENDING',
        'created_at': '2026-10-16 10:24:00',
        'seconds_left': 1740,
      });
    }

    // Unknown endpoint in demo: explicit placeholder error.
    return _DemoResponse(404, {
      'error': 'Demo mode has no sample data for $method $path.',
      'code': 'NOT_FOUND',
      'request_id': '00000000demo0000',
    });
  }

  static bool _ends(String path, String suffix) => path.endsWith(suffix);

  static _DemoResponse _ok(Map<String, dynamic> body) => _DemoResponse(200, body);

  /// `POST /servers/power` — echoes the action and moves the demo status,
  /// then a 3-second timer transitions it back to `active`.
  _DemoResponse _power(RequestOptions options) {
    final body = options.data is Map
        ? (options.data as Map).cast<String, dynamic>()
        : const <String, dynamic>{};
    final action = body['action']?.toString() ?? '';
    final serverId = (body['server_id'] as num?)?.toInt() ?? 9206568;
    final status = switch (action) {
      'stop' => 'stopping',
      'start' => 'booting',
      'reboot' => 'rebooting',
      _ => null,
    };
    if (status == null) {
      return _DemoResponse(400, {
        'error': 'action must be one of: stop, start, reboot.',
        'code': 'INVALID_ACTION',
        'request_id': '00000000demo0000',
      });
    }
    _demoStatus = status;
    _demoStatusTimer?.cancel();
    _demoStatusTimer = Timer(const Duration(seconds: 3), () {
      _demoStatus = 'active';
    });
    return _ok({'action': action, 'status': status, 'server_id': serverId});
  }

  /// The sample list with the first (live) server carrying [_demoStatus].
  Map<String, dynamic> _serversListUpdated() {
    final items = (_serversList['items'] as List)
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
    items.first['status'] = _demoStatus;
    return {..._serversList, 'items': items};
  }

  // ---- Sample payloads -----------------------------------------------------

  static const Map<String, dynamic> _user = {
    'id': 900152,
    'email': 'demo-user@cloudsbin.local',
    'role': 'user',
    'created_at': '2026-10-12T08:18:39Z',
    'referral_code': 'A2FAAA6E',
  };

  static const Map<String, dynamic> _login = {
    'access_token': 'demo-access-token',
    'access_expires_at': '2026-10-16T10:19:07Z',
    'refresh_token': 'demo-refresh-token',
    'refresh_expires_at': '2026-11-15T10:04:07Z',
    'user': _user,
  };

  // ---- Admin audience fixtures --------------------------------------------

  static const Map<String, dynamic> _adminUser = {
    'id': 900001,
    'email': 'demo-admin@cloudsbin.local',
    'role': 'admin',
    'created_at': '2025-01-01T00:00:00Z',
    'referral_code': null,
  };

  static const Map<String, dynamic> _adminLogin = {
    'access_token': 'demo-admin-access-token',
    'access_expires_at': '2099-12-31T23:59:59Z',
    'refresh_token': 'demo-admin-refresh-token',
    'refresh_expires_at': '2099-12-31T23:59:59Z',
    'user': _adminUser,
  };

  static const Map<String, dynamic> _adminReauth = {
    'reauth_token': 'demo-admin-reauth-token',
    'expires_at': '2099-12-31T23:59:59Z',
  };

  static const Map<String, dynamic> _adminSessions = {
    'items': [
      {
        'id': 1,
        'device_name': 'Demo Admin Device',
        'platform': 'android',
        'app_version': '1.0.0',
        'last_used_at': '2026-10-16T10:04:05Z',
        'last_ip': '127.0.0.1',
        'created_at': '2026-10-16T10:04:05Z',
        'current': true,
      },
    ],
    'page': 1,
    'per_page': 25,
    'total': 1,
    'has_more': false,
  };

  static const Map<String, dynamic> _home = {
    'servers': {'total': 3, 'active': 1, 'provisioning': 1, 'other': 1},
    'wallet': {
      'available_usd': '84.00',
      'pending_usd': '0.00',
      'lifetime_earned_usd': '50.00',
    },
    'unread_notifications': 1,
    'pending_topups': 0,
  };

  static const Map<String, dynamic> _plansList = {
    'items': [
      {
        'slug': 'standard-1',
        'name': 'Standard 1',
        'display_name': 'Standard 1',
        'vcpu': 1,
        'ram_gb': 1.0,
        'ssd_gb': 25,
        'price_cents': 575,
        'price_display': r'$5.75',
        'autoscale_offered': false,
        'regions': [
          {'slug': 'us-east'},
          {'slug': 'eu-west'},
        ],
      },
      {
        'slug': 'standard-2',
        'name': 'Standard 2',
        'display_name': 'Standard 2',
        'vcpu': 2,
        'ram_gb': 4.0,
        'ssd_gb': 80,
        'price_cents': 2400,
        'price_display': r'$24.00',
        'autoscale_offered': false,
        'regions': [
          {'slug': 'us-east'},
        ],
      },
    ],
    'usd_pkr_rate': 282.5,
    'page': 1,
    'per_page': 20,
    'total': 2,
    'has_more': false,
  };

  static const Map<String, dynamic> _regionsList = {
    'items': [
      {'slug': 'us-east', 'display_name': 'US East'},
      {'slug': 'eu-west', 'display_name': 'EU West'},
    ],
    'page': 1,
    'per_page': 20,
    'total': 2,
    'has_more': false,
  };

  static const Map<String, dynamic> _imagesList = {
    'default': 'ubuntu-24.04',
    'images': [
      {'slug': 'ubuntu-24.04', 'name': 'Ubuntu 24.04 LTS'},
      {'slug': 'debian-12', 'name': 'Debian 12'},
    ],
  };

  static const Map<String, dynamic> _ordersList = {
    'items': [
      {
        'id': 4205,
        'status': 'PENDING',
        'plan_slug': 'standard-1',
        'plan_name': 'Standard 1',
        'total_cents': 575,
        'region': 'us-east',
        'has_receipt': false,
        'created_at': '2026-10-16T10:24:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 1,
    'has_more': false,
  };

  static const Map<String, dynamic> _cryptoAssets = {
    'network': 'mainnet',
    'is_testnet': false,
    'assets': [
      {
        'asset': 'BTC',
        'chain': 'bitcoin',
        'label': 'Bitcoin',
        'symbol': 'BTC',
        'network': 'bitcoin',
        'network_name': 'Bitcoin',
        'confirmations_required': 1,
      },
      {
        'asset': 'USDT',
        'chain': 'trc20',
        'label': 'Tether (TRC-20)',
        'symbol': 'USDT',
        'network': 'tron',
        'network_name': 'Tron',
        'confirmations_required': 20,
      },
    ],
    'btc_rate': {
      'rate': 67234.50,
      'updated_at': '2026-10-16 10:20:00',
      'age_sec': 240,
    },
  };

  static const Map<String, dynamic> _serversList = {
    'items': [
      {
        'id': 9206568,
        'name': 'demo-active',
        'status': 'active',
        'ip_address': '203.0.113.10',
        'access_port': 22,
        'plan_name': 'nano',
        'region': 'us-east',
        'os': 'linode/ubuntu22.04',
        'vcpu': 2,
        'ram_gb': 1.0,
        'ssd_gb': 25,
        'created_at': '2026-10-16T10:04:04Z',
        'activated_at': '2026-10-16T10:09:00Z',
        'destroyed_at': null,
        'progress': 100,
        'stage': null,
        'eta_seconds': null,
      },
      {
        'id': 9206569,
        'name': 'demo-building',
        'status': 'provisioning',
        'ip_address': null,
        'access_port': 22,
        'plan_name': 'starter',
        'region': 'europe',
        'os': 'linode/ubuntu24.04',
        'vcpu': 1,
        'ram_gb': 1.0,
        'ssd_gb': 25,
        'created_at': '2026-10-16T10:10:00Z',
        'activated_at': null,
        'destroyed_at': null,
        'progress': 42,
        'stage': 'installing',
        'eta_seconds': 180,
      },
      {
        'id': 9206570,
        'name': 'demo-destroyed',
        'status': 'destroyed',
        'ip_address': null,
        'access_port': 22,
        'plan_name': null,
        'region': 'us-west',
        'os': null,
        'vcpu': null,
        'ram_gb': null,
        'ssd_gb': null,
        'created_at': '2026-10-10T08:00:00Z',
        'activated_at': null,
        'destroyed_at': '2026-10-12T09:00:00Z',
        'progress': 100,
        'stage': null,
        'eta_seconds': null,
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 3,
    'has_more': false,
  };

  Map<String, dynamic> _detail(int id) => {
        'id': id,
        'name': 'demo-active',
        'status': _demoStatus,
        'ip_address': '203.0.113.10',
        'access_port': 22,
        'plan_name': 'nano',
        'region': 'us-east',
        'os': 'linode/ubuntu22.04',
        'vcpu': 2,
        'ram_gb': 1.0,
        'ssd_gb': 25,
        'created_at': '2026-10-16T10:04:04Z',
        'activated_at': '2026-10-16T10:09:00Z',
        'destroyed_at': null,
        'progress': 100,
        'stage': null,
        'eta_seconds': null,
        'bandwidth': {
          'in_gb': 12.5,
          'out_gb': 3.2,
          'total_gb': 15.7,
          'reset_day': 1,
        },
      };

  static const Map<String, dynamic> _refresh = {
    'id': 9206568,
    'name': 'demo-active',
    'status': 'active',
    'ip_address': '203.0.113.10',
    'access_port': 22,
    'plan_name': 'nano',
    'region': 'us-east',
    'os': 'linode/ubuntu22.04',
    'ram_gb': 1.0,
    'ssd_gb': 25,
    'created_at': '2026-10-16T10:04:04Z',
    'activated_at': '2026-10-16T10:09:00Z',
    'destroyed_at': null,
    'reconciled': false,
    'reason': 'already_active',
  };

  static const Map<String, dynamic> _usage = {
    'bandwidth_in_bytes': 13421772800,
    'bandwidth_out_bytes': 3435973837,
    'total_bytes': 16857746637,
    'limit_bytes': 545460846592,
    'cached': false,
    'fetched_at': '2026-10-16T10:12:27Z',
    'server_id': 9206568,
  };

  static const Map<String, dynamic> _ipWhitelist = {
    'ips': [
      {
        'id': 56,
        'ip_cidr': '198.51.100.77/32',
        'port': 22,
        'description': 'office',
        'created_at': '2026-10-16T10:12:37Z',
      },
      {
        'id': 57,
        'ip_cidr': '203.0.113.0/24',
        'port': 22,
        'description': 'vpn',
        'created_at': '2026-10-16T10:13:00Z',
      },
    ],
    'access_port': 22,
  };

  static const Map<String, dynamic> _firewall = {
    'rules': [
      {
        'id': 92,
        'direction': 'inbound',
        'protocol': 'tcp',
        'port_start': 8443,
        'port_end': 8443,
        'ip_cidr': '198.51.100.0/24',
        'description': 'https',
        'created_at': '2026-10-16T10:12:52Z',
      },
      {
        'id': 93,
        'direction': 'inbound',
        'protocol': 'udp',
        'port_start': 51820,
        'port_end': 51820,
        'ip_cidr': '203.0.113.9/32',
        'description': 'wireguard',
        'created_at': '2026-10-16T10:14:00Z',
      },
    ],
    'access_port': 22,
    'directions': ['inbound'],
  };

  static const Map<String, dynamic> _sessions = {
    'items': [
      {
        'id': 228,
        'device_name': 'Pixel 8',
        'platform': 'android',
        'app_version': '1.0.0',
        'last_used_at': '2026-10-16T10:04:05Z',
        'last_ip': '127.0.0.1',
        'created_at': '2026-10-16T10:04:05Z',
        'current': true,
      },
      {
        'id': 229,
        'device_name': 'iPhone 15',
        'platform': 'ios',
        'app_version': '1.0.0',
        'last_used_at': '2026-10-15T09:00:00Z',
        'last_ip': '198.51.100.9',
        'created_at': '2026-10-15T09:00:00Z',
        'current': false,
      },
    ],
    'page': 1,
    'per_page': 25,
    'total': 2,
    'has_more': false,
  };

  // ---- Admin management fixtures ------------------------------------------

  static const Map<String, dynamic> _adminDashboard = {
    'users': {'total': 150, 'new_today': 3, 'new_this_month': 45},
    'servers': {'total': 89, 'active': 67, 'provisioning': 2, 'destroyed': 20},
    'orders': {'pending': 5, 'total_this_month': 34},
    'revenue': {'today_usd': '45.00', 'this_month_usd': '1250.00'},
    'tickets': {'open': 8, 'unread': 3},
    'topups': {'pending_count': 2, 'pending_amount_usd': '75.00'},
  };

  static const Map<String, dynamic> _adminUsersList = {
    'items': [
      {
        'id': 900152,
        'email': 'demo-user@cloudsbin.local',
        'role': 'user',
        'created_at': '2026-10-12T08:18:39Z',
        'wallet_balance_usd': '84.00',
        'server_count': 3,
        'is_active': true,
        'last_login_at': '2026-10-16T10:04:05Z',
      },
      {
        'id': 900153,
        'email': 'sara.k@example.com',
        'role': 'user',
        'created_at': '2026-09-30T12:00:00Z',
        'wallet_balance_usd': '12.50',
        'server_count': 1,
        'is_active': true,
        'last_login_at': '2026-10-15T18:22:00Z',
      },
      {
        'id': 900154,
        'email': 'banned@example.com',
        'role': 'user',
        'created_at': '2026-08-21T09:10:00Z',
        'wallet_balance_usd': '0.00',
        'server_count': 0,
        'is_active': false,
        'last_login_at': '2026-09-01T07:45:00Z',
      },
      {
        'id': 900155,
        'email': 'ops@cloudsbin.local',
        'role': 'admin',
        'created_at': '2026-07-01T00:00:00Z',
        'wallet_balance_usd': '0.00',
        'server_count': 2,
        'is_active': true,
        'last_login_at': '2026-10-16T09:00:00Z',
      },
      {
        'id': 900156,
        'email': 'bilal@example.com',
        'role': 'user',
        'created_at': '2026-10-01T14:30:00Z',
        'wallet_balance_usd': '250.00',
        'server_count': 5,
        'is_active': true,
        'last_login_at': '2026-10-16T08:12:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 5,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminUserDetail = {
    'id': 900152,
    'email': 'demo-user@cloudsbin.local',
    'role': 'user',
    'created_at': '2026-10-12T08:18:39Z',
    'wallet_balance_usd': '84.00',
    'server_count': 3,
    'is_active': true,
    'last_login_at': '2026-10-16T10:04:05Z',
    'lifetime_spent_usd': '310.75',
    'ticket_count': 4,
    'referral_code': 'A2FAAA6E',
    'referred_by_user_id': null,
    'last_login_ip': '203.0.113.9',
  };

  static const Map<String, dynamic> _adminServersList = {
    'items': [
      {
        'id': 9206568,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'status': 'active',
        'plan_name': 'nano',
        'region': 'us-east',
        'ip_address': '203.0.113.10',
        'created_at': '2026-10-16T10:04:04Z',
        'provider_slug': 'linode',
      },
      {
        'id': 9206569,
        'user_id': 900153,
        'user_email': 'sara.k@example.com',
        'status': 'provisioning',
        'plan_name': 'starter',
        'region': 'europe',
        'ip_address': null,
        'created_at': '2026-10-16T10:10:00Z',
        'provider_slug': 'aws',
      },
      {
        'id': 9206570,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'status': 'active',
        'plan_name': 'standard-1',
        'region': 'us-west',
        'ip_address': '198.51.100.42',
        'created_at': '2026-10-05T08:00:00Z',
        'provider_slug': 'digitalocean',
      },
      {
        'id': 9206571,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'status': 'destroyed',
        'plan_name': null,
        'region': 'us-west',
        'ip_address': null,
        'created_at': '2026-10-01T08:00:00Z',
        'provider_slug': 'digitalocean',
      },
      {
        'id': 9206572,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'status': 'offline',
        'plan_name': 'nano',
        'region': 'us-east',
        'ip_address': '203.0.113.55',
        'created_at': '2026-10-14T11:00:00Z',
        'provider_slug': 'linode',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 5,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminServerDetail = {
    'id': 9206568,
    'user_id': 900152,
    'user_email': 'demo-user@cloudsbin.local',
    'status': 'active',
    'plan_name': 'nano',
    'region': 'us-east',
    'ip_address': '203.0.113.10',
    'created_at': '2026-10-16T10:04:04Z',
    'provider_slug': 'linode',
  };

  static const Map<String, dynamic> _adminOrdersList = {
    'items': [
      {
        'id': 4205,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'status': 'pending',
        'plan_name': 'Standard 1',
        'total_cents': 575,
        'has_receipt': true,
        'receipt_url': 'https://example.com/receipts/4205.png',
        'admin_note': null,
        'created_at': '2026-10-16T10:24:00Z',
      },
      {
        'id': 4206,
        'user_id': 900153,
        'user_email': 'sara.k@example.com',
        'status': 'pending',
        'plan_name': 'Standard 2',
        'total_cents': 2400,
        'has_receipt': false,
        'receipt_url': null,
        'admin_note': null,
        'created_at': '2026-10-16T11:02:00Z',
      },
      {
        'id': 4207,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'status': 'pending',
        'plan_name': 'Standard 1',
        'total_cents': 575,
        'has_receipt': true,
        'receipt_url': 'https://example.com/receipts/4207.png',
        'admin_note': null,
        'created_at': '2026-10-16T11:30:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 3,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminTopupsList = {
    'items': [
      {
        'id': 7781,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'amount_usd': '50.00',
        'method': 'bank_transfer',
        'status': 'pending',
        'receipt_url': 'https://example.com/topups/7781.jpg',
        'created_at': '2026-10-16T09:12:00Z',
      },
      {
        'id': 7782,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'amount_usd': '25.00',
        'method': 'easypaisa',
        'status': 'pending',
        'receipt_url': 'https://example.com/topups/7782.jpg',
        'created_at': '2026-10-16T10:45:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 2,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminWithdrawalsList = {
    'items': [
      {
        'id': 3310,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'amount_usd': '120.00',
        'method': 'bank_transfer',
        'account_details': 'HBL 1234-5678-9012 · Bilal Khan',
        'status': 'pending',
        'created_at': '2026-10-16T08:30:00Z',
      },
      {
        'id': 3311,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'amount_usd': '40.00',
        'method': 'jazzcash',
        'account_details': '0300-1234567',
        'status': 'pending',
        'created_at': '2026-10-16T09:55:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 2,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminTicketsList = {
    'items': [
      {
        'id': 501,
        'user_id': 900152,
        'user_email': 'demo-user@cloudsbin.local',
        'subject': 'Cannot SSH into my server',
        'status': 'open',
        'priority': 'urgent',
        'last_reply_at': '2026-10-16T10:30:00Z',
        'unread_count': 2,
        'created_at': '2026-10-16T09:00:00Z',
      },
      {
        'id': 502,
        'user_id': 900153,
        'user_email': 'sara.k@example.com',
        'subject': 'Billing question',
        'status': 'open',
        'priority': 'normal',
        'last_reply_at': '2026-10-16T10:05:00Z',
        'unread_count': 1,
        'created_at': '2026-10-15T14:00:00Z',
      },
      {
        'id': 503,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'subject': 'Upgrade plan',
        'status': 'closed',
        'priority': 'low',
        'last_reply_at': '2026-10-14T11:00:00Z',
        'unread_count': 0,
        'created_at': '2026-10-13T08:00:00Z',
      },
      {
        'id': 504,
        'user_id': 900156,
        'user_email': 'bilal@example.com',
        'subject': 'Refund request',
        'status': 'closed',
        'priority': 'high',
        'last_reply_at': '2026-10-12T16:00:00Z',
        'unread_count': 0,
        'created_at': '2026-10-11T10:00:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 4,
    'has_more': false,
  };

  static const Map<String, dynamic> _adminTicketDetail = {
    'id': 501,
    'user_id': 900152,
    'user_email': 'demo-user@cloudsbin.local',
    'subject': 'Cannot SSH into my server',
    'status': 'open',
    'priority': 'urgent',
    'last_reply_at': '2026-10-16T10:30:00Z',
    'unread_count': 2,
    'created_at': '2026-10-16T09:00:00Z',
    'messages': [
      {
        'id': 9001,
        'sender': 'user',
        'message': 'Hi, I cannot connect via SSH since this morning.',
        'created_at': '2026-10-16T09:00:00Z',
      },
      {
        'id': 9002,
        'sender': 'admin',
        'message': 'Thanks for reaching out — checking your firewall rules now.',
        'created_at': '2026-10-16T09:15:00Z',
      },
      {
        'id': 9003,
        'sender': 'user',
        'message': 'Still timing out on port 22.',
        'created_at': '2026-10-16T10:30:00Z',
      },
    ],
  };

  static const Map<String, dynamic> _adminNotificationsList = {
    'items': [
      {
        'id': 61,
        'title': 'Scheduled maintenance',
        'message': 'We will perform maintenance on 2026-10-20 from 02:00–04:00 UTC.',
        'target': 'all',
        'recipient_count': 150,
        'sent_at': '2026-10-15T09:00:00Z',
      },
      {
        'id': 62,
        'title': 'Wallet credited',
        'message': 'Your top-up of \$50.00 has been approved.',
        'target': 'user',
        'recipient_count': 1,
        'sent_at': '2026-10-16T09:20:00Z',
      },
    ],
    'page': 1,
    'per_page': 20,
    'total': 2,
    'has_more': false,
  };
}

class _DemoResponse {
  const _DemoResponse(this.status, this.body);

  final int status;
  final Map<String, dynamic> body;
}
