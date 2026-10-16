// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_usage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerUsageImpl _$$ServerUsageImplFromJson(Map<String, dynamic> json) =>
    _$ServerUsageImpl(
      bandwidthInBytes: (json['bandwidth_in_bytes'] as num?)?.toInt(),
      bandwidthOutBytes: (json['bandwidth_out_bytes'] as num?)?.toInt(),
      totalBytes: (json['total_bytes'] as num?)?.toInt(),
      limitBytes: (json['limit_bytes'] as num?)?.toInt(),
      cached: json['cached'] as bool?,
      fetchedAt: DateFormatter.parseIsoUtc(json['fetched_at'] as String?),
      serverId: (json['server_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ServerUsageImplToJson(_$ServerUsageImpl instance) =>
    <String, dynamic>{
      'bandwidth_in_bytes': instance.bandwidthInBytes,
      'bandwidth_out_bytes': instance.bandwidthOutBytes,
      'total_bytes': instance.totalBytes,
      'limit_bytes': instance.limitBytes,
      'cached': instance.cached,
      'fetched_at': instance.fetchedAt?.toIso8601String(),
      'server_id': instance.serverId,
    };
