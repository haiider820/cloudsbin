// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerDetail _$ServerDetailFromJson(Map<String, dynamic> json) {
  return _ServerDetail.fromJson(json);
}

/// @nodoc
mixin _$ServerDetail {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_address')
  String? get ipAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get os => throw _privateConstructorUsedError;
  int? get vcpu => throw _privateConstructorUsedError;
  @JsonKey(name: 'ram_gb')
  double? get ramGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get activatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get destroyedAt => throw _privateConstructorUsedError;
  int? get progress => throw _privateConstructorUsedError;
  String? get stage => throw _privateConstructorUsedError;
  @JsonKey(name: 'eta_seconds')
  int? get etaSeconds => throw _privateConstructorUsedError;
  Bandwidth? get bandwidth => throw _privateConstructorUsedError;

  /// Serializes this ServerDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerDetailCopyWith<ServerDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerDetailCopyWith<$Res> {
  factory $ServerDetailCopyWith(
          ServerDetail value, $Res Function(ServerDetail) then) =
      _$ServerDetailCopyWithImpl<$Res, ServerDetail>;
  @useResult
  $Res call(
      {int id,
      String? name,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'access_port') int? accessPort,
      @JsonKey(name: 'plan_name') String? planName,
      String? region,
      String? os,
      int? vcpu,
      @JsonKey(name: 'ram_gb') double? ramGb,
      @JsonKey(name: 'ssd_gb') int? ssdGb,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? activatedAt,
      @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? destroyedAt,
      int? progress,
      String? stage,
      @JsonKey(name: 'eta_seconds') int? etaSeconds,
      Bandwidth? bandwidth});

  $BandwidthCopyWith<$Res>? get bandwidth;
}

