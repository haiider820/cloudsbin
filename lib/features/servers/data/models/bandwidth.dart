import 'package:freezed_annotation/freezed_annotation.dart';

part 'bandwidth.freezed.dart';
part 'bandwidth.g.dart';

/// Best-effort bandwidth cache attached to `servers/detail` (§6.17).
/// Shape is UNVERIFIED live — all fields nullable so nothing throws.
@freezed
class Bandwidth with _$Bandwidth {
  const factory Bandwidth({
    @JsonKey(name: 'in_gb') double? inGb,
    @JsonKey(name: 'out_gb') double? outGb,
    @JsonKey(name: 'total_gb') double? totalGb,
    @JsonKey(name: 'reset_day') int? resetDay,
  }) = _Bandwidth;

  factory Bandwidth.fromJson(Map<String, dynamic> json) =>
      _$BandwidthFromJson(json);
}
