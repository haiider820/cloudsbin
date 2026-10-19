// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_withdrawal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminWithdrawalImpl _$$AdminWithdrawalImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminWithdrawalImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      amountUsd: moneyString(json['amount_usd']),
      method: json['method'] as String?,
      accountDetails: json['account_details'] as String?,
      status: json['status'] as String? ?? 'pending',
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$AdminWithdrawalImplToJson(
        _$AdminWithdrawalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
      'amount_usd': instance.amountUsd,
      'method': instance.method,
      'account_details': instance.accountDetails,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
    };
