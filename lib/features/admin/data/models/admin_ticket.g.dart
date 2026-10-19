// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminTicketImpl _$$AdminTicketImplFromJson(Map<String, dynamic> json) =>
    _$AdminTicketImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      subject: json['subject'] as String? ?? '',
      status: json['status'] as String? ?? 'open',
      priority: json['priority'] as String? ?? 'normal',
      lastReplyAt: DateFormatter.parseIsoUtc(json['last_reply_at'] as String?),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$AdminTicketImplToJson(_$AdminTicketImpl instance) =>
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
    };
