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
  void close({bool force = false}) {}

  _DemoResponse _route(String method, String path, RequestOptions options) {
    // Server sub-resources first (more specific paths).
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
    if (_ends(path, '/servers/detail')) {
      final id = int.tryParse('${options.queryParameters['id']}') ?? 9206568;
      return _ok(_detail(id));
    }
    if (_ends(path, '/servers/refresh')) return _ok(_refresh);
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
    if (_ends(path, '/servers/list')) return _ok(_serversList);
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
    if (_ends(path, '/auth/reauth')) {
      return _ok({
        'reauth_token': 'demo-reauth-grant',
        'expires_at': '2026-10-16T10:09:08Z',
      });
    }
    if (_ends(path, '/auth/login') || _ends(path, '/admin/auth/login')) {
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
    if (_ends(path, '/auth/register') || _ends(path, '/auth/password-forgot')) {
      return _DemoResponse(202, {
        'message':
            'If this email is not already registered, the account has been created.'
      });
    }
    if (_ends(path, '/me') || _ends(path, '/admin/me')) return _ok(_user);
    if (_ends(path, '/home')) return _ok(_home);

    // Unknown endpoint in demo: explicit placeholder error.
    return _DemoResponse(404, {
      'error': 'Demo mode has no sample data for $method $path.',
      'code': 'NOT_FOUND',
      'request_id': '00000000demo0000',
    });
  }

  static bool _ends(String path, String suffix) => path.endsWith(suffix);

  static _DemoResponse _ok(Map<String, dynamic> body) => _DemoResponse(200, body);

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

  static Map<String, dynamic> _detail(int id) => {
        'id': id,
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
}

class _DemoResponse {
  const _DemoResponse(this.status, this.body);

  final int status;
  final Map<String, dynamic> body;
}
