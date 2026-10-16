// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ip_whitelist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WhitelistIp _$WhitelistIpFromJson(Map<String, dynamic> json) {
  return _WhitelistIp.fromJson(json);
}

/// @nodoc
mixin _$WhitelistIp {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr => throw _privateConstructorUsedError;
  int? get port => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WhitelistIp to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WhitelistIp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WhitelistIpCopyWith<WhitelistIp> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhitelistIpCopyWith<$Res> {
  factory $WhitelistIpCopyWith(
          WhitelistIp value, $Res Function(WhitelistIp) then) =
      _$WhitelistIpCopyWithImpl<$Res, WhitelistIp>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      int? port,
      String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$WhitelistIpCopyWithImpl<$Res, $Val extends WhitelistIp>
    implements $WhitelistIpCopyWith<$Res> {
  _$WhitelistIpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WhitelistIp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ipCidr = freezed,
    Object? port = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WhitelistIpImplCopyWith<$Res>
    implements $WhitelistIpCopyWith<$Res> {
  factory _$$WhitelistIpImplCopyWith(
          _$WhitelistIpImpl value, $Res Function(_$WhitelistIpImpl) then) =
      __$$WhitelistIpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      int? port,
      String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$WhitelistIpImplCopyWithImpl<$Res>
    extends _$WhitelistIpCopyWithImpl<$Res, _$WhitelistIpImpl>
    implements _$$WhitelistIpImplCopyWith<$Res> {
  __$$WhitelistIpImplCopyWithImpl(
      _$WhitelistIpImpl _value, $Res Function(_$WhitelistIpImpl) _then)
      : super(_value, _then);

  /// Create a copy of WhitelistIp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ipCidr = freezed,
    Object? port = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$WhitelistIpImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      port: freezed == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WhitelistIpImpl implements _WhitelistIp {
  const _$WhitelistIpImpl(
      {required this.id,
      @JsonKey(name: 'ip_cidr') this.ipCidr,
      this.port,
      this.description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$WhitelistIpImpl.fromJson(Map<String, dynamic> json) =>
      _$$WhitelistIpImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'ip_cidr')
  final String? ipCidr;
  @override
  final int? port;
  @override
  final String? description;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'WhitelistIp(id: $id, ipCidr: $ipCidr, port: $port, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhitelistIpImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ipCidr, ipCidr) || other.ipCidr == ipCidr) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, ipCidr, port, description, createdAt);

  /// Create a copy of WhitelistIp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WhitelistIpImplCopyWith<_$WhitelistIpImpl> get copyWith =>
      __$$WhitelistIpImplCopyWithImpl<_$WhitelistIpImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WhitelistIpImplToJson(
      this,
    );
  }
}

abstract class _WhitelistIp implements WhitelistIp {
  const factory _WhitelistIp(
      {required final int id,
      @JsonKey(name: 'ip_cidr') final String? ipCidr,
      final int? port,
      final String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$WhitelistIpImpl;

  factory _WhitelistIp.fromJson(Map<String, dynamic> json) =
      _$WhitelistIpImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr;
  @override
  int? get port;
  @override
  String? get description;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of WhitelistIp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WhitelistIpImplCopyWith<_$WhitelistIpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IpWhitelistResponse _$IpWhitelistResponseFromJson(Map<String, dynamic> json) {
  return _IpWhitelistResponse.fromJson(json);
}

/// @nodoc
mixin _$IpWhitelistResponse {
  List<WhitelistIp> get ips => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;

  /// Serializes this IpWhitelistResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IpWhitelistResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IpWhitelistResponseCopyWith<IpWhitelistResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpWhitelistResponseCopyWith<$Res> {
  factory $IpWhitelistResponseCopyWith(
          IpWhitelistResponse value, $Res Function(IpWhitelistResponse) then) =
      _$IpWhitelistResponseCopyWithImpl<$Res, IpWhitelistResponse>;
  @useResult
  $Res call(
      {List<WhitelistIp> ips, @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class _$IpWhitelistResponseCopyWithImpl<$Res, $Val extends IpWhitelistResponse>
    implements $IpWhitelistResponseCopyWith<$Res> {
  _$IpWhitelistResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IpWhitelistResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ips = null,
    Object? accessPort = freezed,
  }) {
    return _then(_value.copyWith(
      ips: null == ips
          ? _value.ips
          : ips // ignore: cast_nullable_to_non_nullable
              as List<WhitelistIp>,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IpWhitelistResponseImplCopyWith<$Res>
    implements $IpWhitelistResponseCopyWith<$Res> {
  factory _$$IpWhitelistResponseImplCopyWith(_$IpWhitelistResponseImpl value,
          $Res Function(_$IpWhitelistResponseImpl) then) =
      __$$IpWhitelistResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<WhitelistIp> ips, @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class __$$IpWhitelistResponseImplCopyWithImpl<$Res>
    extends _$IpWhitelistResponseCopyWithImpl<$Res, _$IpWhitelistResponseImpl>
    implements _$$IpWhitelistResponseImplCopyWith<$Res> {
  __$$IpWhitelistResponseImplCopyWithImpl(_$IpWhitelistResponseImpl _value,
      $Res Function(_$IpWhitelistResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of IpWhitelistResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ips = null,
    Object? accessPort = freezed,
  }) {
    return _then(_$IpWhitelistResponseImpl(
      ips: null == ips
          ? _value._ips
          : ips // ignore: cast_nullable_to_non_nullable
              as List<WhitelistIp>,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IpWhitelistResponseImpl implements _IpWhitelistResponse {
  const _$IpWhitelistResponseImpl(
      {final List<WhitelistIp> ips = const <WhitelistIp>[],
      @JsonKey(name: 'access_port') this.accessPort})
      : _ips = ips;

  factory _$IpWhitelistResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$IpWhitelistResponseImplFromJson(json);

  final List<WhitelistIp> _ips;
  @override
  @JsonKey()
  List<WhitelistIp> get ips {
    if (_ips is EqualUnmodifiableListView) return _ips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ips);
  }

  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;

  @override
  String toString() {
    return 'IpWhitelistResponse(ips: $ips, accessPort: $accessPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpWhitelistResponseImpl &&
            const DeepCollectionEquality().equals(other._ips, _ips) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_ips), accessPort);

  /// Create a copy of IpWhitelistResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IpWhitelistResponseImplCopyWith<_$IpWhitelistResponseImpl> get copyWith =>
      __$$IpWhitelistResponseImplCopyWithImpl<_$IpWhitelistResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IpWhitelistResponseImplToJson(
      this,
    );
  }
}

abstract class _IpWhitelistResponse implements IpWhitelistResponse {
  const factory _IpWhitelistResponse(
          {final List<WhitelistIp> ips,
          @JsonKey(name: 'access_port') final int? accessPort}) =
      _$IpWhitelistResponseImpl;

  factory _IpWhitelistResponse.fromJson(Map<String, dynamic> json) =
      _$IpWhitelistResponseImpl.fromJson;

  @override
  List<WhitelistIp> get ips;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;

  /// Create a copy of IpWhitelistResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IpWhitelistResponseImplCopyWith<_$IpWhitelistResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WhitelistAddResult _$WhitelistAddResultFromJson(Map<String, dynamic> json) {
  return _WhitelistAddResult.fromJson(json);
}

/// @nodoc
mixin _$WhitelistAddResult {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;

  /// Serializes this WhitelistAddResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WhitelistAddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WhitelistAddResultCopyWith<WhitelistAddResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhitelistAddResultCopyWith<$Res> {
  factory $WhitelistAddResultCopyWith(
          WhitelistAddResult value, $Res Function(WhitelistAddResult) then) =
      _$WhitelistAddResultCopyWithImpl<$Res, WhitelistAddResult>;
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class _$WhitelistAddResultCopyWithImpl<$Res, $Val extends WhitelistAddResult>
    implements $WhitelistAddResultCopyWith<$Res> {
  _$WhitelistAddResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WhitelistAddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ipCidr = freezed,
    Object? accessPort = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WhitelistAddResultImplCopyWith<$Res>
    implements $WhitelistAddResultCopyWith<$Res> {
  factory _$$WhitelistAddResultImplCopyWith(_$WhitelistAddResultImpl value,
          $Res Function(_$WhitelistAddResultImpl) then) =
      __$$WhitelistAddResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class __$$WhitelistAddResultImplCopyWithImpl<$Res>
    extends _$WhitelistAddResultCopyWithImpl<$Res, _$WhitelistAddResultImpl>
    implements _$$WhitelistAddResultImplCopyWith<$Res> {
  __$$WhitelistAddResultImplCopyWithImpl(_$WhitelistAddResultImpl _value,
      $Res Function(_$WhitelistAddResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of WhitelistAddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ipCidr = freezed,
    Object? accessPort = freezed,
  }) {
    return _then(_$WhitelistAddResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WhitelistAddResultImpl implements _WhitelistAddResult {
  const _$WhitelistAddResultImpl(
      {this.message,
      @JsonKey(name: 'ip_cidr') this.ipCidr,
      @JsonKey(name: 'access_port') this.accessPort});

  factory _$WhitelistAddResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WhitelistAddResultImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'ip_cidr')
  final String? ipCidr;
  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;

  @override
  String toString() {
    return 'WhitelistAddResult(message: $message, ipCidr: $ipCidr, accessPort: $accessPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhitelistAddResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.ipCidr, ipCidr) || other.ipCidr == ipCidr) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, ipCidr, accessPort);

  /// Create a copy of WhitelistAddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WhitelistAddResultImplCopyWith<_$WhitelistAddResultImpl> get copyWith =>
      __$$WhitelistAddResultImplCopyWithImpl<_$WhitelistAddResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WhitelistAddResultImplToJson(
      this,
    );
  }
}

abstract class _WhitelistAddResult implements WhitelistAddResult {
  const factory _WhitelistAddResult(
          {final String? message,
          @JsonKey(name: 'ip_cidr') final String? ipCidr,
          @JsonKey(name: 'access_port') final int? accessPort}) =
      _$WhitelistAddResultImpl;

  factory _WhitelistAddResult.fromJson(Map<String, dynamic> json) =
      _$WhitelistAddResultImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;

  /// Create a copy of WhitelistAddResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WhitelistAddResultImplCopyWith<_$WhitelistAddResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WhitelistRemoveResult _$WhitelistRemoveResultFromJson(
    Map<String, dynamic> json) {
  return _WhitelistRemoveResult.fromJson(json);
}

/// @nodoc
mixin _$WhitelistRemoveResult {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'rule_id')
  int? get ruleId => throw _privateConstructorUsedError;
  bool? get removed => throw _privateConstructorUsedError;

  /// Serializes this WhitelistRemoveResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WhitelistRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WhitelistRemoveResultCopyWith<WhitelistRemoveResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WhitelistRemoveResultCopyWith<$Res> {
  factory $WhitelistRemoveResultCopyWith(WhitelistRemoveResult value,
          $Res Function(WhitelistRemoveResult) then) =
      _$WhitelistRemoveResultCopyWithImpl<$Res, WhitelistRemoveResult>;
  @useResult
  $Res call(
      {String? message, @JsonKey(name: 'rule_id') int? ruleId, bool? removed});
}

/// @nodoc
class _$WhitelistRemoveResultCopyWithImpl<$Res,
        $Val extends WhitelistRemoveResult>
    implements $WhitelistRemoveResultCopyWith<$Res> {
  _$WhitelistRemoveResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WhitelistRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ruleId = freezed,
    Object? removed = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ruleId: freezed == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as int?,
      removed: freezed == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WhitelistRemoveResultImplCopyWith<$Res>
    implements $WhitelistRemoveResultCopyWith<$Res> {
  factory _$$WhitelistRemoveResultImplCopyWith(
          _$WhitelistRemoveResultImpl value,
          $Res Function(_$WhitelistRemoveResultImpl) then) =
      __$$WhitelistRemoveResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message, @JsonKey(name: 'rule_id') int? ruleId, bool? removed});
}

/// @nodoc
class __$$WhitelistRemoveResultImplCopyWithImpl<$Res>
    extends _$WhitelistRemoveResultCopyWithImpl<$Res,
        _$WhitelistRemoveResultImpl>
    implements _$$WhitelistRemoveResultImplCopyWith<$Res> {
  __$$WhitelistRemoveResultImplCopyWithImpl(_$WhitelistRemoveResultImpl _value,
      $Res Function(_$WhitelistRemoveResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of WhitelistRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ruleId = freezed,
    Object? removed = freezed,
  }) {
    return _then(_$WhitelistRemoveResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ruleId: freezed == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as int?,
      removed: freezed == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WhitelistRemoveResultImpl implements _WhitelistRemoveResult {
  const _$WhitelistRemoveResultImpl(
      {this.message, @JsonKey(name: 'rule_id') this.ruleId, this.removed});

  factory _$WhitelistRemoveResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WhitelistRemoveResultImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'rule_id')
  final int? ruleId;
  @override
  final bool? removed;

  @override
  String toString() {
    return 'WhitelistRemoveResult(message: $message, ruleId: $ruleId, removed: $removed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WhitelistRemoveResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId) &&
            (identical(other.removed, removed) || other.removed == removed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, ruleId, removed);

  /// Create a copy of WhitelistRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WhitelistRemoveResultImplCopyWith<_$WhitelistRemoveResultImpl>
      get copyWith => __$$WhitelistRemoveResultImplCopyWithImpl<
          _$WhitelistRemoveResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WhitelistRemoveResultImplToJson(
      this,
    );
  }
}

abstract class _WhitelistRemoveResult implements WhitelistRemoveResult {
  const factory _WhitelistRemoveResult(
      {final String? message,
      @JsonKey(name: 'rule_id') final int? ruleId,
      final bool? removed}) = _$WhitelistRemoveResultImpl;

  factory _WhitelistRemoveResult.fromJson(Map<String, dynamic> json) =
      _$WhitelistRemoveResultImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(name: 'rule_id')
  int? get ruleId;
  @override
  bool? get removed;

  /// Create a copy of WhitelistRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WhitelistRemoveResultImplCopyWith<_$WhitelistRemoveResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
