import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'admin_server.freezed.dart';
part 'admin_server.g.dart';

/// One item of `GET /admin/servers`. Carries the owner and the raw provider
/// slug — admin-only fields never exposed in the user app.
@freezed
class AdminServer with _$AdminServer {
  const factory AdminServer({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_email') String? userEmail,
    @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
    required ServerStatus status,
    @JsonKey(name: 'plan_name') String? planName,
    String? region,
    @JsonKey(name: 'ip_address') String? ipAddress,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
    @JsonKey(name: 'provider_slug') String? providerSlug,
  }) = _AdminServer;

  factory AdminServer.fromJson(Map<String, dynamic> json) =>
      _$AdminServerFromJson(json);
}
