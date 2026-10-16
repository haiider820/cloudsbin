// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseImpl _$$LoginResponseImplFromJson(Map<String, dynamic> json) =>
    _$LoginResponseImpl(
      accessToken: json['access_token'] as String,
      accessExpiresAt:
          DateFormatter.parseIsoUtc(json['access_expires_at'] as String?),
      refreshToken: json['refresh_token'] as String,
      refreshExpiresAt:
          DateFormatter.parseIsoUtc(json['refresh_expires_at'] as String?),
      user: json['user'] == null
          ? null
          : AuthUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LoginResponseImplToJson(_$LoginResponseImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'access_expires_at': instance.accessExpiresAt?.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'refresh_expires_at': instance.refreshExpiresAt?.toIso8601String(),
      'user': instance.user,
    };
