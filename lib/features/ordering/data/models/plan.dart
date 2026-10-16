import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan.freezed.dart';
part 'plan.g.dart';

/// One item of `GET /plans/list` (§6.11).
@freezed
class Plan with _$Plan {
  const factory Plan({
    required String slug,
    required String name,
    @JsonKey(name: 'display_name') String? displayName,
    String? description,
    int? vcpu,
    @JsonKey(name: 'ram_gb') double? ramGb,
    @JsonKey(name: 'ssd_gb') int? ssdGb,
    PlanSpecs? specs,
    @JsonKey(name: 'price_cents') int? priceCents,
    @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
    @JsonKey(name: 'price_display') String? priceDisplay,
    @JsonKey(name: 'autoscale_offered') bool? autoscaleOffered,
    @JsonKey(name: 'autoscale_max_slug') String? autoscaleMaxSlug,
    @Default([]) List<PlanRegion> regions,
  }) = _Plan;

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
}

@freezed
class PlanSpecs with _$PlanSpecs {
  const factory PlanSpecs({
    @JsonKey(name: 'vcpu_label') String? vcpuLabel,
    @JsonKey(name: 'ram_label') String? ramLabel,
    @JsonKey(name: 'ssd_label') String? ssdLabel,
    String? transfer,
  }) = _PlanSpecs;

  factory PlanSpecs.fromJson(Map<String, dynamic> json) =>
      _$PlanSpecsFromJson(json);
}

@freezed
class PlanRegion with _$PlanRegion {
  const factory PlanRegion({
    required String slug,
    @JsonKey(name: 'display_name') String? displayName,
  }) = _PlanRegion;

  factory PlanRegion.fromJson(Map<String, dynamic> json) =>
      _$PlanRegionFromJson(json);
}

/// `GET /plans/list` response: standard envelope + `usd_pkr_rate` (§6.11).
@freezed
class PlansResponse with _$PlansResponse {
  const factory PlansResponse({
    @Default([]) List<Plan> items,
    @JsonKey(name: 'usd_pkr_rate') num? usdPkrRate,
    int? page,
    @JsonKey(name: 'per_page') int? perPage,
    int? total,
    @JsonKey(name: 'has_more') bool? hasMore,
  }) = _PlansResponse;

  factory PlansResponse.fromJson(Map<String, dynamic> json) =>
      _$PlansResponseFromJson(json);
}
