import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'order.freezed.dart';
part 'order.g.dart';

/// One item of `GET /orders/list` (§6.30). Customer columns only —
/// `receipt_path` arrives as `has_receipt`.
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required int id,
    @JsonKey(fromJson: PaymentRequestStatus.fromJson, toJson: PaymentRequestStatus.toJson)
    required PaymentRequestStatus status,
    @JsonKey(name: 'plan_slug') String? planSlug,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'plan_price_cents') int? planPriceCents,
    @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
    @JsonKey(name: 'total_cents') int? totalCents,
    String? region,
    String? image,
    bool? autoscale,
    @JsonKey(name: 'custom_specs') Map<String, dynamic>? customSpecs,
    @JsonKey(name: 'has_receipt') bool? hasReceipt,
    @JsonKey(name: 'server_id') int? serverId,
    @JsonKey(name: 'server_status', fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    ServerStatus? serverStatus,
    @JsonKey(name: 'ip_address') String? ipAddress,
    @JsonKey(name: 'admin_note') String? adminNote,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

/// `POST /orders/receipt` → 201 (§6.31). Admin-review flow: no money moves,
/// no provisioning.
@freezed
class ReceiptResult with _$ReceiptResult {
  const factory ReceiptResult({
    @JsonKey(name: 'request_id') required int requestId,
    @JsonKey(fromJson: PaymentRequestStatus.fromJson, toJson: PaymentRequestStatus.toJson)
    required PaymentRequestStatus status,
  }) = _ReceiptResult;

  factory ReceiptResult.fromJson(Map<String, dynamic> json) =>
      _$ReceiptResultFromJson(json);
}
