import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_response.freezed.dart';
part 'message_response.g.dart';

/// Generic `{message: "..."}` success body (register, password-forgot, etc.).
@freezed
class MessageResponse with _$MessageResponse {
  const factory MessageResponse({
    required String message,
  }) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}
