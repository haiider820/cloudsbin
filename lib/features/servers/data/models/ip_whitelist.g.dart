// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_whitelist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WhitelistIpImpl _$$WhitelistIpImplFromJson(Map<String, dynamic> json) =>
    _$WhitelistIpImpl(
      id: (json['id'] as num).toInt(),
      ipCidr: json['ip_cidr'] as String?,
      port: (json['port'] as num?)?.toInt(),
      description: json['description'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$WhitelistIpImplToJson(_$WhitelistIpImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ip_cidr': instance.ipCidr,
      'port': instance.port,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$IpWhitelistResponseImpl _$$IpWhitelistResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$IpWhitelistResponseImpl(
      ips: (json['ips'] as List<dynamic>?)
              ?.map((e) => WhitelistIp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WhitelistIp>[],
      accessPort: (json['access_port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$IpWhitelistResponseImplToJson(
        _$IpWhitelistResponseImpl instance) =>
    <String, dynamic>{
      'ips': instance.ips,
      'access_port': instance.accessPort,
    };

_$WhitelistAddResultImpl _$$WhitelistAddResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WhitelistAddResultImpl(
      message: json['message'] as String?,
      ipCidr: json['ip_cidr'] as String?,
      accessPort: (json['access_port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WhitelistAddResultImplToJson(
        _$WhitelistAddResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ip_cidr': instance.ipCidr,
      'access_port': instance.accessPort,
    };

_$WhitelistRemoveResultImpl _$$WhitelistRemoveResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WhitelistRemoveResultImpl(
      message: json['message'] as String?,
      ruleId: (json['rule_id'] as num?)?.toInt(),
      removed: json['removed'] as bool?,
    );

Map<String, dynamic> _$$WhitelistRemoveResultImplToJson(
        _$WhitelistRemoveResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'rule_id': instance.ruleId,
      'removed': instance.removed,
    };
