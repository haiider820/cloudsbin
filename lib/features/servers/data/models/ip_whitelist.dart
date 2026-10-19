import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'ip_whitelist.freezed.dart';
part 'ip_whitelist.g.dart';

/// One whitelist row (§6.23).
@freezed
class WhitelistIp with _$WhitelistIp {
  const factory WhitelistIp({
    required int id,
    @JsonKey(name: 'ip_cidr') String? ipCidr,
    int? port,
    String? description,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _WhitelistIp;

  factory WhitelistIp.fromJson(Map<String, dynamic> json) =>
      _$WhitelistIpFromJson(json);
}

/// `GET /servers/ip-whitelist?id=` 200 (§6.23).
@freezed
class IpWhitelistResponse with _$IpWhitelistResponse {
  const factory IpWhitelistResponse({
    @Default(<WhitelistIp>[]) List<WhitelistIp> ips,
    @JsonKey(name: 'access_port') int? accessPort,
  }) = _IpWhitelistResponse;

  factory IpWhitelistResponse.fromJson(Map<String, dynamic> json) =>
      _$IpWhitelistResponseFromJson(json);
}

/// `POST /servers/ip-whitelist-add` 200 (§6.24).
@freezed
class WhitelistAddResult with _$WhitelistAddResult {
  const factory WhitelistAddResult({
    String? message,
    @JsonKey(name: 'ip_cidr') String? ipCidr,
    @JsonKey(name: 'access_port') int? accessPort,
  }) = _WhitelistAddResult;

  factory WhitelistAddResult.fromJson(Map<String, dynamic> json) =>
      _$WhitelistAddResultFromJson(json);
}

/// `POST /servers/ip-whitelist-remove` 200 (§6.25).
@freezed
class WhitelistRemoveResult with _$WhitelistRemoveResult {
  const factory WhitelistRemoveResult({
    String? message,
    @JsonKey(name: 'rule_id') int? ruleId,
    bool? removed,
  }) = _WhitelistRemoveResult;

  factory WhitelistRemoveResult.fromJson(Map<String, dynamic> json) =>
      _$WhitelistRemoveResultFromJson(json);
}
