// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminOrderImpl _$$AdminOrderImplFromJson(Map<String, dynamic> json) =>
    _$AdminOrderImpl(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      userEmail: json['user_email'] as String?,
      status: json['status'] as String? ?? 'pending',
      planName: json['plan_name'] as String?,
      totalCents: (json['total_cents'] as num?)?.toInt() ?? 0,
      hasReceipt: json['has_receipt'] as bool? ?? false,
      receiptUrl: json['receipt_url'] as String?,
      adminNote: json['admin_note'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$AdminOrderImplToJson(_$AdminOrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_email': instance.userEmail,
      'status': instance.status,
      'plan_name': instance.planName,
      'total_cents': instance.totalCents,
      'has_receipt': instance.hasReceipt,
      'receipt_url': instance.receiptUrl,
      'admin_note': instance.adminNote,
      'created_at': instance.createdAt?.toIso8601String(),
    };
