// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerUsage _$ServerUsageFromJson(Map<String, dynamic> json) {
  return _ServerUsage.fromJson(json);
}

/// @nodoc
mixin _$ServerUsage {
  @JsonKey(name: 'bandwidth_in_bytes')
  int? get bandwidthInBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'bandwidth_out_bytes')
  int? get bandwidthOutBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_bytes')
  int? get totalBytes => throw _privateConstructorUsedError;
  @JsonKey(name: 'limit_bytes')
  int? get limitBytes => throw _privateConstructorUsedError;
  bool? get cached => throw _privateConstructorUsedError;
  @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get fetchedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_id')
  int? get serverId => throw _privateConstructorUsedError;

  /// Serializes this ServerUsage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerUsageCopyWith<ServerUsage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerUsageCopyWith<$Res> {
  factory $ServerUsageCopyWith(
          ServerUsage value, $Res Function(ServerUsage) then) =
      _$ServerUsageCopyWithImpl<$Res, ServerUsage>;
  @useResult
  $Res call(
      {@JsonKey(name: 'bandwidth_in_bytes') int? bandwidthInBytes,
      @JsonKey(name: 'bandwidth_out_bytes') int? bandwidthOutBytes,
      @JsonKey(name: 'total_bytes') int? totalBytes,
      @JsonKey(name: 'limit_bytes') int? limitBytes,
      bool? cached,
      @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? fetchedAt,
      @JsonKey(name: 'server_id') int? serverId});
}

/// @nodoc
class _$ServerUsageCopyWithImpl<$Res, $Val extends ServerUsage>
    implements $ServerUsageCopyWith<$Res> {
  _$ServerUsageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bandwidthInBytes = freezed,
    Object? bandwidthOutBytes = freezed,
    Object? totalBytes = freezed,
    Object? limitBytes = freezed,
    Object? cached = freezed,
    Object? fetchedAt = freezed,
    Object? serverId = freezed,
  }) {
    return _then(_value.copyWith(
      bandwidthInBytes: freezed == bandwidthInBytes
          ? _value.bandwidthInBytes
          : bandwidthInBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      bandwidthOutBytes: freezed == bandwidthOutBytes
          ? _value.bandwidthOutBytes
          : bandwidthOutBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      limitBytes: freezed == limitBytes
          ? _value.limitBytes
          : limitBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      cached: freezed == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool?,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerUsageImplCopyWith<$Res>
    implements $ServerUsageCopyWith<$Res> {
  factory _$$ServerUsageImplCopyWith(
          _$ServerUsageImpl value, $Res Function(_$ServerUsageImpl) then) =
      __$$ServerUsageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'bandwidth_in_bytes') int? bandwidthInBytes,
      @JsonKey(name: 'bandwidth_out_bytes') int? bandwidthOutBytes,
      @JsonKey(name: 'total_bytes') int? totalBytes,
      @JsonKey(name: 'limit_bytes') int? limitBytes,
      bool? cached,
      @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? fetchedAt,
      @JsonKey(name: 'server_id') int? serverId});
}

