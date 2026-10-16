import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../shared/enums/app_enums.dart';
import '../../../shared/models/paged.dart';
import 'models/credential_reveal.dart';
import 'models/firewall.dart';
import 'models/ip_whitelist.dart';
import 'models/power_action.dart';
import 'models/power_response.dart';
import 'models/regenerate_result.dart';
import 'models/server_actions.dart';
import 'models/server_detail.dart';
import 'models/server_refresh_result.dart';
import 'models/server_summary.dart';
import 'models/server_usage.dart';

/// Server operations (§6.16–6.29). Sub-resources (usage, whitelist, firewall,
/// credentials, access-port, destroy) are added in their phases.
class ServerRepository {
  ServerRepository(this._client);

  final ApiClient _client;

  Future<Paged<ServerSummary>> list({int page = 1, int perPage = 20}) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'servers/list',
        queryParameters: {'page': page, 'per_page': perPage},
      );
      return Paged.fromJson<ServerSummary>(
        response.data!,
        ServerSummary.fromJson,
      );
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<ServerDetail> detail(int serverId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'servers/detail',
        queryParameters: {'id': serverId},
      );
      return ServerDetail.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Reconciles the server with the provider (§6.18).
  Future<ServerRefreshResult> refresh(int serverId) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/refresh',
        data: {'server_id': serverId},
      );
      return ServerRefreshResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /servers/usage?id=&force=` (§6.19). `force=1` bypasses the 1-hour
  /// cache; budget 10/300s (spent even on failures), then 429 + Retry-After.
  Future<ServerUsage> usage({
    required int serverId,
    bool force = false,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'servers/usage',
        queryParameters: {
          'id': serverId,
          if (force) 'force': 1,
        },
      );
      return ServerUsage.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/destroy` (§6.22). Requires a re-auth grant and the
  /// literal `confirm: true`. The row is retained with status `destroyed`.
  Future<DestroyResult> destroy({
    required int serverId,
    required String reauthToken,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/destroy',
        data: {'server_id': serverId, 'confirm': true},
        options: Options(headers: {'X-Reauth-Token': reauthToken}),
      );
      return DestroyResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/access-port` (§6.26). Queues an agent command.
  Future<AccessPortResult> accessPort({
    required int serverId,
    required int port,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/access-port',
        data: {'server_id': serverId, 'port': port},
      );
      return AccessPortResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/power` — stop / start / reboot. Plain user Bearer: no
  /// `X-Reauth-Token` (not an irreversible destroy) and no idempotency key
  /// (not a money operation). Rate 5/300s per server; 429 carries
  /// `Retry-After`, normalised into [ApiError.retryAfterSeconds].
  Future<PowerResponse> powerAction({
    required int serverId,
    required PowerAction action,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/power',
        data: {'server_id': serverId, 'action': action.name},
      );
      return PowerResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /servers/firewall?id=` (§6.27). Inbound only.
  Future<FirewallResponse> firewall(int serverId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'servers/firewall',
        queryParameters: {'id': serverId},
      );
      return FirewallResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/firewall-add` (§6.28). Direction is always `inbound`;
  /// outbound is rejected with 400 DIRECTION_NOT_SUPPORTED by design.
  Future<FirewallAddResult> firewallAdd({
    required int serverId,
    required FirewallProtocol protocol,
    required int portStart,
    int? portEnd,
    String? sourceCidr,
    String? description,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/firewall-add',
        data: {
          'server_id': serverId,
          'direction': FirewallDirection.inbound.raw,
          'protocol': protocol.raw,
          'port_start': portStart,
          if (portEnd != null) 'port_end': portEnd,
          if (sourceCidr != null && sourceCidr.isNotEmpty)
            'source_cidr': sourceCidr,
          if (description != null && description.isNotEmpty)
            'description': description,
        },
      );
      return FirewallAddResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/firewall-remove` (§6.29).
  Future<FirewallRemoveResult> firewallRemove({
    required int serverId,
    required int ruleId,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/firewall-remove',
        data: {'server_id': serverId, 'rule_id': ruleId},
      );
      return FirewallRemoveResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /servers/ip-whitelist?id=` (§6.23).
  Future<IpWhitelistResponse> ipWhitelist(int serverId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'servers/ip-whitelist',
        queryParameters: {'id': serverId},
      );
      return IpWhitelistResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/ip-whitelist-add` (§6.24). `409 ALREADY_EXISTS` is treated
  /// as success by the caller.
  Future<WhitelistAddResult> ipWhitelistAdd({
    required int serverId,
    required String cidrOrIp,
    String? label,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/ip-whitelist-add',
        data: {
          'server_id': serverId,
          'cidr_or_ip': cidrOrIp,
          if (label != null && label.isNotEmpty) 'label': label,
        },
      );
      return WhitelistAddResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/ip-whitelist-remove` (§6.25).
  Future<WhitelistRemoveResult> ipWhitelistRemove({
    required int serverId,
    required int ruleId,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/ip-whitelist-remove',
        data: {'server_id': serverId, 'rule_id': ruleId},
      );
      return WhitelistRemoveResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Reveals stored credentials. Requires a fresh single-use re-auth grant
  /// passed as `X-Reauth-Token` (§6.20). The grant is supplied per-call only.
  Future<CredentialReveal> credentialsReveal({
    required int serverId,
    required String reauthToken,
    AuthType authType = AuthType.password,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/credentials-reveal',
        data: {'server_id': serverId, 'auth_type': authType.raw},
        options: Options(headers: {'X-Reauth-Token': reauthToken}),
      );
      return CredentialReveal.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// Rotates the root password (§6.21). Requires a re-auth grant.
  Future<RegenerateResult> credentialsRegenerate({
    required int serverId,
    required String reauthToken,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/credentials-regenerate',
        data: {'server_id': serverId},
        options: Options(headers: {'X-Reauth-Token': reauthToken}),
      );
      return RegenerateResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final serverRepositoryProvider = Provider<ServerRepository>(
  (ref) => ServerRepository(ref.watch(apiClientProvider)),
);

/// Detail screen data source; refresh by `ref.invalidate(serverDetailProvider(id))`.
final serverDetailProvider =
    FutureProvider.family<ServerDetail, int>((ref, serverId) {
  return ref.watch(serverRepositoryProvider).detail(serverId);
});
