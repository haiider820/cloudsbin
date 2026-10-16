import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../shared/enums/app_enums.dart';
import '../../../shared/models/paged.dart';
import 'models/credential_reveal.dart';
import 'models/regenerate_result.dart';
import 'models/server_detail.dart';
import 'models/server_refresh_result.dart';
import 'models/server_summary.dart';

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
