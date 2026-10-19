// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserImpl _$$AdminUserImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String? ?? 'user',
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      walletBalanceUsd: moneyString(json['wallet_balance_usd']),
      serverCount: (json['server_count'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      lastLoginAt: DateFormatter.parseIsoUtc(json['last_login_at'] as String?),
    );

Map<String, dynamic> _$$AdminUserImplToJson(_$AdminUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt?.toIso8601String(),
      'wallet_balance_usd': instance.walletBalanceUsd,
      'server_count': instance.serverCount,
      'is_active': instance.isActive,
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
    };
