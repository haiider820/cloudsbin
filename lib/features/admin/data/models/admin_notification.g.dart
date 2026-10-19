// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminNotificationImpl _$$AdminNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminNotificationImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      target: json['target'] as String? ?? 'all',
      recipientCount: (json['recipient_count'] as num?)?.toInt() ?? 0,
      sentAt: DateFormatter.parseIsoUtc(json['sent_at'] as String?),
    );

Map<String, dynamic> _$$AdminNotificationImplToJson(
        _$AdminNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'target': instance.target,
      'recipient_count': instance.recipientCount,
      'sent_at': instance.sentAt?.toIso8601String(),
    };
