// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_create_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServerCreateResultImpl _$$ServerCreateResultImplFromJson(
        Map<String, dynamic> json) =>
    _$ServerCreateResultImpl(
      serverId: (json['server_id'] as num).toInt(),
      status: ServerStatus.fromJson(json['status']),
      paymentRequestId: (json['payment_request_id'] as num?)?.toInt(),
      planName: json['plan_name'] as String?,
      priceCents: (json['price_cents'] as num?)?.toInt(),
      eipPriceCents: (json['eip_price_cents'] as num?)?.toInt(),
      totalCents: (json['total_cents'] as num?)?.toInt(),
      autoscale: json['autoscale'] as bool?,
    );

Map<String, dynamic> _$$ServerCreateResultImplToJson(
        _$ServerCreateResultImpl instance) =>
    <String, dynamic>{
      'server_id': instance.serverId,
      'status': ServerStatus.toJson(instance.status),
      'payment_request_id': instance.paymentRequestId,
      'plan_name': instance.planName,
      'price_cents': instance.priceCents,
      'eip_price_cents': instance.eipPriceCents,
      'total_cents': instance.totalCents,
      'autoscale': instance.autoscale,
    };
