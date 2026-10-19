import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';
import 'admin_json.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// One item of `GET /admin/users`.
@freezed
class AdminUser with _$AdminUser {
  const factory AdminUser({
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
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
}
