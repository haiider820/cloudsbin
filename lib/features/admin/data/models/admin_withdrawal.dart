import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';
import 'admin_json.dart';

part 'admin_withdrawal.freezed.dart';
part 'admin_withdrawal.g.dart';

/// One item of `GET /admin/withdrawals`.
@freezed
class AdminWithdrawal with _$AdminWithdrawal {
  const factory AdminWithdrawal({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_email') String? userEmail,
    @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
    String? method,
    @JsonKey(name: 'account_details') String? accountDetails,
    @Default('pending') String status,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _AdminWithdrawal;

  factory AdminWithdrawal.fromJson(Map<String, dynamic> json) =>
      _$AdminWithdrawalFromJson(json);
}
