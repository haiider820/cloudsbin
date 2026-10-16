// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_reveal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CredentialRevealImpl _$$CredentialRevealImplFromJson(
        Map<String, dynamic> json) =>
    _$CredentialRevealImpl(
      authType: AuthType.fromJson(json['authType']),
      credential: json['credential'] as String?,
      ipAddress: json['ip_address'] as String?,
    );

Map<String, dynamic> _$$CredentialRevealImplToJson(
        _$CredentialRevealImpl instance) =>
    <String, dynamic>{
      'authType': AuthType.toJson(instance.authType),
      'credential': instance.credential,
      'ip_address': instance.ipAddress,
    };
