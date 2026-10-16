// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'power_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PowerResponseImpl _$$PowerResponseImplFromJson(Map<String, dynamic> json) =>
    _$PowerResponseImpl(
      action: json['action'] as String,
      status: json['status'] as String,
      serverId: (json['server_id'] as num).toInt(),
    );

Map<String, dynamic> _$$PowerResponseImplToJson(_$PowerResponseImpl instance) =>
    <String, dynamic>{
      'action': instance.action,
      'status': instance.status,
      'server_id': instance.serverId,
    };