/// @nodoc
class __$$ServerUsageImplCopyWithImpl<$Res>
    extends _$ServerUsageCopyWithImpl<$Res, _$ServerUsageImpl>
    implements _$$ServerUsageImplCopyWith<$Res> {
  __$$ServerUsageImplCopyWithImpl(
      _$ServerUsageImpl _value, $Res Function(_$ServerUsageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerUsage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bandwidthInBytes = freezed,
    Object? bandwidthOutBytes = freezed,
    Object? totalBytes = freezed,
    Object? limitBytes = freezed,
    Object? cached = freezed,
    Object? fetchedAt = freezed,
    Object? serverId = freezed,
  }) {
    return _then(_$ServerUsageImpl(
      bandwidthInBytes: freezed == bandwidthInBytes
          ? _value.bandwidthInBytes
          : bandwidthInBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      bandwidthOutBytes: freezed == bandwidthOutBytes
          ? _value.bandwidthOutBytes
          : bandwidthOutBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      limitBytes: freezed == limitBytes
          ? _value.limitBytes
          : limitBytes // ignore: cast_nullable_to_non_nullable
              as int?,
      cached: freezed == cached
          ? _value.cached
          : cached // ignore: cast_nullable_to_non_nullable
              as bool?,
      fetchedAt: freezed == fetchedAt
          ? _value.fetchedAt
          : fetchedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerUsageImpl implements _ServerUsage {
  const _$ServerUsageImpl(
      {@JsonKey(name: 'bandwidth_in_bytes') this.bandwidthInBytes,
      @JsonKey(name: 'bandwidth_out_bytes') this.bandwidthOutBytes,
      @JsonKey(name: 'total_bytes') this.totalBytes,
      @JsonKey(name: 'limit_bytes') this.limitBytes,
      this.cached,
      @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
      this.fetchedAt,
      @JsonKey(name: 'server_id') this.serverId});

  factory _$ServerUsageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerUsageImplFromJson(json);

  @override
  @JsonKey(name: 'bandwidth_in_bytes')
  final int? bandwidthInBytes;
  @override
  @JsonKey(name: 'bandwidth_out_bytes')
  final int? bandwidthOutBytes;
  @override
  @JsonKey(name: 'total_bytes')
  final int? totalBytes;
  @override
  @JsonKey(name: 'limit_bytes')
  final int? limitBytes;
  @override
  final bool? cached;
  @override
  @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? fetchedAt;
  @override
  @JsonKey(name: 'server_id')
  final int? serverId;

  @override
  String toString() {
    return 'ServerUsage(bandwidthInBytes: $bandwidthInBytes, bandwidthOutBytes: $bandwidthOutBytes, totalBytes: $totalBytes, limitBytes: $limitBytes, cached: $cached, fetchedAt: $fetchedAt, serverId: $serverId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerUsageImpl &&
            (identical(other.bandwidthInBytes, bandwidthInBytes) ||
                other.bandwidthInBytes == bandwidthInBytes) &&
            (identical(other.bandwidthOutBytes, bandwidthOutBytes) ||
                other.bandwidthOutBytes == bandwidthOutBytes) &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes) &&
            (identical(other.limitBytes, limitBytes) ||
                other.limitBytes == limitBytes) &&
            (identical(other.cached, cached) || other.cached == cached) &&
            (identical(other.fetchedAt, fetchedAt) ||
                other.fetchedAt == fetchedAt) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bandwidthInBytes,
      bandwidthOutBytes, totalBytes, limitBytes, cached, fetchedAt, serverId);

  /// Create a copy of ServerUsage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerUsageImplCopyWith<_$ServerUsageImpl> get copyWith =>
      __$$ServerUsageImplCopyWithImpl<_$ServerUsageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerUsageImplToJson(
      this,
    );
  }
}

abstract class _ServerUsage implements ServerUsage {
  const factory _ServerUsage(
      {@JsonKey(name: 'bandwidth_in_bytes') final int? bandwidthInBytes,
      @JsonKey(name: 'bandwidth_out_bytes') final int? bandwidthOutBytes,
      @JsonKey(name: 'total_bytes') final int? totalBytes,
      @JsonKey(name: 'limit_bytes') final int? limitBytes,
      final bool? cached,
      @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? fetchedAt,
      @JsonKey(name: 'server_id') final int? serverId}) = _$ServerUsageImpl;

  factory _ServerUsage.fromJson(Map<String, dynamic> json) =
      _$ServerUsageImpl.fromJson;

  @override
  @JsonKey(name: 'bandwidth_in_bytes')
  int? get bandwidthInBytes;
  @override
  @JsonKey(name: 'bandwidth_out_bytes')
  int? get bandwidthOutBytes;
  @override
  @JsonKey(name: 'total_bytes')
  int? get totalBytes;
  @override
  @JsonKey(name: 'limit_bytes')
  int? get limitBytes;
  @override
  bool? get cached;
  @override
  @JsonKey(name: 'fetched_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get fetchedAt;
  @override
  @JsonKey(name: 'server_id')
  int? get serverId;

  /// Create a copy of ServerUsage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerUsageImplCopyWith<_$ServerUsageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
