import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'auth_session_info.freezed.dart';
part 'auth_session_info.g.dart';

/// One item of `GET /auth/sessions` (§2.6, §6.6).
///
/// Never carries tokens or hashes. `current: true` marks the session the
/// request arrived on — it cannot be self-revoked.
@freezed
class AuthSessionInfo with _$AuthSessionInfo {
  const factory AuthSessionInfo({
    required int id,
    @JsonKey(name: 'device_name') String? deviceName,
    String? platform,
    @JsonKey(name: 'app_version') String? appVersion,
    @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? lastUsedAt,
    @JsonKey(name: 'last_ip') String? lastIp,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @Default(false) bool current,
  }) = _AuthSessionInfo;

  factory AuthSessionInfo.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionInfoFromJson(json);
}
