// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_actions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DestroyResult _$DestroyResultFromJson(Map<String, dynamic> json) {
  return _DestroyResult.fromJson(json);
}

/// @nodoc
mixin _$DestroyResult {
  @JsonKey(name: 'server_id')
  int get serverId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus? get status => throw _privateConstructorUsedError;

  /// Serializes this DestroyResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DestroyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DestroyResultCopyWith<DestroyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DestroyResultCopyWith<$Res> {
  factory $DestroyResultCopyWith(
          DestroyResult value, $Res Function(DestroyResult) then) =
      _$DestroyResultCopyWithImpl<$Res, DestroyResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'server_id') int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus? status});
}

/// @nodoc
class _$DestroyResultCopyWithImpl<$Res, $Val extends DestroyResult>
    implements $DestroyResultCopyWith<$Res> {
  _$DestroyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DestroyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DestroyResultImplCopyWith<$Res>
    implements $DestroyResultCopyWith<$Res> {
  factory _$$DestroyResultImplCopyWith(
          _$DestroyResultImpl value, $Res Function(_$DestroyResultImpl) then) =
      __$$DestroyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'server_id') int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus? status});
}

/// @nodoc
class __$$DestroyResultImplCopyWithImpl<$Res>
    extends _$DestroyResultCopyWithImpl<$Res, _$DestroyResultImpl>
    implements _$$DestroyResultImplCopyWith<$Res> {
  __$$DestroyResultImplCopyWithImpl(
      _$DestroyResultImpl _value, $Res Function(_$DestroyResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of DestroyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = freezed,
  }) {
    return _then(_$DestroyResultImpl(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DestroyResultImpl implements _DestroyResult {
  const _$DestroyResultImpl(
      {@JsonKey(name: 'server_id') required this.serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      this.status});

  factory _$DestroyResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$DestroyResultImplFromJson(json);

  @override
  @JsonKey(name: 'server_id')
  final int serverId;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  final ServerStatus? status;

  @override
  String toString() {
    return 'DestroyResult(serverId: $serverId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DestroyResultImpl &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serverId, status);

  /// Create a copy of DestroyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DestroyResultImplCopyWith<_$DestroyResultImpl> get copyWith =>
      __$$DestroyResultImplCopyWithImpl<_$DestroyResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DestroyResultImplToJson(
      this,
    );
  }
}

abstract class _DestroyResult implements DestroyResult {
  const factory _DestroyResult(
      {@JsonKey(name: 'server_id') required final int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      final ServerStatus? status}) = _$DestroyResultImpl;

  factory _DestroyResult.fromJson(Map<String, dynamic> json) =
      _$DestroyResultImpl.fromJson;

  @override
  @JsonKey(name: 'server_id')
  int get serverId;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus? get status;

  /// Create a copy of DestroyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DestroyResultImplCopyWith<_$DestroyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccessPortCommand _$AccessPortCommandFromJson(Map<String, dynamic> json) {
  return _AccessPortCommand.fromJson(json);
}

/// @nodoc
mixin _$AccessPortCommand {
  int? get id => throw _privateConstructorUsedError;
  String? get step => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this AccessPortCommand to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccessPortCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessPortCommandCopyWith<AccessPortCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessPortCommandCopyWith<$Res> {
  factory $AccessPortCommandCopyWith(
          AccessPortCommand value, $Res Function(AccessPortCommand) then) =
      _$AccessPortCommandCopyWithImpl<$Res, AccessPortCommand>;
  @useResult
  $Res call({int? id, String? step, String? status});
}

/// @nodoc
class _$AccessPortCommandCopyWithImpl<$Res, $Val extends AccessPortCommand>
    implements $AccessPortCommandCopyWith<$Res> {
  _$AccessPortCommandCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessPortCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? step = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccessPortCommandImplCopyWith<$Res>
    implements $AccessPortCommandCopyWith<$Res> {
  factory _$$AccessPortCommandImplCopyWith(_$AccessPortCommandImpl value,
          $Res Function(_$AccessPortCommandImpl) then) =
      __$$AccessPortCommandImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? step, String? status});
}

/// @nodoc
class __$$AccessPortCommandImplCopyWithImpl<$Res>
    extends _$AccessPortCommandCopyWithImpl<$Res, _$AccessPortCommandImpl>
    implements _$$AccessPortCommandImplCopyWith<$Res> {
  __$$AccessPortCommandImplCopyWithImpl(_$AccessPortCommandImpl _value,
      $Res Function(_$AccessPortCommandImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccessPortCommand
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? step = freezed,
    Object? status = freezed,
  }) {
    return _then(_$AccessPortCommandImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      step: freezed == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccessPortCommandImpl implements _AccessPortCommand {
  const _$AccessPortCommandImpl({this.id, this.step, this.status});

  factory _$AccessPortCommandImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessPortCommandImplFromJson(json);

  @override
  final int? id;
  @override
  final String? step;
  @override
  final String? status;

  @override
  String toString() {
    return 'AccessPortCommand(id: $id, step: $step, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessPortCommandImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, step, status);

  /// Create a copy of AccessPortCommand
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessPortCommandImplCopyWith<_$AccessPortCommandImpl> get copyWith =>
      __$$AccessPortCommandImplCopyWithImpl<_$AccessPortCommandImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessPortCommandImplToJson(
      this,
    );
  }
}

abstract class _AccessPortCommand implements AccessPortCommand {
  const factory _AccessPortCommand(
      {final int? id,
      final String? step,
      final String? status}) = _$AccessPortCommandImpl;

  factory _AccessPortCommand.fromJson(Map<String, dynamic> json) =
      _$AccessPortCommandImpl.fromJson;

  @override
  int? get id;
  @override
  String? get step;
  @override
  String? get status;

  /// Create a copy of AccessPortCommand
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessPortCommandImplCopyWith<_$AccessPortCommandImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AccessPortResult _$AccessPortResultFromJson(Map<String, dynamic> json) {
  return _AccessPortResult.fromJson(json);
}

/// @nodoc
mixin _$AccessPortResult {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;
  @JsonKey(name: 'new_port')
  int? get newPort => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_id')
  int? get serverId => throw _privateConstructorUsedError;
  AccessPortCommand? get command => throw _privateConstructorUsedError;

  /// Serializes this AccessPortResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccessPortResultCopyWith<AccessPortResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccessPortResultCopyWith<$Res> {
  factory $AccessPortResultCopyWith(
          AccessPortResult value, $Res Function(AccessPortResult) then) =
      _$AccessPortResultCopyWithImpl<$Res, AccessPortResult>;
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'access_port') int? accessPort,
      @JsonKey(name: 'new_port') int? newPort,
      @JsonKey(name: 'server_id') int? serverId,
      AccessPortCommand? command});

  $AccessPortCommandCopyWith<$Res>? get command;
}

/// @nodoc
class _$AccessPortResultCopyWithImpl<$Res, $Val extends AccessPortResult>
    implements $AccessPortResultCopyWith<$Res> {
  _$AccessPortResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? accessPort = freezed,
    Object? newPort = freezed,
    Object? serverId = freezed,
    Object? command = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      newPort: freezed == newPort
          ? _value.newPort
          : newPort // ignore: cast_nullable_to_non_nullable
              as int?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
      command: freezed == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as AccessPortCommand?,
    ) as $Val);
  }

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccessPortCommandCopyWith<$Res>? get command {
    if (_value.command == null) {
      return null;
    }

    return $AccessPortCommandCopyWith<$Res>(_value.command!, (value) {
      return _then(_value.copyWith(command: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccessPortResultImplCopyWith<$Res>
    implements $AccessPortResultCopyWith<$Res> {
  factory _$$AccessPortResultImplCopyWith(_$AccessPortResultImpl value,
          $Res Function(_$AccessPortResultImpl) then) =
      __$$AccessPortResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      @JsonKey(name: 'access_port') int? accessPort,
      @JsonKey(name: 'new_port') int? newPort,
      @JsonKey(name: 'server_id') int? serverId,
      AccessPortCommand? command});

  @override
  $AccessPortCommandCopyWith<$Res>? get command;
}

/// @nodoc
class __$$AccessPortResultImplCopyWithImpl<$Res>
    extends _$AccessPortResultCopyWithImpl<$Res, _$AccessPortResultImpl>
    implements _$$AccessPortResultImplCopyWith<$Res> {
  __$$AccessPortResultImplCopyWithImpl(_$AccessPortResultImpl _value,
      $Res Function(_$AccessPortResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? accessPort = freezed,
    Object? newPort = freezed,
    Object? serverId = freezed,
    Object? command = freezed,
  }) {
    return _then(_$AccessPortResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      newPort: freezed == newPort
          ? _value.newPort
          : newPort // ignore: cast_nullable_to_non_nullable
              as int?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
      command: freezed == command
          ? _value.command
          : command // ignore: cast_nullable_to_non_nullable
              as AccessPortCommand?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccessPortResultImpl implements _AccessPortResult {
  const _$AccessPortResultImpl(
      {this.message,
      @JsonKey(name: 'access_port') this.accessPort,
      @JsonKey(name: 'new_port') this.newPort,
      @JsonKey(name: 'server_id') this.serverId,
      this.command});

  factory _$AccessPortResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccessPortResultImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;
  @override
  @JsonKey(name: 'new_port')
  final int? newPort;
  @override
  @JsonKey(name: 'server_id')
  final int? serverId;
  @override
  final AccessPortCommand? command;

  @override
  String toString() {
    return 'AccessPortResult(message: $message, accessPort: $accessPort, newPort: $newPort, serverId: $serverId, command: $command)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccessPortResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort) &&
            (identical(other.newPort, newPort) || other.newPort == newPort) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.command, command) || other.command == command));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, message, accessPort, newPort, serverId, command);

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccessPortResultImplCopyWith<_$AccessPortResultImpl> get copyWith =>
      __$$AccessPortResultImplCopyWithImpl<_$AccessPortResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccessPortResultImplToJson(
      this,
    );
  }
}

abstract class _AccessPortResult implements AccessPortResult {
  const factory _AccessPortResult(
      {final String? message,
      @JsonKey(name: 'access_port') final int? accessPort,
      @JsonKey(name: 'new_port') final int? newPort,
      @JsonKey(name: 'server_id') final int? serverId,
      final AccessPortCommand? command}) = _$AccessPortResultImpl;

  factory _AccessPortResult.fromJson(Map<String, dynamic> json) =
      _$AccessPortResultImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;
  @override
  @JsonKey(name: 'new_port')
  int? get newPort;
  @override
  @JsonKey(name: 'server_id')
  int? get serverId;
  @override
  AccessPortCommand? get command;

  /// Create a copy of AccessPortResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccessPortResultImplCopyWith<_$AccessPortResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
