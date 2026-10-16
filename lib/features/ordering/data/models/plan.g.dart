// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlanImpl _$$PlanImplFromJson(Map<String, dynamic> json) => _$PlanImpl(
      slug: json['slug'] as String,
      name: json['name'] as String,
      displayName: json['display_name'] as String?,
      description: json['description'] as String?,
      vcpu: (json['vcpu'] as num?)?.toInt(),
      ramGb: (json['ram_gb'] as num?)?.toDouble(),
      ssdGb: (json['ssd_gb'] as num?)?.toInt(),
      specs: json['specs'] == null
          ? null
          : PlanSpecs.fromJson(json['specs'] as Map<String, dynamic>),
      priceCents: (json['price_cents'] as num?)?.toInt(),
      eipPriceCents: (json['eip_price_cents'] as num?)?.toInt(),
      priceDisplay: json['price_display'] as String?,
      autoscaleOffered: json['autoscale_offered'] as bool?,
      autoscaleMaxSlug: json['autoscale_max_slug'] as String?,
      regions: (json['regions'] as List<dynamic>?)
              ?.map((e) => PlanRegion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PlanImplToJson(_$PlanImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'display_name': instance.displayName,
      'description': instance.description,
      'vcpu': instance.vcpu,
      'ram_gb': instance.ramGb,
      'ssd_gb': instance.ssdGb,
      'specs': instance.specs,
      'price_cents': instance.priceCents,
      'eip_price_cents': instance.eipPriceCents,
      'price_display': instance.priceDisplay,
      'autoscale_offered': instance.autoscaleOffered,
      'autoscale_max_slug': instance.autoscaleMaxSlug,
      'regions': instance.regions,
    };

_$PlanSpecsImpl _$$PlanSpecsImplFromJson(Map<String, dynamic> json) =>
    _$PlanSpecsImpl(
      vcpuLabel: json['vcpu_label'] as String?,
      ramLabel: json['ram_label'] as String?,
      ssdLabel: json['ssd_label'] as String?,
      transfer: json['transfer'] as String?,
    );

Map<String, dynamic> _$$PlanSpecsImplToJson(_$PlanSpecsImpl instance) =>
    <String, dynamic>{
      'vcpu_label': instance.vcpuLabel,
      'ram_label': instance.ramLabel,
      'ssd_label': instance.ssdLabel,
      'transfer': instance.transfer,
    };

_$PlanRegionImpl _$$PlanRegionImplFromJson(Map<String, dynamic> json) =>
    _$PlanRegionImpl(
      slug: json['slug'] as String,
      displayName: json['display_name'] as String?,
    );

Map<String, dynamic> _$$PlanRegionImplToJson(_$PlanRegionImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'display_name': instance.displayName,
    };

_$PlansResponseImpl _$$PlansResponseImplFromJson(Map<String, dynamic> json) =>
    _$PlansResponseImpl(
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Plan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      usdPkrRate: json['usd_pkr_rate'] as num?,
      page: (json['page'] as num?)?.toInt(),
      perPage: (json['per_page'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      hasMore: json['has_more'] as bool?,
    );

Map<String, dynamic> _$$PlansResponseImplToJson(_$PlansResponseImpl instance) =>
    <String, dynamic>{
      'items': instance.items,
      'usd_pkr_rate': instance.usdPkrRate,
      'page': instance.page,
      'per_page': instance.perPage,
      'total': instance.total,
      'has_more': instance.hasMore,
    };
