import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';
import 'auth_user.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

/// `POST auth/login` 200 response (§2.2, §6.3).
@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? accessExpiresAt,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? refreshExpiresAt,
    AuthUser? user,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
