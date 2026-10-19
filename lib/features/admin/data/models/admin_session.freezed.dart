// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminSession _$AdminSessionFromJson(Map<String, dynamic> json) {
  return _AdminSession.fromJson(json);
}

/// @nodoc
mixin _$AdminSession {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_name')
  String? get deviceName => throw _privateConstructorUsedError;
  String? get platform => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_version')
  String? get appVersion => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastUsedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_ip')
  String? get lastIp => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  bool get current => throw _privateConstructorUsedError;

  /// Serializes this AdminSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminSessionCopyWith<AdminSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminSessionCopyWith<$Res> {
  factory $AdminSessionCopyWith(
          AdminSession value, $Res Function(AdminSession) then) =
      _$AdminSessionCopyWithImpl<$Res, AdminSession>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'device_name') String? deviceName,
      String? platform,
      @JsonKey(name: 'app_version') String? appVersion,
      @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastUsedAt,
      @JsonKey(name: 'last_ip') String? lastIp,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      bool current});
}

/// @nodoc
class _$AdminSessionCopyWithImpl<$Res, $Val extends AdminSession>
    implements $AdminSessionCopyWith<$Res> {
  _$AdminSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = freezed,
    Object? platform = freezed,
    Object? appVersion = freezed,
    Object? lastUsedAt = freezed,
    Object? lastIp = freezed,
    Object? createdAt = freezed,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastIp: freezed == lastIp
          ? _value.lastIp
          : lastIp // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminSessionImplCopyWith<$Res>
    implements $AdminSessionCopyWith<$Res> {
  factory _$$AdminSessionImplCopyWith(
          _$AdminSessionImpl value, $Res Function(_$AdminSessionImpl) then) =
      __$$AdminSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'device_name') String? deviceName,
      String? platform,
      @JsonKey(name: 'app_version') String? appVersion,
      @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastUsedAt,
      @JsonKey(name: 'last_ip') String? lastIp,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      bool current});
}

/// @nodoc
class __$$AdminSessionImplCopyWithImpl<$Res>
    extends _$AdminSessionCopyWithImpl<$Res, _$AdminSessionImpl>
    implements _$$AdminSessionImplCopyWith<$Res> {
  __$$AdminSessionImplCopyWithImpl(
      _$AdminSessionImpl _value, $Res Function(_$AdminSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? deviceName = freezed,
    Object? platform = freezed,
    Object? appVersion = freezed,
    Object? lastUsedAt = freezed,
    Object? lastIp = freezed,
    Object? createdAt = freezed,
    Object? current = null,
  }) {
    return _then(_$AdminSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastIp: freezed == lastIp
          ? _value.lastIp
          : lastIp // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminSessionImpl implements _AdminSession {
  const _$AdminSessionImpl(
      {required this.id,
      @JsonKey(name: 'device_name') this.deviceName,
      this.platform,
      @JsonKey(name: 'app_version') this.appVersion,
      @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
      this.lastUsedAt,
      @JsonKey(name: 'last_ip') this.lastIp,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt,
      this.current = false});

  factory _$AdminSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminSessionImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'device_name')
  final String? deviceName;
  @override
  final String? platform;
  @override
  @JsonKey(name: 'app_version')
  final String? appVersion;
  @override
  @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? lastUsedAt;
  @override
  @JsonKey(name: 'last_ip')
  final String? lastIp;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;
  @override
  @JsonKey()
  final bool current;

  @override
  String toString() {
    return 'AdminSession(id: $id, deviceName: $deviceName, platform: $platform, appVersion: $appVersion, lastUsedAt: $lastUsedAt, lastIp: $lastIp, createdAt: $createdAt, current: $current)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.lastIp, lastIp) || other.lastIp == lastIp) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, deviceName, platform,
      appVersion, lastUsedAt, lastIp, createdAt, current);

  /// Create a copy of AdminSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSessionImplCopyWith<_$AdminSessionImpl> get copyWith =>
      __$$AdminSessionImplCopyWithImpl<_$AdminSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminSessionImplToJson(
      this,
    );
  }
}

abstract class _AdminSession implements AdminSession {
  const factory _AdminSession(
      {required final int id,
      @JsonKey(name: 'device_name') final String? deviceName,
      final String? platform,
      @JsonKey(name: 'app_version') final String? appVersion,
      @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? lastUsedAt,
      @JsonKey(name: 'last_ip') final String? lastIp,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt,
      final bool current}) = _$AdminSessionImpl;

  factory _AdminSession.fromJson(Map<String, dynamic> json) =
      _$AdminSessionImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'device_name')
  String? get deviceName;
  @override
  String? get platform;
  @override
  @JsonKey(name: 'app_version')
  String? get appVersion;
  @override
  @JsonKey(name: 'last_used_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastUsedAt;
  @override
  @JsonKey(name: 'last_ip')
  String? get lastIp;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;
  @override
  bool get current;

  /// Create a copy of AdminSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSessionImplCopyWith<_$AdminSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
