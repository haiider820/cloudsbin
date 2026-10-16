// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'estimate_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EstimateResult _$EstimateResultFromJson(Map<String, dynamic> json) {
  return _EstimateResult.fromJson(json);
}

/// @nodoc
mixin _$EstimateResult {
  @JsonKey(name: 'price_cents')
  int? get priceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_display')
  String? get priceDisplay => throw _privateConstructorUsedError;
  int? get vcpu => throw _privateConstructorUsedError;
  @JsonKey(name: 'ram_gb')
  double? get ramGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'included_ssd')
  int? get includedSsd => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'region_slug')
  String? get regionSlug => throw _privateConstructorUsedError;

  /// Serializes this EstimateResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimateResultCopyWith<EstimateResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimateResultCopyWith<$Res> {
  factory $EstimateResultCopyWith(
          EstimateResult value, $Res Function(EstimateResult) then) =
      _$EstimateResultCopyWithImpl<$Res, EstimateResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'price_cents') int? priceCents,
      @JsonKey(name: 'price_display') String? priceDisplay,
      int? vcpu,
      @JsonKey(name: 'ram_gb') double? ramGb,
      @JsonKey(name: 'ssd_gb') int? ssdGb,
      @JsonKey(name: 'included_ssd') int? includedSsd,
      String? region,
      @JsonKey(name: 'region_slug') String? regionSlug});
}

/// @nodoc
class _$EstimateResultCopyWithImpl<$Res, $Val extends EstimateResult>
    implements $EstimateResultCopyWith<$Res> {
  _$EstimateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceCents = freezed,
    Object? priceDisplay = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? includedSsd = freezed,
    Object? region = freezed,
    Object? regionSlug = freezed,
  }) {
    return _then(_value.copyWith(
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      priceDisplay: freezed == priceDisplay
          ? _value.priceDisplay
          : priceDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      vcpu: freezed == vcpu
          ? _value.vcpu
          : vcpu // ignore: cast_nullable_to_non_nullable
              as int?,
      ramGb: freezed == ramGb
          ? _value.ramGb
          : ramGb // ignore: cast_nullable_to_non_nullable
              as double?,
      ssdGb: freezed == ssdGb
          ? _value.ssdGb
          : ssdGb // ignore: cast_nullable_to_non_nullable
              as int?,
      includedSsd: freezed == includedSsd
          ? _value.includedSsd
          : includedSsd // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      regionSlug: freezed == regionSlug
          ? _value.regionSlug
          : regionSlug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EstimateResultImplCopyWith<$Res>
    implements $EstimateResultCopyWith<$Res> {
  factory _$$EstimateResultImplCopyWith(_$EstimateResultImpl value,
          $Res Function(_$EstimateResultImpl) then) =
      __$$EstimateResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'price_cents') int? priceCents,
      @JsonKey(name: 'price_display') String? priceDisplay,
      int? vcpu,
      @JsonKey(name: 'ram_gb') double? ramGb,
      @JsonKey(name: 'ssd_gb') int? ssdGb,
      @JsonKey(name: 'included_ssd') int? includedSsd,
      String? region,
      @JsonKey(name: 'region_slug') String? regionSlug});
}

