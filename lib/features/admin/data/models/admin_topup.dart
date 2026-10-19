import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';
import 'admin_json.dart';

part 'admin_topup.freezed.dart';
part 'admin_topup.g.dart';

/// One item of `GET /admin/topups` — a manual wallet top-up request.
@freezed
class AdminTopup with _$AdminTopup {
  const factory AdminTopup({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_email') String? userEmail,
    @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
    String? method,
    @Default('pending') String status,
    @JsonKey(name: 'receipt_url') String? receiptUrl,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _AdminTopup;

  factory AdminTopup.fromJson(Map<String, dynamic> json) =>
      _$AdminTopupFromJson(json);
}
