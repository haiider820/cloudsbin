import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'server_usage.freezed.dart';
part 'server_usage.g.dart';

/// `GET /servers/usage?id=&force=` 200 (§6.19) — flat, byte counts.
@freezed
class ServerUsage with _$ServerUsage {
  const factory ServerUsage({
    @JsonKey(name: 'bandwidth_in_bytes') int? bandwidthInBytes,
    @JsonKey(name: 'bandwidth_out_bytes') int? bandwidthOutBytes,
    @JsonKey(name: 'total_bytes') int? totalBytes,
    @JsonKey(name: 'limit_bytes') int? limitBytes,
    bool? cached,
    @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? fetchedAt,
    @JsonKey(name: 'server_id') int? serverId,
  }) = _ServerUsage;

  factory ServerUsage.fromJson(Map<String, dynamic> json) =>
      _$ServerUsageFromJson(json);
}
