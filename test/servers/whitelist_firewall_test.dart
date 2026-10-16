import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';
import 'package:cloudsbin/core/api/api_error.dart';
import 'package:cloudsbin/core/storage/secure_storage.dart';
import 'package:cloudsbin/features/servers/data/server_repository.dart';
import 'package:cloudsbin/shared/enums/app_enums.dart';

import '../helpers/fakes.dart';

/// A container wired to a scripted adapter through the real [ApiError]
/// pipeline, exactly like production runs it.
ProviderContainer _container(List<ScriptedResponse> script) {
  final storage = MemorySecureStorage();
  final client = ApiClient(storage: storage, appVersion: '1.0.0')
    ..dio.httpClientAdapter = ScriptedAdapter(script);
  final container = ProviderContainer(overrides: [
    apiClientProvider.overrideWithValue(client),
    secureStorageProvider.overrideWithValue(storage),
  ]);
  addTearDown(container.dispose);
  return container;
}

ScriptedAdapter _adapter(ProviderContainer c) =>
    c.read(apiClientProvider).dio.httpClientAdapter as ScriptedAdapter;

Future<ApiError?> _capture(Future<Object?> future) async {
  try {
    await future;
    return null;
  } on ApiError catch (e) {
    return e;
  }
}

const _whitelistBody = {
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

const _firewallBody = {
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

void main() {
  group('ServerRepository.ipWhitelist', () {
    test('list parses rows, ports and timestamps', () async {
      final c = _container([
        const ScriptedResponse(200, _whitelistBody),
      ]);

      final result = await c.read(serverRepositoryProvider).ipWhitelist(7);

      expect(result.ips, hasLength(2));
      expect(result.ips.first.ipCidr, '198.51.100.77/32');
      expect(result.ips.first.port, 22);
      expect(result.ips.first.description, 'office');
      expect(result.ips.first.createdAt, isA<DateTime>());
      expect(result.ips.last.ipCidr, '203.0.113.0/24');
      expect(result.accessPort, 22);
    });

    test('add sends the exact payload and parses the result', () async {
      final c = _container([
        const ScriptedResponse(200, {
          'message': 'IP added to the whitelist.',
          'ip_cidr': '200.1.2.3/32',
          'access_port': 22,
        }),
      ]);

      final result = await c.read(serverRepositoryProvider).ipWhitelistAdd(
            serverId: 7,
            cidrOrIp: '200.1.2.3/32',
            label: 'home',
          );

      expect(result.ipCidr, '200.1.2.3/32');
      expect(result.accessPort, 22);
      expect(result.message, contains('whitelist'));

      final sent = _adapter(c).requests.single;
      expect(sent.uri.path, endsWith('servers/ip-whitelist-add'));
      expect(sent.data, {
        'server_id': 7,
        'cidr_or_ip': '200.1.2.3/32',
        'label': 'home',
      });
    });

    test('409 ALREADY_EXISTS surfaces as a typed ApiError', () async {
      final c = _container([
        const ScriptedResponse(409, {
          'error': 'That IP is already whitelisted.',
          'code': 'ALREADY_EXISTS',
          'request_id': 'req-409',
        }),
      ]);

      final err = await _capture(
        c.read(serverRepositoryProvider)
            .ipWhitelistAdd(serverId: 7, cidrOrIp: '198.51.100.77/32'),
      );

      expect(err, isNotNull);
      expect(err!.code, 'ALREADY_EXISTS');
      expect(err.statusCode, 409);
      expect(err.message, contains('already whitelisted'));
    });

    test('remove reports the dropped rule id', () async {
      final c = _container([
        const ScriptedResponse(200, {
          'message': 'IP removed from the whitelist.',
          'rule_id': 56,
          'removed': true,
        }),
      ]);

      final result = await c.read(serverRepositoryProvider).ipWhitelistRemove(
            serverId: 7,
            ruleId: 56,
          );

      expect(result.ruleId, 56);
      expect(result.removed, isTrue);
      expect(_adapter(c).requests.single.data, {
        'server_id': 7,
        'rule_id': 56,
      });
    });

    test('429 on remove → RATE_LIMITED with retryAfter populated', () async {
      final c = _container([
        ScriptedResponse(
          429,
          const {
            'error': 'Too many whitelist changes.',
            'code': 'RATE_LIMITED',
            'request_id': 'req-429',
          },
          headers: const {'retry-after': ['30']},
        ),
      ]);

      final err = await _capture(
        c.read(serverRepositoryProvider)
            .ipWhitelistRemove(serverId: 7, ruleId: 56),
      );

      expect(err, isNotNull);
      expect(err!.code, 'RATE_LIMITED');
      expect(err.statusCode, 429);
      expect(err.retryAfterSeconds, 30);
    });
  });

  group('ServerRepository.firewall', () {
    test('list parses inbound rules, directions and the access port',
        () async {
      final c = _container([
        const ScriptedResponse(200, _firewallBody),
      ]);

      final result = await c.read(serverRepositoryProvider).firewall(7);

      expect(result.rules, hasLength(2));
      expect(result.rules.first.portStart, 8443);
      expect(result.rules.first.portEnd, 8443);
      expect(result.rules.first.ipCidr, '198.51.100.0/24');
      expect(result.rules.first.protocol, FirewallProtocol.tcp);
      expect(result.rules.last.protocol, FirewallProtocol.udp);
      expect(result.rules.first.direction, FirewallDirection.inbound);
      expect(result.rules.first.createdAt, isA<DateTime>());
      expect(result.directions, ['inbound']);
      expect(result.accessPort, 22);
    });

    test('add always sends direction=inbound and parses the echoed rule',
        () async {
      final c = _container([
        const ScriptedResponse(200, {
          'message': 'Firewall rule added.',
          'direction': 'inbound',
          'protocol': 'tcp',
          'port_start': 8443,
          'port_end': 8443,
          'source_cidr': '198.51.100.0/24',
          'access_port': 22,
        }),
      ]);

      final result = await c.read(serverRepositoryProvider).firewallAdd(
            serverId: 7,
            protocol: FirewallProtocol.tcp,
            portStart: 8443,
            portEnd: 8443,
            sourceCidr: '198.51.100.0/24',
            description: 'https',
          );

      expect(result.direction, FirewallDirection.inbound);
      expect(result.protocol, FirewallProtocol.tcp);
      expect(result.portStart, 8443);
      expect(result.portEnd, 8443);
      expect(result.sourceCidr, '198.51.100.0/24');
      expect(result.accessPort, 22);

      final sent = _adapter(c).requests.single;
      expect(sent.data, {
        'server_id': 7,
        'direction': 'inbound',
        'protocol': 'tcp',
        'port_start': 8443,
        'port_end': 8443,
        'source_cidr': '198.51.100.0/24',
        'description': 'https',
      });
    });

    test('remove reports the dropped rule id', () async {
      final c = _container([
        const ScriptedResponse(200, {
          'message': 'Firewall rule removed.',
          'rule_id': 92,
          'removed': true,
        }),
      ]);

      final result = await c.read(serverRepositoryProvider).firewallRemove(
            serverId: 7,
            ruleId: 92,
          );

      expect(result.ruleId, 92);
      expect(result.removed, isTrue);
      expect(_adapter(c).requests.single.data, {
        'server_id': 7,
        'rule_id': 92,
      });
    });

    test('400 DIRECTION_NOT_SUPPORTED parses like any other typed error',
        () async {
      final c = _container([
        const ScriptedResponse(400, {
          'error': 'Outbound rules are not supported.',
          'code': 'DIRECTION_NOT_SUPPORTED',
          'request_id': 'req-400',
        }),
      ]);

      final err = await _capture(
        c.read(serverRepositoryProvider).firewallRemove(serverId: 7, ruleId: 92),
      );

      expect(err, isNotNull);
      expect(err!.code, 'DIRECTION_NOT_SUPPORTED');
      expect(err.statusCode, 400);
    });
  });
}
