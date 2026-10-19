// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_server.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminServer _$AdminServerFromJson(Map<String, dynamic> json) {
  return _AdminServer.fromJson(json);
}

/// @nodoc
mixin _$AdminServer {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_email')
  String? get userEmail => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_address')
  String? get ipAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider_slug')
  String? get providerSlug => throw _privateConstructorUsedError;

  /// Serializes this AdminServer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminServerCopyWith<AdminServer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminServerCopyWith<$Res> {
  factory $AdminServerCopyWith(
          AdminServer value, $Res Function(AdminServer) then) =
      _$AdminServerCopyWithImpl<$Res, AdminServer>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'plan_name') String? planName,
      String? region,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'provider_slug') String? providerSlug});
}

/// @nodoc
class _$AdminServerCopyWithImpl<$Res, $Val extends AdminServer>
    implements $AdminServerCopyWith<$Res> {
  _$AdminServerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? status = null,
    Object? planName = freezed,
    Object? region = freezed,
    Object? ipAddress = freezed,
    Object? createdAt = freezed,
    Object? providerSlug = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providerSlug: freezed == providerSlug
          ? _value.providerSlug
          : providerSlug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminServerImplCopyWith<$Res>
    implements $AdminServerCopyWith<$Res> {
  factory _$$AdminServerImplCopyWith(
          _$AdminServerImpl value, $Res Function(_$AdminServerImpl) then) =
      __$$AdminServerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'plan_name') String? planName,
      String? region,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'provider_slug') String? providerSlug});
}

/// @nodoc
class __$$AdminServerImplCopyWithImpl<$Res>
    extends _$AdminServerCopyWithImpl<$Res, _$AdminServerImpl>
    implements _$$AdminServerImplCopyWith<$Res> {
  __$$AdminServerImplCopyWithImpl(
      _$AdminServerImpl _value, $Res Function(_$AdminServerImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminServer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? status = null,
    Object? planName = freezed,
    Object? region = freezed,
    Object? ipAddress = freezed,
    Object? createdAt = freezed,
    Object? providerSlug = freezed,
  }) {
    return _then(_$AdminServerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      providerSlug: freezed == providerSlug
          ? _value.providerSlug
          : providerSlug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminServerImpl implements _AdminServer {
  const _$AdminServerImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_email') this.userEmail,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      required this.status,
      @JsonKey(name: 'plan_name') this.planName,
      this.region,
      @JsonKey(name: 'ip_address') this.ipAddress,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt,
      @JsonKey(name: 'provider_slug') this.providerSlug});

  factory _$AdminServerImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminServerImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'user_email')
  final String? userEmail;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  final ServerStatus status;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  final String? region;
  @override
  @JsonKey(name: 'ip_address')
  final String? ipAddress;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'provider_slug')
  final String? providerSlug;

  @override
  String toString() {
    return 'AdminServer(id: $id, userId: $userId, userEmail: $userEmail, status: $status, planName: $planName, region: $region, ipAddress: $ipAddress, createdAt: $createdAt, providerSlug: $providerSlug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminServerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.providerSlug, providerSlug) ||
                other.providerSlug == providerSlug));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userEmail, status,
      planName, region, ipAddress, createdAt, providerSlug);

  /// Create a copy of AdminServer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminServerImplCopyWith<_$AdminServerImpl> get copyWith =>
      __$$AdminServerImplCopyWithImpl<_$AdminServerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminServerImplToJson(
      this,
    );
  }
}

abstract class _AdminServer implements AdminServer {
  const factory _AdminServer(
          {required final int id,
          @JsonKey(name: 'user_id') required final int userId,
          @JsonKey(name: 'user_email') final String? userEmail,
          @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
          required final ServerStatus status,
          @JsonKey(name: 'plan_name') final String? planName,
          final String? region,
          @JsonKey(name: 'ip_address') final String? ipAddress,
          @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
          final DateTime? createdAt,
          @JsonKey(name: 'provider_slug') final String? providerSlug}) =
      _$AdminServerImpl;

  factory _AdminServer.fromJson(Map<String, dynamic> json) =
      _$AdminServerImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'user_email')
  String? get userEmail;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  String? get region;
  @override
  @JsonKey(name: 'ip_address')
  String? get ipAddress;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'provider_slug')
  String? get providerSlug;

  /// Create a copy of AdminServer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminServerImplCopyWith<_$AdminServerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
