import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import '../../../shared/models/paged.dart';
import '../../../shared/utils/idempotency_key.dart';
import 'models/cloud_image.dart';
import 'models/estimate_result.dart';
import 'models/order.dart';
import 'models/plan.dart';
import 'models/region.dart';
import 'models/server_create_result.dart';

/// Catalog + ordering operations (§6.11–6.15, §6.30–6.31).
///
/// Money rules: never do client-side price arithmetic — every price is
/// server-computed. `Idempotency-Key` is generated once per logical
/// operation by the caller and reused on retry; on `422
/// IDEMPOTENCY_MISMATCH` we mint a fresh key and resubmit exactly once.
class OrderRepository {
  OrderRepository(this._client);

  final ApiClient _client;

  Future<PlansResponse> plans() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('plans/list');
      return PlansResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  Future<Paged<Region>> regions() async {
    try {
      final response =
          await _client.dio.get<Map<String, dynamic>>('regions/list');
      return Paged.fromJson<Region>(response.data!, Region.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `GET /images/list?plan_id=<slug>&region=` (§6.13). `plan_id` carries
  /// the plan slug here.
  Future<ImagesResponse> images({
    required String planSlug,
    String? region,
  }) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'images/list',
        queryParameters: {
          'plan_id': planSlug,
          if (region != null && region.isNotEmpty) 'region': region,
        },
      );
      return ImagesResponse.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/estimate` — no money moves (§6.14).
  Future<EstimateResult> estimate({
    required int vcpu,
    required double ramGb,
    required int ssdGb,
    required String region,
  }) async {
    try {
      final response = await _client.dio.post<Map<String, dynamic>>(
        'servers/estimate',
        data: {
          'vcpu': vcpu,
          'ram_gb': ramGb,
          'ssd_gb': ssdGb,
          'region': region,
        },
      );
      return EstimateResult.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /servers/create` (§6.15). Wallet is debited server-side in one
  /// transaction. `idempotencyKey` is generated once per logical operation
  /// by the caller; on `422 IDEMPOTENCY_MISMATCH` we mint a new key and
  /// resubmit exactly once.
  Future<ServerCreateResult> createServer({
    required String planSlug,
    required String region,
    String? image,
    String? sshPublicKey,
    bool autoscale = false,
    Map<String, dynamic>? customSpecs,
    String? idempotencyKey,
  }) async {
    var key = idempotencyKey ?? IdempotencyKey.generate();
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final response = await _client.dio.post<Map<String, dynamic>>(
          'servers/create',
          data: {
            'plan_slug': planSlug,
            'region': region,
            if (image != null && image.isNotEmpty) 'image': image,
            if (sshPublicKey != null && sshPublicKey.isNotEmpty)
              'ssh_public_key': sshPublicKey,
            'autoscale': autoscale,
            if (customSpecs != null) 'custom_specs': customSpecs,
          },
          options: Options(headers: {'Idempotency-Key': key}),
        );
        return ServerCreateResult.fromJson(response.data!);
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

  Future<Paged<OrderItem>> orders({int page = 1, int perPage = 25}) async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>(
        'orders/list',
        queryParameters: {'page': page, 'per_page': perPage},
      );
      return Paged.fromJson<OrderItem>(response.data!, OrderItem.fromJson);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }

  /// `POST /orders/receipt` — multipart (§6.31). The file must already be
  /// validated client-side (JPG/PNG/WEBP/PDF, ≤5 MB). Admin-review flow:
  /// no money moves, no provisioning.
  Future<ReceiptResult> uploadReceipt({
    required String planSlug,
    required String planName,
    required int priceCents,
    String? region,
    String? image,
    bool autoscale = false,
    Map<String, dynamic>? customSpecs,
    required PlatformFile file,
    String? idempotencyKey,
  }) async {
    var key = idempotencyKey ?? IdempotencyKey.generate();
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        final form = FormData.fromMap({
          'plan_slug': planSlug,
          'plan_name': planName,
          'price_cents': priceCents,
          if (region != null && region.isNotEmpty) 'region': region,
          if (image != null && image.isNotEmpty) 'image': image,
          'autoscale': autoscale.toString(),
          if (customSpecs != null) 'custom_specs': customSpecs.toString(),
          'receipt': await MultipartFile.fromFile(
            file.path!,
            filename: file.name,
          ),
        });
        final response = await _client.dio.post<Map<String, dynamic>>(
          'orders/receipt',
          data: form,
          options: Options(headers: {'Idempotency-Key': key}),
        );
        return ReceiptResult.fromJson(response.data!);
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
}

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(ref.watch(apiClientProvider)),
);
