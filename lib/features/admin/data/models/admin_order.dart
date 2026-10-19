import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_order.freezed.dart';
part 'admin_order.g.dart';

/// One item of `GET /admin/orders`.
@freezed
class AdminOrder with _$AdminOrder {
  const factory AdminOrder({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_email') String? userEmail,
    @Default('pending') String status,
    @JsonKey(name: 'plan_name') String? planName,
    @JsonKey(name: 'total_cents') @Default(0) int totalCents,
    @JsonKey(name: 'has_receipt') @Default(false) bool hasReceipt,
    @JsonKey(name: 'receipt_url') String? receiptUrl,
    @JsonKey(name: 'admin_note') String? adminNote,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _AdminOrder;

  factory AdminOrder.fromJson(Map<String, dynamic> json) =>
      _$AdminOrderFromJson(json);
}
