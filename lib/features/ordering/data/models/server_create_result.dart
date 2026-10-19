import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';

part 'server_create_result.freezed.dart';
part 'server_create_result.g.dart';

/// `POST /servers/create` → 201 (§6.15). Price is server-computed and
/// debited from the wallet in one transaction.
@freezed
class ServerCreateResult with _$ServerCreateResult {
  const factory ServerCreateResult({
    @JsonKey(name: 'server_id') required int serverId,
    @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    required ServerStatus status,
    @JsonKey(name: 'payment_request_id') int? paymentRequestId,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'price_cents') int? priceCents,
    @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
    @JsonKey(name: 'total_cents') int? totalCents,
    bool? autoscale,
  }) = _ServerCreateResult;

  factory ServerCreateResult.fromJson(Map<String, dynamic> json) =>
      _$ServerCreateResultFromJson(json);
}
