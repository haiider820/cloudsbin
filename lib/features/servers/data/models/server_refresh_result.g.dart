// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_refresh_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerRefreshResultImpl _$$ServerRefreshResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ServerRefreshResultImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      status: ServerStatus.fromJson(json['status']),
      ipAddress: json['ip_address'] as String?,
      accessPort: (json['access_port'] as num?)?.toInt(),
      planName: json['plan_name'] as String?,
      region: json['region'] as String?,
      os: json['os'] as String?,
      ramGb: (json['ram_gb'] as num?)?.toDouble(),
      ssdGb: (json['ssd_gb'] as num?)?.toInt(),
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      activatedAt: DateFormatter.parseIsoUtc(json['activated_at'] as String?),
      destroyedAt: DateFormatter.parseIsoUtc(json['destroyed_at'] as String?),
      reconciled: json['reconciled'] as bool?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$ServerRefreshResultImplToJson(
        _$ServerRefreshResultImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': ServerStatus.toJson(instance.status),
      'ip_address': instance.ipAddress,
      'access_port': instance.accessPort,
      'plan_name': instance.planName,
      'region': instance.region,
      'os': instance.os,
      'ram_gb': instance.ramGb,
      'ssd_gb': instance.ssdGb,
      'created_at': instance.createdAt?.toIso8601String(),
      'activated_at': instance.activatedAt?.toIso8601String(),
      'destroyed_at': instance.destroyedAt?.toIso8601String(),
      'reconciled': instance.reconciled,
      'reason': instance.reason,
    };
