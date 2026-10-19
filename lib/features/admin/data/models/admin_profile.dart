import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_profile.freezed.dart';
part 'admin_profile.g.dart';

/// `GET /admin/me` — the signed-in administrator's identity.
///
/// Admin-only fields; never rendered anywhere in the user app.
@freezed
class AdminProfile with _$AdminProfile {
  const factory AdminProfile({
    required int id,
    required String email,
    required String role,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'referral_code') String? referralCode,
  }) = _AdminProfile;

  factory AdminProfile.fromJson(Map<String, dynamic> json) =>
      _$AdminProfileFromJson(json);
}
