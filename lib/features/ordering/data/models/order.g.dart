// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: (json['id'] as num).toInt(),
      status: PaymentRequestStatus.fromJson(json['status']),
      planSlug: json['plan_slug'] as String?,
      planName: json['plan_name'] as String?,
      planPriceCents: (json['plan_price_cents'] as num?)?.toInt(),
      eipPriceCents: (json['eip_price_cents'] as num?)?.toInt(),
      totalCents: (json['total_cents'] as num?)?.toInt(),
      region: json['region'] as String?,
      image: json['image'] as String?,
      autoscale: json['autoscale'] as bool?,
      customSpecs: json['custom_specs'] as Map<String, dynamic>?,
      hasReceipt: json['has_receipt'] as bool?,
      serverId: (json['server_id'] as num?)?.toInt(),
      serverStatus: ServerStatus.fromJson(json['server_status']),
      ipAddress: json['ip_address'] as String?,
      adminNote: json['admin_note'] as String?,
      createdAt: DateFormatter.parseIsoUtc(json['created_at'] as String?),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': PaymentRequestStatus.toJson(instance.status),
      'plan_slug': instance.planSlug,
      'plan_name': instance.planName,
      'plan_price_cents': instance.planPriceCents,
      'eip_price_cents': instance.eipPriceCents,
      'total_cents': instance.totalCents,
      'region': instance.region,
      'image': instance.image,
      'autoscale': instance.autoscale,
      'custom_specs': instance.customSpecs,
      'has_receipt': instance.hasReceipt,
      'server_id': instance.serverId,
      'server_status': ServerStatus.toJson(instance.serverStatus),
      'ip_address': instance.ipAddress,
      'admin_note': instance.adminNote,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_$ReceiptResultImpl _$$ReceiptResultImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptResultImpl(
      requestId: (json['request_id'] as num).toInt(),
      status: PaymentRequestStatus.fromJson(json['status']),
    );

Map<String, dynamic> _$$ReceiptResultImplToJson(_$ReceiptResultImpl instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'status': PaymentRequestStatus.toJson(instance.status),
    };
