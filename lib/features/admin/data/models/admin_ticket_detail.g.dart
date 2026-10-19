// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_ticket_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminTicketDetailImpl _$$AdminTicketDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminTicketDetailImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      subject: json['subject'] as String? ?? '',
      status: json['status'] as String? ?? 'open',
      priority: json['priority'] as String? ?? 'normal',
      lastReplyAt: DateFormatter.parseIsoUtc(json['last_reply_at'] as String?),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      messages: (json['messages'] as List<dynamic>?)
              ?.map(
                  (e) => AdminTicketMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AdminTicketMessage>[],
    );

Map<String, dynamic> _$$AdminTicketDetailImplToJson(
        _$AdminTicketDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
      'subject': instance.subject,
      'status': instance.status,
      'priority': instance.priority,
      'last_reply_at': instance.lastReplyAt?.toIso8601String(),
      'unread_count': instance.unreadCount,
      'created_at': instance.createdAt?.toIso8601String(),
      'messages': instance.messages,
    };

_$AdminTicketMessageImpl _$$AdminTicketMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminTicketMessageImpl(
      id: (json['id'] as num).toInt(),
      sender: json['sender'] as String? ?? 'user',
      message: json['message'] as String? ?? '',
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$AdminTicketMessageImplToJson(
        _$AdminTicketMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'message': instance.message,
      'created_at': instance.createdAt?.toIso8601String(),
    };
