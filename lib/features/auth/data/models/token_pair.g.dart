// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenPairImpl _$$TokenPairImplFromJson(Map<String, dynamic> json) =>
    _$TokenPairImpl(
      accessToken: json['access_token'] as String,
      accessExpiresAt:
          DateFormatter.parseIsoUtc(json['access_expires_at'] as String?),
      refreshToken: json['refresh_token'] as String,
      refreshExpiresAt:
          DateFormatter.parseIsoUtc(json['refresh_expires_at'] as String?),
    );

Map<String, dynamic> _$$TokenPairImplToJson(_$TokenPairImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'access_expires_at': instance.accessExpiresAt?.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'refresh_expires_at': instance.refreshExpiresAt?.toIso8601String(),
    };
