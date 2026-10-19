import 'package:freezed_annotation/freezed_annotation.dart';

part 'power_response.freezed.dart';
part 'power_response.g.dart';

/// `POST /servers/power` 200 — echoes the requested action plus the status
/// the server transitions into (`stopping` / `booting` / `rebooting`).
@freezed
class PowerResponse with _$PowerResponse {
  const factory PowerResponse({
    required String action,
    required String status,
    @JsonKey(name: 'server_id') required int serverId,
  }) = _PowerResponse;

  factory PowerResponse.fromJson(Map<String, dynamic> json) =>
      _$PowerResponseFromJson(json);
}
