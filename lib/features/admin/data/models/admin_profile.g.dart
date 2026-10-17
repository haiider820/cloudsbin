// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminProfileImpl _$$AdminProfileImplFromJson(Map<String, dynamic> json) =>
    _$AdminProfileImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      referralCode: json['referral_code'] as String?,
    );

Map<String, dynamic> _$$AdminProfileImplToJson(_$AdminProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt?.toIso8601String(),
      'referral_code': instance.referralCode,
    };
