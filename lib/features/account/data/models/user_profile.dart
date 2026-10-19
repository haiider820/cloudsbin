import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

/// `GET /me` (§6.9). `role` is `user` or `admin`; `referral_code` is null
/// when the user has none.
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required int id,
    required String email,
    required String role,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'referral_code') String? referralCode,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
