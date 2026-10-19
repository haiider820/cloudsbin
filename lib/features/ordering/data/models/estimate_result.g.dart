// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estimate_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EstimateResultImpl _$$EstimateResultImplFromJson(Map<String, dynamic> json) =>
    _$EstimateResultImpl(
      priceCents: (json['price_cents'] as num?)?.toInt(),
      priceDisplay: json['price_display'] as String?,
      vcpu: (json['vcpu'] as num?)?.toInt(),
      ramGb: (json['ram_gb'] as num?)?.toDouble(),
      ssdGb: (json['ssd_gb'] as num?)?.toInt(),
      includedSsd: (json['included_ssd'] as num?)?.toInt(),
      region: json['region'] as String?,
      regionSlug: json['region_slug'] as String?,
    );

Map<String, dynamic> _$$EstimateResultImplToJson(
        _$EstimateResultImpl instance) =>
    <String, dynamic>{
      'price_cents': instance.priceCents,
      'price_display': instance.priceDisplay,
      'vcpu': instance.vcpu,
      'ram_gb': instance.ramGb,
      'ssd_gb': instance.ssdGb,
      'included_ssd': instance.includedSsd,
      'region': instance.region,
      'region_slug': instance.regionSlug,
    };
