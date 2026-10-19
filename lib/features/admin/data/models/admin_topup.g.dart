// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_topup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminTopupImpl _$$AdminTopupImplFromJson(Map<String, dynamic> json) =>
    _$AdminTopupImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      amountUsd: moneyString(json['amount_usd']),
      method: json['method'] as String?,
      status: json['status'] as String? ?? 'pending',
      receiptUrl: json['receipt_url'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$AdminTopupImplToJson(_$AdminTopupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
      'amount_usd': instance.amountUsd,
      'method': instance.method,
      'status': instance.status,
      'receipt_url': instance.receiptUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };
