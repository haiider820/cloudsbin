// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firewall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirewallRuleImpl _$$FirewallRuleImplFromJson(Map<String, dynamic> json) =>
    _$FirewallRuleImpl(
      id: (json['id'] as num).toInt(),
      direction: FirewallDirection.fromJson(json['direction']),
      protocol: FirewallProtocol.fromJson(json['protocol']),
      portStart: (json['port_start'] as num?)?.toInt(),
      portEnd: (json['port_end'] as num?)?.toInt(),
      ipCidr: json['ip_cidr'] as String?,
      description: json['description'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$FirewallRuleImplToJson(_$FirewallRuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'direction': FirewallDirection.toJson(instance.direction),
      'protocol': FirewallProtocol.toJson(instance.protocol),
      'port_start': instance.portStart,
      'port_end': instance.portEnd,
      'ip_cidr': instance.ipCidr,
      'description': instance.description,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$FirewallResponseImpl _$$FirewallResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FirewallResponseImpl(
      rules: (json['rules'] as List<dynamic>?)
              ?.map((e) => FirewallRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FirewallRule>[],
      accessPort: (json['access_port'] as num?)?.toInt(),
      directions: (json['directions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$FirewallResponseImplToJson(
        _$FirewallResponseImpl instance) =>
    <String, dynamic>{
      'rules': instance.rules,
      'access_port': instance.accessPort,
      'directions': instance.directions,
    };

_$FirewallAddResultImpl _$$FirewallAddResultImplFromJson(
        Map<String, dynamic> json) =>
    _$FirewallAddResultImpl(
      message: json['message'] as String?,
      direction: FirewallDirection.fromJson(json['direction']),
      protocol: FirewallProtocol.fromJson(json['protocol']),
      portStart: (json['port_start'] as num?)?.toInt(),
      portEnd: (json['port_end'] as num?)?.toInt(),
      sourceCidr: json['source_cidr'] as String?,
      accessPort: (json['access_port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FirewallAddResultImplToJson(
        _$FirewallAddResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'direction': FirewallDirection.toJson(instance.direction),
      'protocol': FirewallProtocol.toJson(instance.protocol),
      'port_start': instance.portStart,
      'port_end': instance.portEnd,
      'source_cidr': instance.sourceCidr,
      'access_port': instance.accessPort,
    };

_$FirewallRemoveResultImpl _$$FirewallRemoveResultImplFromJson(
        Map<String, dynamic> json) =>
    _$FirewallRemoveResultImpl(
      message: json['message'] as String?,
      ruleId: (json['rule_id'] as num?)?.toInt(),
      removed: json['removed'] as bool?,
    );

Map<String, dynamic> _$$FirewallRemoveResultImplToJson(
        _$FirewallRemoveResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'rule_id': instance.ruleId,
      'removed': instance.removed,
    };
