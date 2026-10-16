import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'server_refresh_result.freezed.dart';
part 'server_refresh_result.g.dart';

/// `POST /servers/refresh` 200 (§6.18).
/// `reconciled` is false on the fast path (already active), else true.
@freezed
class ServerRefreshResult with _$ServerRefreshResult {
  const factory ServerRefreshResult({
    required int id,
    String? name,
    @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    required ServerStatus status,
    @JsonKey(name: 'ip_address') String? ipAddress,
    @JsonKey(name: 'access_port') int? accessPort,
    @JsonKey(name: 'plan_name') String? planName,
    String? region,
    String? os,
    @JsonKey(name: 'ram_gb') double? ramGb,
    @JsonKey(name: 'ssd_gb') int? ssdGb,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? activatedAt,
    @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? destroyedAt,
    bool? reconciled,
    String? reason,
  }) = _ServerRefreshResult;

  factory ServerRefreshResult.fromJson(Map<String, dynamic> json) =>
      _$ServerRefreshResultFromJson(json);
}
