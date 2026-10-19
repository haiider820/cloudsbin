import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';
import 'bandwidth.dart';

part 'server_detail.freezed.dart';
part 'server_detail.g.dart';

/// `GET /servers/detail?id=` (§6.17) — the list projection plus `bandwidth`.
@freezed
class ServerDetail with _$ServerDetail {
  const factory ServerDetail({
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
    Bandwidth? bandwidth,
  }) = _ServerDetail;

  factory ServerDetail.fromJson(Map<String, dynamic> json) =>
      _$ServerDetailFromJson(json);
}
