import 'package:freezed_annotation/freezed_annotation.dart';

part 'regenerate_result.freezed.dart';
part 'regenerate_result.g.dart';

/// `POST /servers/credentials-regenerate` 200 (§6.21).
/// The new credential is never in the response — reveal it separately.
@freezed
class RegenerateResult with _$RegenerateResult {
  const factory RegenerateResult({
    @JsonKey(name: 'server_id') required int serverId,
    required String message,
  }) = _RegenerateResult;

  factory RegenerateResult.fromJson(Map<String, dynamic> json) =>
      _$RegenerateResultFromJson(json);
}
