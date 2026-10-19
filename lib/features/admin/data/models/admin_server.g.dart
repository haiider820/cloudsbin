// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminServerImpl _$$AdminServerImplFromJson(Map<String, dynamic> json) =>
    _$AdminServerImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      status: ServerStatus.fromJson(json['status']),
      planName: json['plan_name'] as String?,
      region: json['region'] as String?,
      ipAddress: json['ip_address'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      providerSlug: json['provider_slug'] as String?,
    );

Map<String, dynamic> _$$AdminServerImplToJson(_$AdminServerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
      'status': ServerStatus.toJson(instance.status),
      'plan_name': instance.planName,
      'region': instance.region,
      'ip_address': instance.ipAddress,
      'created_at': instance.createdAt?.toIso8601String(),
      'provider_slug': instance.providerSlug,
    };
