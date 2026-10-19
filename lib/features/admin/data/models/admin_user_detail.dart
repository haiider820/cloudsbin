import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';
import 'admin_json.dart';

part 'admin_user_detail.freezed.dart';
part 'admin_user_detail.g.dart';

/// `GET /admin/users/detail?user_id=` — profile plus admin-only stats.
@freezed
class AdminUserDetail with _$AdminUserDetail {
  const factory AdminUserDetail({
    required int id,
    required String email,
    @Default('user') String role,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
    String? walletBalanceUsd,
    @JsonKey(name: 'server_count') @Default(0) int serverCount,
    @JsonKey(name: 'is_active') @Default(true) bool isActive,
    @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? lastLoginAt,
    @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
    String? lifetimeSpentUsd,
    @JsonKey(name: 'ticket_count') @Default(0) int ticketCount,
    @JsonKey(name: 'referral_code') String? referralCode,
    @JsonKey(name: 'referred_by_user_id') int? referredByUserId,
    @JsonKey(name: 'last_login_ip') String? lastLoginIp,
  }) = _AdminUserDetail;

  factory AdminUserDetail.fromJson(Map<String, dynamic> json) =>
      _$AdminUserDetailFromJson(json);
}
