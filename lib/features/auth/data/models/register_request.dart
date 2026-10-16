import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request.freezed.dart';
part 'register_request.g.dart';

/// `POST auth/register` body (§2.1).
/// `full_name` is validated but never stored server-side.
@freezed
class RegisterRequest with _$RegisterRequest {
  const factory RegisterRequest({
    @JsonKey(name: 'full_name') required String fullName,
    required String email,
    required String password,
    @JsonKey(name: 'password_confirm') required String passwordConfirm,
    @JsonKey(name: 'accept_terms') required bool acceptTerms,
    String? ref,
  }) = _RegisterRequest;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
}