/// @nodoc
class __$$EstimateResultImplCopyWithImpl<$Res>
    extends _$EstimateResultCopyWithImpl<$Res, _$EstimateResultImpl>
    implements _$$EstimateResultImplCopyWith<$Res> {
  __$$EstimateResultImplCopyWithImpl(
      _$EstimateResultImpl _value, $Res Function(_$EstimateResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of EstimateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? priceCents = freezed,
    Object? priceDisplay = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? includedSsd = freezed,
    Object? region = freezed,
    Object? regionSlug = freezed,
  }) {
    return _then(_$EstimateResultImpl(
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      priceDisplay: freezed == priceDisplay
          ? _value.priceDisplay
          : priceDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      vcpu: freezed == vcpu
          ? _value.vcpu
          : vcpu // ignore: cast_nullable_to_non_nullable
              as int?,
      ramGb: freezed == ramGb
          ? _value.ramGb
          : ramGb // ignore: cast_nullable_to_non_nullable
              as double?,
      ssdGb: freezed == ssdGb
          ? _value.ssdGb
          : ssdGb // ignore: cast_nullable_to_non_nullable
              as int?,
      includedSsd: freezed == includedSsd
          ? _value.includedSsd
          : includedSsd // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      regionSlug: freezed == regionSlug
          ? _value.regionSlug
          : regionSlug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimateResultImpl implements _EstimateResult {
  const _$EstimateResultImpl(
      {@JsonKey(name: 'price_cents') this.priceCents,
      @JsonKey(name: 'price_display') this.priceDisplay,
      this.vcpu,
      @JsonKey(name: 'ram_gb') this.ramGb,
      @JsonKey(name: 'ssd_gb') this.ssdGb,
      @JsonKey(name: 'included_ssd') this.includedSsd,
      this.region,
      @JsonKey(name: 'region_slug') this.regionSlug});

  factory _$EstimateResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimateResultImplFromJson(json);

  @override
  @JsonKey(name: 'price_cents')
  final int? priceCents;
  @override
  @JsonKey(name: 'price_display')
  final String? priceDisplay;
  @override
  final int? vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  final double? ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  final int? ssdGb;
  @override
  @JsonKey(name: 'included_ssd')
  final int? includedSsd;
  @override
  final String? region;
  @override
  @JsonKey(name: 'region_slug')
  final String? regionSlug;

  @override
  String toString() {
    return 'EstimateResult(priceCents: $priceCents, priceDisplay: $priceDisplay, vcpu: $vcpu, ramGb: $ramGb, ssdGb: $ssdGb, includedSsd: $includedSsd, region: $region, regionSlug: $regionSlug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimateResultImpl &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.priceDisplay, priceDisplay) ||
                other.priceDisplay == priceDisplay) &&
            (identical(other.vcpu, vcpu) || other.vcpu == vcpu) &&
            (identical(other.ramGb, ramGb) || other.ramGb == ramGb) &&
            (identical(other.ssdGb, ssdGb) || other.ssdGb == ssdGb) &&
            (identical(other.includedSsd, includedSsd) ||
                other.includedSsd == includedSsd) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.regionSlug, regionSlug) ||
                other.regionSlug == regionSlug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, priceCents, priceDisplay, vcpu,
      ramGb, ssdGb, includedSsd, region, regionSlug);

  /// Create a copy of EstimateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimateResultImplCopyWith<_$EstimateResultImpl> get copyWith =>
      __$$EstimateResultImplCopyWithImpl<_$EstimateResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimateResultImplToJson(
      this,
    );
  }
}

abstract class _EstimateResult implements EstimateResult {
  const factory _EstimateResult(
          {@JsonKey(name: 'price_cents') final int? priceCents,
          @JsonKey(name: 'price_display') final String? priceDisplay,
          final int? vcpu,
          @JsonKey(name: 'ram_gb') final double? ramGb,
          @JsonKey(name: 'ssd_gb') final int? ssdGb,
          @JsonKey(name: 'included_ssd') final int? includedSsd,
          final String? region,
          @JsonKey(name: 'region_slug') final String? regionSlug}) =
      _$EstimateResultImpl;

  factory _EstimateResult.fromJson(Map<String, dynamic> json) =
      _$EstimateResultImpl.fromJson;

  @override
  @JsonKey(name: 'price_cents')
  int? get priceCents;
  @override
  @JsonKey(name: 'price_display')
  String? get priceDisplay;
  @override
  int? get vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  double? get ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb;
  @override
  @JsonKey(name: 'included_ssd')
  int? get includedSsd;
  @override
  String? get region;
  @override
  @JsonKey(name: 'region_slug')
  String? get regionSlug;

  /// Create a copy of EstimateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimateResultImplCopyWith<_$EstimateResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
