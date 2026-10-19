import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

/// `device` object sent on login (§2.2).
/// `id` is a stable per-install UUID; `platform` is `android`/`ios`.
@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String id,
    String? name,
    required String platform,
    @JsonKey(name: 'app_version') String? appVersion,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}
