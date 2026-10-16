// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regenerate_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegenerateResult _$RegenerateResultFromJson(Map<String, dynamic> json) {
  return _RegenerateResult.fromJson(json);
}

/// @nodoc
mixin _$RegenerateResult {
  @JsonKey(name: 'server_id')
  int get serverId => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this RegenerateResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegenerateResultCopyWith<RegenerateResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegenerateResultCopyWith<$Res> {
  factory $RegenerateResultCopyWith(
          RegenerateResult value, $Res Function(RegenerateResult) then) =
      _$RegenerateResultCopyWithImpl<$Res, RegenerateResult>;
  @useResult
  $Res call({@JsonKey(name: 'server_id') int serverId, String message});
}

/// @nodoc
class _$RegenerateResultCopyWithImpl<$Res, $Val extends RegenerateResult>
    implements $RegenerateResultCopyWith<$Res> {
  _$RegenerateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegenerateResultImplCopyWith<$Res>
    implements $RegenerateResultCopyWith<$Res> {
  factory _$$RegenerateResultImplCopyWith(_$RegenerateResultImpl value,
          $Res Function(_$RegenerateResultImpl) then) =
      __$$RegenerateResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'server_id') int serverId, String message});
}

/// @nodoc
class __$$RegenerateResultImplCopyWithImpl<$Res>
    extends _$RegenerateResultCopyWithImpl<$Res, _$RegenerateResultImpl>
    implements _$$RegenerateResultImplCopyWith<$Res> {
  __$$RegenerateResultImplCopyWithImpl(_$RegenerateResultImpl _value,
      $Res Function(_$RegenerateResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? message = null,
  }) {
    return _then(_$RegenerateResultImpl(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegenerateResultImpl implements _RegenerateResult {
  const _$RegenerateResultImpl(
      {@JsonKey(name: 'server_id') required this.serverId,
      required this.message});

  factory _$RegenerateResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegenerateResultImplFromJson(json);

  @override
  @JsonKey(name: 'server_id')
  final int serverId;
  @override
  final String message;

  @override
  String toString() {
    return 'RegenerateResult(serverId: $serverId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegenerateResultImpl &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serverId, message);

  /// Create a copy of RegenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegenerateResultImplCopyWith<_$RegenerateResultImpl> get copyWith =>
      __$$RegenerateResultImplCopyWithImpl<_$RegenerateResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegenerateResultImplToJson(
      this,
    );
  }
}

abstract class _RegenerateResult implements RegenerateResult {
  const factory _RegenerateResult(
      {@JsonKey(name: 'server_id') required final int serverId,
      required final String message}) = _$RegenerateResultImpl;

  factory _RegenerateResult.fromJson(Map<String, dynamic> json) =
      _$RegenerateResultImpl.fromJson;

  @override
  @JsonKey(name: 'server_id')
  int get serverId;
  @override
  String get message;

  /// Create a copy of RegenerateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegenerateResultImplCopyWith<_$RegenerateResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
