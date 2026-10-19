// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterRequestImpl _$$RegisterRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterRequestImpl(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirm: json['password_confirm'] as String,
      acceptTerms: json['accept_terms'] as bool,
      ref: json['ref'] as String?,
    );

Map<String, dynamic> _$$RegisterRequestImplToJson(
        _$RegisterRequestImpl instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'password_confirm': instance.passwordConfirm,
      'accept_terms': instance.acceptTerms,
      'ref': instance.ref,
    };
