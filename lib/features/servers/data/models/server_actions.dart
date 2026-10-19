import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';

part 'server_actions.freezed.dart';
part 'server_actions.g.dart';

/// `POST /servers/destroy` 200 (§6.22) — the row is retained as `destroyed`.
@freezed
class DestroyResult with _$DestroyResult {
  const factory DestroyResult({
    @JsonKey(name: 'server_id') required int serverId,
    @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    ServerStatus? status,
  }) = _DestroyResult;

  factory DestroyResult.fromJson(Map<String, dynamic> json) =>
      _$DestroyResultFromJson(json);
}

/// The queued agent command attached to an access-port change (§6.26).
@freezed
class AccessPortCommand with _$AccessPortCommand {
  const factory AccessPortCommand({
    int? id,
    String? step,
    String? status,
  }) = _AccessPortCommand;

  factory AccessPortCommand.fromJson(Map<String, dynamic> json) =>
      _$AccessPortCommandFromJson(json);
}

/// `POST /servers/access-port` 200 (§6.26).
@freezed
class AccessPortResult with _$AccessPortResult {
  const factory AccessPortResult({
    String? message,
    @JsonKey(name: 'access_port') int? accessPort,
    @JsonKey(name: 'new_port') int? newPort,
    @JsonKey(name: 'server_id') int? serverId,
    AccessPortCommand? command,
  }) = _AccessPortResult;

  factory AccessPortResult.fromJson(Map<String, dynamic> json) =>
      _$AccessPortResultFromJson(json);
}
