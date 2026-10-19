import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_ticket.freezed.dart';
part 'admin_ticket.g.dart';

/// One item of `GET /admin/tickets`.
@freezed
class AdminTicket with _$AdminTicket {
  const factory AdminTicket({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_email') String? userEmail,
    @Default('') String subject,
    @Default('open') String status,
    @Default('normal') String priority,
    @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? lastReplyAt,
    @JsonKey(name: 'unread_count') @Default(0) int unreadCount,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _AdminTicket;

  factory AdminTicket.fromJson(Map<String, dynamic> json) =>
      _$AdminTicketFromJson(json);
}
