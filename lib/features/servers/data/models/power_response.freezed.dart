// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'power_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PowerResponse _$PowerResponseFromJson(Map<String, dynamic> json) {
  return _PowerResponse.fromJson(json);
}

/// @nodoc
mixin _$PowerResponse {
  String get action => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_id')
  int get serverId => throw _privateConstructorUsedError;

  /// Serializes this PowerResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PowerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PowerResponseCopyWith<PowerResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PowerResponseCopyWith<$Res> {
  factory $PowerResponseCopyWith(
          PowerResponse value, $Res Function(PowerResponse) then) =
      _$PowerResponseCopyWithImpl<$Res, PowerResponse>;
  @useResult
  $Res call(
      {String action, String status, @JsonKey(name: 'server_id') int serverId});
}

/// @nodoc
class _$PowerResponseCopyWithImpl<$Res, $Val extends PowerResponse>
    implements $PowerResponseCopyWith<$Res> {
  _$PowerResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PowerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? status = null,
    Object? serverId = null,
  }) {
    return _then(_value.copyWith(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PowerResponseImplCopyWith<$Res>
    implements $PowerResponseCopyWith<$Res> {
  factory _$$PowerResponseImplCopyWith(
          _$PowerResponseImpl value, $Res Function(_$PowerResponseImpl) then) =
      __$$PowerResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String action, String status, @JsonKey(name: 'server_id') int serverId});
}

/// @nodoc
class __$$PowerResponseImplCopyWithImpl<$Res>
    extends _$PowerResponseCopyWithImpl<$Res, _$PowerResponseImpl>
    implements _$$PowerResponseImplCopyWith<$Res> {
  __$$PowerResponseImplCopyWithImpl(
      _$PowerResponseImpl _value, $Res Function(_$PowerResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PowerResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? status = null,
    Object? serverId = null,
  }) {
    return _then(_$PowerResponseImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PowerResponseImpl implements _PowerResponse {
  const _$PowerResponseImpl(
      {required this.action,
      required this.status,
      @JsonKey(name: 'server_id') required this.serverId});

  factory _$PowerResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PowerResponseImplFromJson(json);

  @override
  final String action;
  @override
  final String status;
  @override
  @JsonKey(name: 'server_id')
  final int serverId;

  @override
  String toString() {
    return 'PowerResponse(action: $action, status: $status, serverId: $serverId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PowerResponseImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, action, status, serverId);

  /// Create a copy of PowerResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PowerResponseImplCopyWith<_$PowerResponseImpl> get copyWith =>
      __$$PowerResponseImplCopyWithImpl<_$PowerResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PowerResponseImplToJson(
      this,
    );
  }
}

abstract class _PowerResponse implements PowerResponse {
  const factory _PowerResponse(
          {required final String action,
          required final String status,
          @JsonKey(name: 'server_id') required final int serverId}) =
      _$PowerResponseImpl;

  factory _PowerResponse.fromJson(Map<String, dynamic> json) =
      _$PowerResponseImpl.fromJson;

  @override
  String get action;
  @override
  String get status;
  @override
  @JsonKey(name: 'server_id')
  int get serverId;

  /// Create a copy of PowerResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PowerResponseImplCopyWith<_$PowerResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
