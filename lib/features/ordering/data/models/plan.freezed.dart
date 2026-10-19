// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return _Plan.fromJson(json);
}

/// @nodoc
mixin _$Plan {
  String get slug => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get vcpu => throw _privateConstructorUsedError;
  @JsonKey(name: 'ram_gb')
  double? get ramGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb => throw _privateConstructorUsedError;
  PlanSpecs? get specs => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int? get priceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_display')
  String? get priceDisplay => throw _privateConstructorUsedError;
  @JsonKey(name: 'autoscale_offered')
  bool? get autoscaleOffered => throw _privateConstructorUsedError;
  @JsonKey(name: 'autoscale_max_slug')
  String? get autoscaleMaxSlug => throw _privateConstructorUsedError;
  List<PlanRegion> get regions => throw _privateConstructorUsedError;

  /// Serializes this Plan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanCopyWith<Plan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanCopyWith<$Res> {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) then) =
      _$PlanCopyWithImpl<$Res, Plan>;
  @useResult
  $Res call(
      {String slug,
      String name,
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
      List<PlanRegion> regions});

  $PlanSpecsCopyWith<$Res>? get specs;
}

/// @nodoc
class _$PlanCopyWithImpl<$Res, $Val extends Plan>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
    Object? displayName = freezed,
    Object? description = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? specs = freezed,
    Object? priceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? priceDisplay = freezed,
    Object? autoscaleOffered = freezed,
    Object? autoscaleMaxSlug = freezed,
    Object? regions = null,
  }) {
    return _then(_value.copyWith(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      specs: freezed == specs
          ? _value.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as PlanSpecs?,
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      priceDisplay: freezed == priceDisplay
          ? _value.priceDisplay
          : priceDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      autoscaleOffered: freezed == autoscaleOffered
          ? _value.autoscaleOffered
          : autoscaleOffered // ignore: cast_nullable_to_non_nullable
              as bool?,
      autoscaleMaxSlug: freezed == autoscaleMaxSlug
          ? _value.autoscaleMaxSlug
          : autoscaleMaxSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      regions: null == regions
          ? _value.regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<PlanRegion>,
    ) as $Val);
  }

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlanSpecsCopyWith<$Res>? get specs {
    if (_value.specs == null) {
      return null;
    }

    return $PlanSpecsCopyWith<$Res>(_value.specs!, (value) {
      return _then(_value.copyWith(specs: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlanImplCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$$PlanImplCopyWith(
          _$PlanImpl value, $Res Function(_$PlanImpl) then) =
      __$$PlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String slug,
      String name,
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
      List<PlanRegion> regions});

  @override
  $PlanSpecsCopyWith<$Res>? get specs;
}

/// @nodoc
class __$$PlanImplCopyWithImpl<$Res>
    extends _$PlanCopyWithImpl<$Res, _$PlanImpl>
    implements _$$PlanImplCopyWith<$Res> {
  __$$PlanImplCopyWithImpl(_$PlanImpl _value, $Res Function(_$PlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
    Object? displayName = freezed,
    Object? description = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? specs = freezed,
    Object? priceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? priceDisplay = freezed,
    Object? autoscaleOffered = freezed,
    Object? autoscaleMaxSlug = freezed,
    Object? regions = null,
  }) {
    return _then(_$PlanImpl(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      specs: freezed == specs
          ? _value.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as PlanSpecs?,
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      priceDisplay: freezed == priceDisplay
          ? _value.priceDisplay
          : priceDisplay // ignore: cast_nullable_to_non_nullable
              as String?,
      autoscaleOffered: freezed == autoscaleOffered
          ? _value.autoscaleOffered
          : autoscaleOffered // ignore: cast_nullable_to_non_nullable
              as bool?,
      autoscaleMaxSlug: freezed == autoscaleMaxSlug
          ? _value.autoscaleMaxSlug
          : autoscaleMaxSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      regions: null == regions
          ? _value._regions
          : regions // ignore: cast_nullable_to_non_nullable
              as List<PlanRegion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanImpl implements _Plan {
  const _$PlanImpl(
      {required this.slug,
      required this.name,
      @JsonKey(name: 'display_name') this.displayName,
      this.description,
      this.vcpu,
      @JsonKey(name: 'ram_gb') this.ramGb,
      @JsonKey(name: 'ssd_gb') this.ssdGb,
      this.specs,
      @JsonKey(name: 'price_cents') this.priceCents,
      @JsonKey(name: 'eip_price_cents') this.eipPriceCents,
      @JsonKey(name: 'price_display') this.priceDisplay,
      @JsonKey(name: 'autoscale_offered') this.autoscaleOffered,
      @JsonKey(name: 'autoscale_max_slug') this.autoscaleMaxSlug,
      final List<PlanRegion> regions = const []})
      : _regions = regions;

  factory _$PlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanImplFromJson(json);

  @override
  final String slug;
  @override
  final String name;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  final String? description;
  @override
  final int? vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  final double? ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  final int? ssdGb;
  @override
  final PlanSpecs? specs;
  @override
  @JsonKey(name: 'price_cents')
  final int? priceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  final int? eipPriceCents;
  @override
  @JsonKey(name: 'price_display')
  final String? priceDisplay;
  @override
  @JsonKey(name: 'autoscale_offered')
  final bool? autoscaleOffered;
  @override
  @JsonKey(name: 'autoscale_max_slug')
  final String? autoscaleMaxSlug;
  final List<PlanRegion> _regions;
  @override
  @JsonKey()
  List<PlanRegion> get regions {
    if (_regions is EqualUnmodifiableListView) return _regions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regions);
  }

  @override
  String toString() {
    return 'Plan(slug: $slug, name: $name, displayName: $displayName, description: $description, vcpu: $vcpu, ramGb: $ramGb, ssdGb: $ssdGb, specs: $specs, priceCents: $priceCents, eipPriceCents: $eipPriceCents, priceDisplay: $priceDisplay, autoscaleOffered: $autoscaleOffered, autoscaleMaxSlug: $autoscaleMaxSlug, regions: $regions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.vcpu, vcpu) || other.vcpu == vcpu) &&
            (identical(other.ramGb, ramGb) || other.ramGb == ramGb) &&
            (identical(other.ssdGb, ssdGb) || other.ssdGb == ssdGb) &&
            (identical(other.specs, specs) || other.specs == specs) &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.eipPriceCents, eipPriceCents) ||
                other.eipPriceCents == eipPriceCents) &&
            (identical(other.priceDisplay, priceDisplay) ||
                other.priceDisplay == priceDisplay) &&
            (identical(other.autoscaleOffered, autoscaleOffered) ||
                other.autoscaleOffered == autoscaleOffered) &&
            (identical(other.autoscaleMaxSlug, autoscaleMaxSlug) ||
                other.autoscaleMaxSlug == autoscaleMaxSlug) &&
            const DeepCollectionEquality().equals(other._regions, _regions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      slug,
      name,
      displayName,
      description,
      vcpu,
      ramGb,
      ssdGb,
      specs,
      priceCents,
      eipPriceCents,
      priceDisplay,
      autoscaleOffered,
      autoscaleMaxSlug,
      const DeepCollectionEquality().hash(_regions));

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanImplCopyWith<_$PlanImpl> get copyWith =>
      __$$PlanImplCopyWithImpl<_$PlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanImplToJson(
      this,
    );
  }
}

abstract class _Plan implements Plan {
  const factory _Plan(
      {required final String slug,
      required final String name,
      @JsonKey(name: 'display_name') final String? displayName,
      final String? description,
      final int? vcpu,
      @JsonKey(name: 'ram_gb') final double? ramGb,
      @JsonKey(name: 'ssd_gb') final int? ssdGb,
      final PlanSpecs? specs,
      @JsonKey(name: 'price_cents') final int? priceCents,
      @JsonKey(name: 'eip_price_cents') final int? eipPriceCents,
      @JsonKey(name: 'price_display') final String? priceDisplay,
      @JsonKey(name: 'autoscale_offered') final bool? autoscaleOffered,
      @JsonKey(name: 'autoscale_max_slug') final String? autoscaleMaxSlug,
      final List<PlanRegion> regions}) = _$PlanImpl;

  factory _Plan.fromJson(Map<String, dynamic> json) = _$PlanImpl.fromJson;

  @override
  String get slug;
  @override
  String get name;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  String? get description;
  @override
  int? get vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  double? get ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb;
  @override
  PlanSpecs? get specs;
  @override
  @JsonKey(name: 'price_cents')
  int? get priceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents;
  @override
  @JsonKey(name: 'price_display')
  String? get priceDisplay;
  @override
  @JsonKey(name: 'autoscale_offered')
  bool? get autoscaleOffered;
  @override
  @JsonKey(name: 'autoscale_max_slug')
  String? get autoscaleMaxSlug;
  @override
  List<PlanRegion> get regions;

  /// Create a copy of Plan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanImplCopyWith<_$PlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlanSpecs _$PlanSpecsFromJson(Map<String, dynamic> json) {
  return _PlanSpecs.fromJson(json);
}

/// @nodoc
mixin _$PlanSpecs {
  @JsonKey(name: 'vcpu_label')
  String? get vcpuLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'ram_label')
  String? get ramLabel => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssd_label')
  String? get ssdLabel => throw _privateConstructorUsedError;
  String? get transfer => throw _privateConstructorUsedError;

  /// Serializes this PlanSpecs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanSpecs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanSpecsCopyWith<PlanSpecs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanSpecsCopyWith<$Res> {
  factory $PlanSpecsCopyWith(PlanSpecs value, $Res Function(PlanSpecs) then) =
      _$PlanSpecsCopyWithImpl<$Res, PlanSpecs>;
  @useResult
  $Res call(
      {@JsonKey(name: 'vcpu_label') String? vcpuLabel,
      @JsonKey(name: 'ram_label') String? ramLabel,
      @JsonKey(name: 'ssd_label') String? ssdLabel,
      String? transfer});
}

/// @nodoc
class _$PlanSpecsCopyWithImpl<$Res, $Val extends PlanSpecs>
    implements $PlanSpecsCopyWith<$Res> {
  _$PlanSpecsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanSpecs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vcpuLabel = freezed,
    Object? ramLabel = freezed,
    Object? ssdLabel = freezed,
    Object? transfer = freezed,
  }) {
    return _then(_value.copyWith(
      vcpuLabel: freezed == vcpuLabel
          ? _value.vcpuLabel
          : vcpuLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      ramLabel: freezed == ramLabel
          ? _value.ramLabel
          : ramLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      ssdLabel: freezed == ssdLabel
          ? _value.ssdLabel
          : ssdLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      transfer: freezed == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanSpecsImplCopyWith<$Res>
    implements $PlanSpecsCopyWith<$Res> {
  factory _$$PlanSpecsImplCopyWith(
          _$PlanSpecsImpl value, $Res Function(_$PlanSpecsImpl) then) =
      __$$PlanSpecsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'vcpu_label') String? vcpuLabel,
      @JsonKey(name: 'ram_label') String? ramLabel,
      @JsonKey(name: 'ssd_label') String? ssdLabel,
      String? transfer});
}

/// @nodoc
class __$$PlanSpecsImplCopyWithImpl<$Res>
    extends _$PlanSpecsCopyWithImpl<$Res, _$PlanSpecsImpl>
    implements _$$PlanSpecsImplCopyWith<$Res> {
  __$$PlanSpecsImplCopyWithImpl(
      _$PlanSpecsImpl _value, $Res Function(_$PlanSpecsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanSpecs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vcpuLabel = freezed,
    Object? ramLabel = freezed,
    Object? ssdLabel = freezed,
    Object? transfer = freezed,
  }) {
    return _then(_$PlanSpecsImpl(
      vcpuLabel: freezed == vcpuLabel
          ? _value.vcpuLabel
          : vcpuLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      ramLabel: freezed == ramLabel
          ? _value.ramLabel
          : ramLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      ssdLabel: freezed == ssdLabel
          ? _value.ssdLabel
          : ssdLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      transfer: freezed == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanSpecsImpl implements _PlanSpecs {
  const _$PlanSpecsImpl(
      {@JsonKey(name: 'vcpu_label') this.vcpuLabel,
      @JsonKey(name: 'ram_label') this.ramLabel,
      @JsonKey(name: 'ssd_label') this.ssdLabel,
      this.transfer});

  factory _$PlanSpecsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanSpecsImplFromJson(json);

  @override
  @JsonKey(name: 'vcpu_label')
  final String? vcpuLabel;
  @override
  @JsonKey(name: 'ram_label')
  final String? ramLabel;
  @override
  @JsonKey(name: 'ssd_label')
  final String? ssdLabel;
  @override
  final String? transfer;

  @override
  String toString() {
    return 'PlanSpecs(vcpuLabel: $vcpuLabel, ramLabel: $ramLabel, ssdLabel: $ssdLabel, transfer: $transfer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanSpecsImpl &&
            (identical(other.vcpuLabel, vcpuLabel) ||
                other.vcpuLabel == vcpuLabel) &&
            (identical(other.ramLabel, ramLabel) ||
                other.ramLabel == ramLabel) &&
            (identical(other.ssdLabel, ssdLabel) ||
                other.ssdLabel == ssdLabel) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, vcpuLabel, ramLabel, ssdLabel, transfer);

  /// Create a copy of PlanSpecs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanSpecsImplCopyWith<_$PlanSpecsImpl> get copyWith =>
      __$$PlanSpecsImplCopyWithImpl<_$PlanSpecsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanSpecsImplToJson(
      this,
    );
  }
}

abstract class _PlanSpecs implements PlanSpecs {
  const factory _PlanSpecs(
      {@JsonKey(name: 'vcpu_label') final String? vcpuLabel,
      @JsonKey(name: 'ram_label') final String? ramLabel,
      @JsonKey(name: 'ssd_label') final String? ssdLabel,
      final String? transfer}) = _$PlanSpecsImpl;

  factory _PlanSpecs.fromJson(Map<String, dynamic> json) =
      _$PlanSpecsImpl.fromJson;

  @override
  @JsonKey(name: 'vcpu_label')
  String? get vcpuLabel;
  @override
  @JsonKey(name: 'ram_label')
  String? get ramLabel;
  @override
  @JsonKey(name: 'ssd_label')
  String? get ssdLabel;
  @override
  String? get transfer;

  /// Create a copy of PlanSpecs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanSpecsImplCopyWith<_$PlanSpecsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlanRegion _$PlanRegionFromJson(Map<String, dynamic> json) {
  return _PlanRegion.fromJson(json);
}

/// @nodoc
mixin _$PlanRegion {
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;

  /// Serializes this PlanRegion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlanRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanRegionCopyWith<PlanRegion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanRegionCopyWith<$Res> {
  factory $PlanRegionCopyWith(
          PlanRegion value, $Res Function(PlanRegion) then) =
      _$PlanRegionCopyWithImpl<$Res, PlanRegion>;
  @useResult
  $Res call({String slug, @JsonKey(name: 'display_name') String? displayName});
}

/// @nodoc
class _$PlanRegionCopyWithImpl<$Res, $Val extends PlanRegion>
    implements $PlanRegionCopyWith<$Res> {
  _$PlanRegionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanRegionImplCopyWith<$Res>
    implements $PlanRegionCopyWith<$Res> {
  factory _$$PlanRegionImplCopyWith(
          _$PlanRegionImpl value, $Res Function(_$PlanRegionImpl) then) =
      __$$PlanRegionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String slug, @JsonKey(name: 'display_name') String? displayName});
}

/// @nodoc
class __$$PlanRegionImplCopyWithImpl<$Res>
    extends _$PlanRegionCopyWithImpl<$Res, _$PlanRegionImpl>
    implements _$$PlanRegionImplCopyWith<$Res> {
  __$$PlanRegionImplCopyWithImpl(
      _$PlanRegionImpl _value, $Res Function(_$PlanRegionImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanRegion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? displayName = freezed,
  }) {
    return _then(_$PlanRegionImpl(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlanRegionImpl implements _PlanRegion {
  const _$PlanRegionImpl(
      {required this.slug, @JsonKey(name: 'display_name') this.displayName});

  factory _$PlanRegionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlanRegionImplFromJson(json);

  @override
  final String slug;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;

  @override
  String toString() {
    return 'PlanRegion(slug: $slug, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanRegionImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug, displayName);

  /// Create a copy of PlanRegion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanRegionImplCopyWith<_$PlanRegionImpl> get copyWith =>
      __$$PlanRegionImplCopyWithImpl<_$PlanRegionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlanRegionImplToJson(
      this,
    );
  }
}

abstract class _PlanRegion implements PlanRegion {
  const factory _PlanRegion(
          {required final String slug,
          @JsonKey(name: 'display_name') final String? displayName}) =
      _$PlanRegionImpl;

  factory _PlanRegion.fromJson(Map<String, dynamic> json) =
      _$PlanRegionImpl.fromJson;

  @override
  String get slug;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;

  /// Create a copy of PlanRegion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanRegionImplCopyWith<_$PlanRegionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlansResponse _$PlansResponseFromJson(Map<String, dynamic> json) {
  return _PlansResponse.fromJson(json);
}

/// @nodoc
mixin _$PlansResponse {
  List<Plan> get items => throw _privateConstructorUsedError;
  @JsonKey(name: 'usd_pkr_rate')
  num? get usdPkrRate => throw _privateConstructorUsedError;
  int? get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int? get perPage => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool? get hasMore => throw _privateConstructorUsedError;

  /// Serializes this PlansResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlansResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlansResponseCopyWith<PlansResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlansResponseCopyWith<$Res> {
  factory $PlansResponseCopyWith(
          PlansResponse value, $Res Function(PlansResponse) then) =
      _$PlansResponseCopyWithImpl<$Res, PlansResponse>;
  @useResult
  $Res call(
      {List<Plan> items,
      @JsonKey(name: 'usd_pkr_rate') num? usdPkrRate,
      int? page,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      @JsonKey(name: 'has_more') bool? hasMore});
}

/// @nodoc
class _$PlansResponseCopyWithImpl<$Res, $Val extends PlansResponse>
    implements $PlansResponseCopyWith<$Res> {
  _$PlansResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlansResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? usdPkrRate = freezed,
    Object? page = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? hasMore = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Plan>,
      usdPkrRate: freezed == usdPkrRate
          ? _value.usdPkrRate
          : usdPkrRate // ignore: cast_nullable_to_non_nullable
              as num?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlansResponseImplCopyWith<$Res>
    implements $PlansResponseCopyWith<$Res> {
  factory _$$PlansResponseImplCopyWith(
          _$PlansResponseImpl value, $Res Function(_$PlansResponseImpl) then) =
      __$$PlansResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Plan> items,
      @JsonKey(name: 'usd_pkr_rate') num? usdPkrRate,
      int? page,
      @JsonKey(name: 'per_page') int? perPage,
      int? total,
      @JsonKey(name: 'has_more') bool? hasMore});
}

/// @nodoc
class __$$PlansResponseImplCopyWithImpl<$Res>
    extends _$PlansResponseCopyWithImpl<$Res, _$PlansResponseImpl>
    implements _$$PlansResponseImplCopyWith<$Res> {
  __$$PlansResponseImplCopyWithImpl(
      _$PlansResponseImpl _value, $Res Function(_$PlansResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlansResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? usdPkrRate = freezed,
    Object? page = freezed,
    Object? perPage = freezed,
    Object? total = freezed,
    Object? hasMore = freezed,
  }) {
    return _then(_$PlansResponseImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Plan>,
      usdPkrRate: freezed == usdPkrRate
          ? _value.usdPkrRate
          : usdPkrRate // ignore: cast_nullable_to_non_nullable
              as num?,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      perPage: freezed == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMore: freezed == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlansResponseImpl implements _PlansResponse {
  const _$PlansResponseImpl(
      {final List<Plan> items = const [],
      @JsonKey(name: 'usd_pkr_rate') this.usdPkrRate,
      this.page,
      @JsonKey(name: 'per_page') this.perPage,
      this.total,
      @JsonKey(name: 'has_more') this.hasMore})
      : _items = items;

  factory _$PlansResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlansResponseImplFromJson(json);

  final List<Plan> _items;
  @override
  @JsonKey()
  List<Plan> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey(name: 'usd_pkr_rate')
  final num? usdPkrRate;
  @override
  final int? page;
  @override
  @JsonKey(name: 'per_page')
  final int? perPage;
  @override
  final int? total;
  @override
  @JsonKey(name: 'has_more')
  final bool? hasMore;

  @override
  String toString() {
    return 'PlansResponse(items: $items, usdPkrRate: $usdPkrRate, page: $page, perPage: $perPage, total: $total, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlansResponseImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.usdPkrRate, usdPkrRate) ||
                other.usdPkrRate == usdPkrRate) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      usdPkrRate,
      page,
      perPage,
      total,
      hasMore);

  /// Create a copy of PlansResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlansResponseImplCopyWith<_$PlansResponseImpl> get copyWith =>
      __$$PlansResponseImplCopyWithImpl<_$PlansResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlansResponseImplToJson(
      this,
    );
  }
}

abstract class _PlansResponse implements PlansResponse {
  const factory _PlansResponse(
      {final List<Plan> items,
      @JsonKey(name: 'usd_pkr_rate') final num? usdPkrRate,
      final int? page,
      @JsonKey(name: 'per_page') final int? perPage,
      final int? total,
      @JsonKey(name: 'has_more') final bool? hasMore}) = _$PlansResponseImpl;

  factory _PlansResponse.fromJson(Map<String, dynamic> json) =
      _$PlansResponseImpl.fromJson;

  @override
  List<Plan> get items;
  @override
  @JsonKey(name: 'usd_pkr_rate')
  num? get usdPkrRate;
  @override
  int? get page;
  @override
  @JsonKey(name: 'per_page')
  int? get perPage;
  @override
  int? get total;
  @override
  @JsonKey(name: 'has_more')
  bool? get hasMore;

  /// Create a copy of PlansResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlansResponseImplCopyWith<_$PlansResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
