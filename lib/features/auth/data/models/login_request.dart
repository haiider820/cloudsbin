import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_info.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// `POST auth/login` body (§2.2).
@freezed
class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
    required DeviceInfo device,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
