import 'package:freezed_annotation/freezed_annotation.dart';

part 'region.freezed.dart';
part 'region.g.dart';

/// One item of `GET /regions/list` (§6.12).
@freezed
class Region with _$Region {
  const factory Region({
    required String slug,
    @JsonKey(name: 'display_name') String? displayName,
  }) = _Region;

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
}
