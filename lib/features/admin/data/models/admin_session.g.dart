// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminSessionImpl _$$AdminSessionImplFromJson(Map<String, dynamic> json) =>
    _$AdminSessionImpl(
      id: (json['id'] as num).toInt(),
      deviceName: json['device_name'] as String?,
      platform: json['platform'] as String?,
      appVersion: json['app_version'] as String?,
      lastUsedAt: DateFormatter.parseIsoUtc(json['last_used_at'] as String?),
      lastIp: json['last_ip'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      current: json['current'] as bool? ?? false,
    );

Map<String, dynamic> _$$AdminSessionImplToJson(_$AdminSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.deviceName,
      'platform': instance.platform,
      'app_version': instance.appVersion,
      'last_used_at': instance.lastUsedAt?.toIso8601String(),
      'last_ip': instance.lastIp,
      'created_at': instance.createdAt?.toIso8601String(),
      'current': instance.current,
    };
