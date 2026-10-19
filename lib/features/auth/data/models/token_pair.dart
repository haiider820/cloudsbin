import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'token_pair.freezed.dart';
part 'token_pair.g.dart';

/// Access + refresh pair returned by login/refresh (§2.2, §2.4).
@freezed
class TokenPair with _$TokenPair {
  const factory TokenPair({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? accessExpiresAt,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? refreshExpiresAt,
  }) = _TokenPair;

  factory TokenPair.fromJson(Map<String, dynamic> json) =>
      _$TokenPairFromJson(json);
}
