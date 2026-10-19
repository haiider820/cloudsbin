import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';

part 'credential_reveal.freezed.dart';
part 'credential_reveal.g.dart';

/// `POST /servers/credentials-reveal` 200 (§6.20).
/// Note: v1 returns `credential` (the password) + `ip_address` only —
/// there is no separate username field on the wire.
@freezed
class CredentialReveal with _$CredentialReveal {
  const factory CredentialReveal({
    @JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
    required AuthType authType,
    String? credential,
    @JsonKey(name: 'ip_address') String? ipAddress,
  }) = _CredentialReveal;

  factory CredentialReveal.fromJson(Map<String, dynamic> json) =>
      _$CredentialRevealFromJson(json);
}
