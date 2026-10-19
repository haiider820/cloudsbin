import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'firewall.freezed.dart';
part 'firewall.g.dart';

/// One firewall rule (§6.27). Inbound only by design.
@freezed
class FirewallRule with _$FirewallRule {
  const factory FirewallRule({
    required int id,
    @JsonKey(fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
    FirewallDirection? direction,
    @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
    FirewallProtocol? protocol,
    @JsonKey(name: 'port_start') int? portStart,
    @JsonKey(name: 'port_end') int? portEnd,
    @JsonKey(name: 'ip_cidr') String? ipCidr,
    String? description,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _FirewallRule;

  factory FirewallRule.fromJson(Map<String, dynamic> json) =>
      _$FirewallRuleFromJson(json);
}

/// `GET /servers/firewall?id=` 200 (§6.27).
@freezed
class FirewallResponse with _$FirewallResponse {
  const factory FirewallResponse({
    @Default(<FirewallRule>[]) List<FirewallRule> rules,
    @JsonKey(name: 'access_port') int? accessPort,
    @Default(<String>[]) List<String> directions,
  }) = _FirewallResponse;

  factory FirewallResponse.fromJson(Map<String, dynamic> json) =>
      _$FirewallResponseFromJson(json);
}

/// `POST /servers/firewall-add` 200 (§6.28).
@freezed
class FirewallAddResult with _$FirewallAddResult {
  const factory FirewallAddResult({
    String? message,
    @JsonKey(fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
    FirewallDirection? direction,
    @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
    FirewallProtocol? protocol,
    @JsonKey(name: 'port_start') int? portStart,
    @JsonKey(name: 'port_end') int? portEnd,
    @JsonKey(name: 'source_cidr') String? sourceCidr,
    @JsonKey(name: 'access_port') int? accessPort,
  }) = _FirewallAddResult;

  factory FirewallAddResult.fromJson(Map<String, dynamic> json) =>
      _$FirewallAddResultFromJson(json);
}

/// `POST /servers/firewall-remove` 200 (§6.29).
@freezed
class FirewallRemoveResult with _$FirewallRemoveResult {
  const factory FirewallRemoveResult({
    String? message,
    @JsonKey(name: 'rule_id') int? ruleId,
    bool? removed,
  }) = _FirewallRemoveResult;

  factory FirewallRemoveResult.fromJson(Map<String, dynamic> json) =>
      _$FirewallRemoveResultFromJson(json);
}
