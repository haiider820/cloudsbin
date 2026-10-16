import 'package:freezed_annotation/freezed_annotation.dart';

part 'estimate_result.freezed.dart';
part 'estimate_result.g.dart';

/// `POST /servers/estimate` response — server-computed, never derived
/// client-side (§6.14).
@freezed
class EstimateResult with _$EstimateResult {
  const factory EstimateResult({
    @JsonKey(name: 'price_cents') int? priceCents,
    @JsonKey(name: 'price_display') String? priceDisplay,
    int? vcpu,
    @JsonKey(name: 'ram_gb') double? ramGb,
    @JsonKey(name: 'ssd_gb') int? ssdGb,
    @JsonKey(name: 'included_ssd') int? includedSsd,
    String? region,
    @JsonKey(name: 'region_slug') String? regionSlug,
  }) = _EstimateResult;

  factory EstimateResult.fromJson(Map<String, dynamic> json) =>
      _$EstimateResultFromJson(json);
}
