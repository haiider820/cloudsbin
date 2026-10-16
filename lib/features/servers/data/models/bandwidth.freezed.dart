// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bandwidth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Bandwidth _$BandwidthFromJson(Map<String, dynamic> json) {
  return _Bandwidth.fromJson(json);
}

/// @nodoc
mixin _$Bandwidth {
  @JsonKey(name: 'in_gb')
  double? get inGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'out_gb')
  double? get outGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_gb')
  double? get totalGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'reset_day')
  int? get resetDay => throw _privateConstructorUsedError;

  /// Serializes this Bandwidth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Bandwidth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BandwidthCopyWith<Bandwidth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BandwidthCopyWith<$Res> {
  factory $BandwidthCopyWith(Bandwidth value, $Res Function(Bandwidth) then) =
      _$BandwidthCopyWithImpl<$Res, Bandwidth>;
  @useResult
  $Res call(
      {@JsonKey(name: 'in_gb') double? inGb,
      @JsonKey(name: 'out_gb') double? outGb,
      @JsonKey(name: 'total_gb') double? totalGb,
      @JsonKey(name: 'reset_day') int? resetDay});
}

/// @nodoc
class _$BandwidthCopyWithImpl<$Res, $Val extends Bandwidth>
    implements $BandwidthCopyWith<$Res> {
  _$BandwidthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Bandwidth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inGb = freezed,
    Object? outGb = freezed,
    Object? totalGb = freezed,
    Object? resetDay = freezed,
  }) {
    return _then(_value.copyWith(
      inGb: freezed == inGb
          ? _value.inGb
          : inGb // ignore: cast_nullable_to_non_nullable
              as double?,
      outGb: freezed == outGb
          ? _value.outGb
          : outGb // ignore: cast_nullable_to_non_nullable
              as double?,
      totalGb: freezed == totalGb
          ? _value.totalGb
          : totalGb // ignore: cast_nullable_to_non_nullable
              as double?,
      resetDay: freezed == resetDay
          ? _value.resetDay
          : resetDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BandwidthImplCopyWith<$Res>
    implements $BandwidthCopyWith<$Res> {
  factory _$$BandwidthImplCopyWith(
          _$BandwidthImpl value, $Res Function(_$BandwidthImpl) then) =
      __$$BandwidthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'in_gb') double? inGb,
      @JsonKey(name: 'out_gb') double? outGb,
      @JsonKey(name: 'total_gb') double? totalGb,
      @JsonKey(name: 'reset_day') int? resetDay});
}

/// @nodoc
class __$$BandwidthImplCopyWithImpl<$Res>
    extends _$BandwidthCopyWithImpl<$Res, _$BandwidthImpl>
    implements _$$BandwidthImplCopyWith<$Res> {
  __$$BandwidthImplCopyWithImpl(
      _$BandwidthImpl _value, $Res Function(_$BandwidthImpl) _then)
      : super(_value, _then);

  /// Create a copy of Bandwidth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inGb = freezed,
    Object? outGb = freezed,
    Object? totalGb = freezed,
    Object? resetDay = freezed,
  }) {
    return _then(_$BandwidthImpl(
      inGb: freezed == inGb
          ? _value.inGb
          : inGb // ignore: cast_nullable_to_non_nullable
              as double?,
      outGb: freezed == outGb
          ? _value.outGb
          : outGb // ignore: cast_nullable_to_non_nullable
              as double?,
      totalGb: freezed == totalGb
          ? _value.totalGb
          : totalGb // ignore: cast_nullable_to_non_nullable
              as double?,
      resetDay: freezed == resetDay
          ? _value.resetDay
          : resetDay // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BandwidthImpl implements _Bandwidth {
  const _$BandwidthImpl(
      {@JsonKey(name: 'in_gb') this.inGb,
      @JsonKey(name: 'out_gb') this.outGb,
      @JsonKey(name: 'total_gb') this.totalGb,
      @JsonKey(name: 'reset_day') this.resetDay});

  factory _$BandwidthImpl.fromJson(Map<String, dynamic> json) =>
      _$$BandwidthImplFromJson(json);

  @override
  @JsonKey(name: 'in_gb')
  final double? inGb;
  @override
  @JsonKey(name: 'out_gb')
  final double? outGb;
  @override
  @JsonKey(name: 'total_gb')
  final double? totalGb;
  @override
  @JsonKey(name: 'reset_day')
  final int? resetDay;

  @override
  String toString() {
    return 'Bandwidth(inGb: $inGb, outGb: $outGb, totalGb: $totalGb, resetDay: $resetDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BandwidthImpl &&
            (identical(other.inGb, inGb) || other.inGb == inGb) &&
            (identical(other.outGb, outGb) || other.outGb == outGb) &&
            (identical(other.totalGb, totalGb) || other.totalGb == totalGb) &&
            (identical(other.resetDay, resetDay) ||
                other.resetDay == resetDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, inGb, outGb, totalGb, resetDay);

  /// Create a copy of Bandwidth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BandwidthImplCopyWith<_$BandwidthImpl> get copyWith =>
      __$$BandwidthImplCopyWithImpl<_$BandwidthImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BandwidthImplToJson(
      this,
    );
  }
}

abstract class _Bandwidth implements Bandwidth {
  const factory _Bandwidth(
      {@JsonKey(name: 'in_gb') final double? inGb,
      @JsonKey(name: 'out_gb') final double? outGb,
      @JsonKey(name: 'total_gb') final double? totalGb,
      @JsonKey(name: 'reset_day') final int? resetDay}) = _$BandwidthImpl;

  factory _Bandwidth.fromJson(Map<String, dynamic> json) =
      _$BandwidthImpl.fromJson;

  @override
  @JsonKey(name: 'in_gb')
  double? get inGb;
  @override
  @JsonKey(name: 'out_gb')
  double? get outGb;
  @override
  @JsonKey(name: 'total_gb')
  double? get totalGb;
  @override
  @JsonKey(name: 'reset_day')
  int? get resetDay;

  /// Create a copy of Bandwidth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BandwidthImplCopyWith<_$BandwidthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
