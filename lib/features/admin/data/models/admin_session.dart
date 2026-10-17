import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_session.freezed.dart';
part 'admin_session.g.dart';

/// One item of `GET /admin/auth/sessions` — an active admin sign-in.
///
/// Never carries tokens or hashes. `current: true` marks the session the
/// request arrived on — it cannot be self-revoked.
@freezed
class AdminSession with _$AdminSession {
  const factory AdminSession({
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
  }) = _AdminSession;

  factory AdminSession.fromJson(Map<String, dynamic> json) =>
      _$AdminSessionFromJson(json);
}