/// @nodoc
class _$ServerDetailCopyWithImpl<$Res, $Val extends ServerDetail>
    implements $ServerDetailCopyWith<$Res> {
  _$ServerDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? status = null,
    Object? ipAddress = freezed,
    Object? accessPort = freezed,
    Object? planName = freezed,
    Object? region = freezed,
    Object? os = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? createdAt = freezed,
    Object? activatedAt = freezed,
    Object? destroyedAt = freezed,
    Object? progress = freezed,
    Object? stage = freezed,
    Object? etaSeconds = freezed,
    Object? bandwidth = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      os: freezed == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activatedAt: freezed == activatedAt
          ? _value.activatedAt
          : activatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destroyedAt: freezed == destroyedAt
          ? _value.destroyedAt
          : destroyedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      etaSeconds: freezed == etaSeconds
          ? _value.etaSeconds
          : etaSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      bandwidth: freezed == bandwidth
          ? _value.bandwidth
          : bandwidth // ignore: cast_nullable_to_non_nullable
              as Bandwidth?,
    ) as $Val);
  }

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BandwidthCopyWith<$Res>? get bandwidth {
    if (_value.bandwidth == null) {
      return null;
    }

    return $BandwidthCopyWith<$Res>(_value.bandwidth!, (value) {
      return _then(_value.copyWith(bandwidth: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ServerDetailImplCopyWith<$Res>
    implements $ServerDetailCopyWith<$Res> {
  factory _$$ServerDetailImplCopyWith(
          _$ServerDetailImpl value, $Res Function(_$ServerDetailImpl) then) =
      __$$ServerDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'access_port') int? accessPort,
      @JsonKey(name: 'plan_name') String? planName,
      String? region,
      String? os,
      int? vcpu,
      @JsonKey(name: 'ram_gb') double? ramGb,
      @JsonKey(name: 'ssd_gb') int? ssdGb,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? activatedAt,
      @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? destroyedAt,
      int? progress,
      String? stage,
      @JsonKey(name: 'eta_seconds') int? etaSeconds,
      Bandwidth? bandwidth});

  @override
  $BandwidthCopyWith<$Res>? get bandwidth;
}

/// @nodoc
class __$$ServerDetailImplCopyWithImpl<$Res>
    extends _$ServerDetailCopyWithImpl<$Res, _$ServerDetailImpl>
    implements _$$ServerDetailImplCopyWith<$Res> {
  __$$ServerDetailImplCopyWithImpl(
      _$ServerDetailImpl _value, $Res Function(_$ServerDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? status = null,
    Object? ipAddress = freezed,
    Object? accessPort = freezed,
    Object? planName = freezed,
    Object? region = freezed,
    Object? os = freezed,
    Object? vcpu = freezed,
    Object? ramGb = freezed,
    Object? ssdGb = freezed,
    Object? createdAt = freezed,
    Object? activatedAt = freezed,
    Object? destroyedAt = freezed,
    Object? progress = freezed,
    Object? stage = freezed,
    Object? etaSeconds = freezed,
    Object? bandwidth = freezed,
  }) {
    return _then(_$ServerDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      os: freezed == os
          ? _value.os
          : os // ignore: cast_nullable_to_non_nullable
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      activatedAt: freezed == activatedAt
          ? _value.activatedAt
          : activatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      destroyedAt: freezed == destroyedAt
          ? _value.destroyedAt
          : destroyedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      stage: freezed == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as String?,
      etaSeconds: freezed == etaSeconds
          ? _value.etaSeconds
          : etaSeconds // ignore: cast_nullable_to_non_nullable
              as int?,
      bandwidth: freezed == bandwidth
          ? _value.bandwidth
          : bandwidth // ignore: cast_nullable_to_non_nullable
              as Bandwidth?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerDetailImpl implements _ServerDetail {
  const _$ServerDetailImpl(
      {required this.id,
      this.name,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      required this.status,
      @JsonKey(name: 'ip_address') this.ipAddress,
      @JsonKey(name: 'access_port') this.accessPort,
      @JsonKey(name: 'plan_name') this.planName,
      this.region,
      this.os,
      this.vcpu,
      @JsonKey(name: 'ram_gb') this.ramGb,
      @JsonKey(name: 'ssd_gb') this.ssdGb,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt,
      @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
      this.activatedAt,
      @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
      this.destroyedAt,
      this.progress,
      this.stage,
      @JsonKey(name: 'eta_seconds') this.etaSeconds,
      this.bandwidth});

  factory _$ServerDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  final ServerStatus status;
  @override
  @JsonKey(name: 'ip_address')
  final String? ipAddress;
  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  final String? region;
  @override
  final String? os;
  @override
  final int? vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  final double? ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  final int? ssdGb;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? activatedAt;
  @override
  @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? destroyedAt;
  @override
  final int? progress;
  @override
  final String? stage;
  @override
  @JsonKey(name: 'eta_seconds')
  final int? etaSeconds;
  @override
  final Bandwidth? bandwidth;

  @override
  String toString() {
    return 'ServerDetail(id: $id, name: $name, status: $status, ipAddress: $ipAddress, accessPort: $accessPort, planName: $planName, region: $region, os: $os, vcpu: $vcpu, ramGb: $ramGb, ssdGb: $ssdGb, createdAt: $createdAt, activatedAt: $activatedAt, destroyedAt: $destroyedAt, progress: $progress, stage: $stage, etaSeconds: $etaSeconds, bandwidth: $bandwidth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.os, os) || other.os == os) &&
            (identical(other.vcpu, vcpu) || other.vcpu == vcpu) &&
            (identical(other.ramGb, ramGb) || other.ramGb == ramGb) &&
            (identical(other.ssdGb, ssdGb) || other.ssdGb == ssdGb) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.activatedAt, activatedAt) ||
                other.activatedAt == activatedAt) &&
            (identical(other.destroyedAt, destroyedAt) ||
                other.destroyedAt == destroyedAt) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.etaSeconds, etaSeconds) ||
                other.etaSeconds == etaSeconds) &&
            (identical(other.bandwidth, bandwidth) ||
                other.bandwidth == bandwidth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      status,
      ipAddress,
      accessPort,
      planName,
      region,
      os,
      vcpu,
      ramGb,
      ssdGb,
      createdAt,
      activatedAt,
      destroyedAt,
      progress,
      stage,
      etaSeconds,
      bandwidth);

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerDetailImplCopyWith<_$ServerDetailImpl> get copyWith =>
      __$$ServerDetailImplCopyWithImpl<_$ServerDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerDetailImplToJson(
      this,
    );
  }
}

abstract class _ServerDetail implements ServerDetail {
  const factory _ServerDetail(
      {required final int id,
      final String? name,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      required final ServerStatus status,
      @JsonKey(name: 'ip_address') final String? ipAddress,
      @JsonKey(name: 'access_port') final int? accessPort,
      @JsonKey(name: 'plan_name') final String? planName,
      final String? region,
      final String? os,
      final int? vcpu,
      @JsonKey(name: 'ram_gb') final double? ramGb,
      @JsonKey(name: 'ssd_gb') final int? ssdGb,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt,
      @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? activatedAt,
      @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? destroyedAt,
      final int? progress,
      final String? stage,
      @JsonKey(name: 'eta_seconds') final int? etaSeconds,
      final Bandwidth? bandwidth}) = _$ServerDetailImpl;

  factory _ServerDetail.fromJson(Map<String, dynamic> json) =
      _$ServerDetailImpl.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status;
  @override
  @JsonKey(name: 'ip_address')
  String? get ipAddress;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  String? get region;
  @override
  String? get os;
  @override
  int? get vcpu;
  @override
  @JsonKey(name: 'ram_gb')
  double? get ramGb;
  @override
  @JsonKey(name: 'ssd_gb')
  int? get ssdGb;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'activated_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get activatedAt;
  @override
  @JsonKey(name: 'destroyed_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get destroyedAt;
  @override
  int? get progress;
  @override
  String? get stage;
  @override
  @JsonKey(name: 'eta_seconds')
  int? get etaSeconds;
  @override
  Bandwidth? get bandwidth;

  /// Create a copy of ServerDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerDetailImplCopyWith<_$ServerDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
