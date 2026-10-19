import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'admin_ticket_detail.freezed.dart';
part 'admin_ticket_detail.g.dart';

/// `GET /admin/tickets/detail?ticket_id=` — the ticket plus its thread.
@freezed
class AdminTicketDetail with _$AdminTicketDetail {
  const factory AdminTicketDetail({
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
    @Default(<AdminTicketMessage>[]) List<AdminTicketMessage> messages,
  }) = _AdminTicketDetail;

  factory AdminTicketDetail.fromJson(Map<String, dynamic> json) =>
      _$AdminTicketDetailFromJson(json);
}

/// One message in a ticket thread. `sender` is `user` or `admin`.
@freezed
class AdminTicketMessage with _$AdminTicketMessage {
  const factory AdminTicketMessage({
    required int id,
    @Default('user') String sender,
    @Default('') String message,
    @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
    DateTime? createdAt,
  }) = _AdminTicketMessage;

  factory AdminTicketMessage.fromJson(Map<String, dynamic> json) =>
      _$AdminTicketMessageFromJson(json);
}
