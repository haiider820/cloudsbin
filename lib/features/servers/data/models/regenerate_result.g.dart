// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regenerate_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegenerateResultImpl _$$RegenerateResultImplFromJson(
        Map<String, dynamic> json) =>
    _$RegenerateResultImpl(
      serverId: (json['server_id'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$$RegenerateResultImplToJson(
        _$RegenerateResultImpl instance) =>
    <String, dynamic>{
      'server_id': instance.serverId,
      'message': instance.message,
    };
