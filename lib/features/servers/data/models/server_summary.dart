import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'server_summary.freezed.dart';
part 'server_summary.g.dart';

/// One row of `GET /servers/list` (§6.16).
@freezed
class ServerSummary with _$ServerSummary {
  const factory ServerSummary({
    required int id,
    String? name,
    @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    required ServerStatus status,
    @JsonKey(name: 'ip_address') String? ipAddress,
    @JsonKey(name: 'access_port') int? accessPort,
    @JsonKey(name: 'plan_name') String? planName,
    String? region,
    String? os,
    int? vcpu,
    @JsonKey(name: 'ram_gb') double? ramGb,
    @JsonKey(name: 'ssd_gb') int? ssdGb,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? activatedAt,
    @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? destroyedAt,
    int? progress,
    String? stage,
    @JsonKey(name: 'eta_seconds') int? etaSeconds,
  }) = _ServerSummary;

  factory ServerSummary.fromJson(Map<String, dynamic> json) =>
      _$ServerSummaryFromJson(json);
}
