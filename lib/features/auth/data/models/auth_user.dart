import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// `user` object in the login response (§6.3) and `GET /me` (§6.9).
/// `referral_code` is present on `/me` only.
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required int id,
    required String email,
    required String role,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'referral_code') String? referralCode,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
