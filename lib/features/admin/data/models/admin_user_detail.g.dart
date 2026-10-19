// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserDetailImpl _$$AdminUserDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminUserDetailImpl(
      id: (json['id'] as num).toInt(),
      email: json['email'] as String,
      role: json['role'] as String? ?? 'user',
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
      walletBalanceUsd: moneyString(json['wallet_balance_usd']),
      serverCount: (json['server_count'] as num?)?.toInt() ?? 0,
      isActive: json['is_active'] as bool? ?? true,
      lastLoginAt: DateFormatter.parseIsoUtc(json['last_login_at'] as String?),
      lifetimeSpentUsd: moneyString(json['lifetime_spent_usd']),
      ticketCount: (json['ticket_count'] as num?)?.toInt() ?? 0,
      referralCode: json['referral_code'] as String?,
      referredByUserId: (json['referred_by_user_id'] as num?)?.toInt(),
      lastLoginIp: json['last_login_ip'] as String?,
    );

Map<String, dynamic> _$$AdminUserDetailImplToJson(
        _$AdminUserDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'role': instance.role,
      'created_at': instance.createdAt?.toIso8601String(),
      'wallet_balance_usd': instance.walletBalanceUsd,
      'server_count': instance.serverCount,
      'is_active': instance.isActive,
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
      'lifetime_spent_usd': instance.lifetimeSpentUsd,
      'ticket_count': instance.ticketCount,
      'referral_code': instance.referralCode,
      'referred_by_user_id': instance.referredByUserId,
      'last_login_ip': instance.lastLoginIp,
    };
