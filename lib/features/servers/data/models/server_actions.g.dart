// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DestroyResultImpl _$$DestroyResultImplFromJson(Map<String, dynamic> json) =>
    _$DestroyResultImpl(
      serverId: (json['server_id'] as num).toInt(),
      status: ServerStatus.fromJson(json['status']),
    );

Map<String, dynamic> _$$DestroyResultImplToJson(_$DestroyResultImpl instance) =>
    <String, dynamic>{
      'server_id': instance.serverId,
      'status': ServerStatus.toJson(instance.status),
    };

_$AccessPortCommandImpl _$$AccessPortCommandImplFromJson(
        Map<String, dynamic> json) =>
    _$AccessPortCommandImpl(
      id: (json['id'] as num?)?.toInt(),
      step: json['step'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$AccessPortCommandImplToJson(
        _$AccessPortCommandImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'step': instance.step,
      'status': instance.status,
    };

_$AccessPortResultImpl _$$AccessPortResultImplFromJson(
        Map<String, dynamic> json) =>
    _$AccessPortResultImpl(
      message: json['message'] as String?,
      accessPort: (json['access_port'] as num?)?.toInt(),
      newPort: (json['new_port'] as num?)?.toInt(),
      serverId: (json['server_id'] as num?)?.toInt(),
      command: json['command'] == null
          ? null
          : AccessPortCommand.fromJson(json['command'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AccessPortResultImplToJson(
        _$AccessPortResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'access_port': instance.accessPort,
      'new_port': instance.newPort,
      'server_id': instance.serverId,
      'command': instance.command,
    };
