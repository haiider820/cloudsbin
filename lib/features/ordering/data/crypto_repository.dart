import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../core/api/response_parser.dart';
import '../../../shared/utils/idempotency_key.dart';
import 'models/crypto_asset.dart';
import 'models/crypto_checkout.dart';
import 'models/crypto_order.dart';

/// Crypto payment operations (§6.32–6.34).
///
/// Money rules: amounts arrive as strings — show verbatim with the asset
/// symbol, never parse for arithmetic. Crypto datetimes use `Y-m-d H:i:s`
/// (see [DateFormatter.parseDbUtc]).
class CryptoRepository {
  CryptoRepository(this._client);

  final ApiClient _client;

  Future<CryptoAssetsResponse> assets() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('crypto/assets');
      return parseResponse(response, CryptoAssetsResponse.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /crypto/checkout` (§6.33). Creates a PENDING order; no chain
  /// activity yet. Price is server-computed. Same idempotency contract as
  /// `servers/create`.
  Future<CryptoCheckoutResult> checkout({
    required String planSlug,
    String? planName,
    required String region,
    String? image,
    bool autoscale = false,
    Map<String, dynamic>? customSpecs,
    String? asset,
    String? chain,
    String? idempotencyKey,
  }) async {
    var key = idempotencyKey ?? IdempotencyKey.generate();
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final response = await _client.dio.post<Map<String, dynamic>>(
          'crypto/checkout',
          data: {
            'plan_slug': planSlug,
            if (planName != null && planName.isNotEmpty)
              'plan_name': planName,
            'region': region,
            if (image != null && image.isNotEmpty) 'image': image,
            'autoscale': autoscale,
            if (customSpecs != null) 'custom_specs': customSpecs,
            if (asset != null && asset.isNotEmpty) 'asset': asset,
            if (chain != null && chain.isNotEmpty) 'chain': chain,
          },
          options: Options(headers: {'Idempotency-Key': key}),
        );
        return parseResponse(response, CryptoCheckoutResult.fromJson);
      } on DioException catch (e) {
        final apiError = ApiError.fromDio(e);
        if (apiError.code == 'IDEMPOTENCY_MISMATCH' && attempt == 0) {
          key = IdempotencyKey.generate();
          continue;
        }
        throw apiError;
      }
    }
    throw const ApiError(
      code: 'IDEMPOTENCY_MISMATCH',
      message: 'That request was already submitted differently.',
    );
  }

  /// `GET /crypto/order?order=CRY-...` (§6.34). Ownership is enforced in SQL.
  Future<CryptoOrder> orderStatus(String orderId) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'crypto/order',
        queryParameters: {'order': orderId},
      );
      return parseResponse(response, CryptoOrder.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final cryptoRepositoryProvider = Provider<CryptoRepository>(
  (ref) => CryptoRepository(ref.watch(apiClientProvider)),
);
