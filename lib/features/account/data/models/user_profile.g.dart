// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      referralCode: json['referral_code'] as String?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt?.toIso8601String(),
      'referral_code': instance.referralCode,
    };
