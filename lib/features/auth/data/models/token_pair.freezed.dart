// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenPair _$TokenPairFromJson(Map<String, dynamic> json) {
  return _TokenPair.fromJson(json);
}

/// @nodoc
mixin _$TokenPair {
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get accessExpiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get refreshExpiresAt => throw _privateConstructorUsedError;

  /// Serializes this TokenPair to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenPairCopyWith<TokenPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenPairCopyWith<$Res> {
  factory $TokenPairCopyWith(TokenPair value, $Res Function(TokenPair) then) =
      _$TokenPairCopyWithImpl<$Res, TokenPair>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? accessExpiresAt,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? refreshExpiresAt});
}

/// @nodoc
class _$TokenPairCopyWithImpl<$Res, $Val extends TokenPair>
    implements $TokenPairCopyWith<$Res> {
  _$TokenPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? accessExpiresAt = freezed,
    Object? refreshToken = null,
    Object? refreshExpiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessExpiresAt: freezed == accessExpiresAt
          ? _value.accessExpiresAt
          : accessExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshExpiresAt: freezed == refreshExpiresAt
          ? _value.refreshExpiresAt
          : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenPairImplCopyWith<$Res>
    implements $TokenPairCopyWith<$Res> {
  factory _$$TokenPairImplCopyWith(
          _$TokenPairImpl value, $Res Function(_$TokenPairImpl) then) =
      __$$TokenPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? accessExpiresAt,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? refreshExpiresAt});
}

/// @nodoc
class __$$TokenPairImplCopyWithImpl<$Res>
    extends _$TokenPairCopyWithImpl<$Res, _$TokenPairImpl>
    implements _$$TokenPairImplCopyWith<$Res> {
  __$$TokenPairImplCopyWithImpl(
      _$TokenPairImpl _value, $Res Function(_$TokenPairImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? accessExpiresAt = freezed,
    Object? refreshToken = null,
    Object? refreshExpiresAt = freezed,
  }) {
    return _then(_$TokenPairImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessExpiresAt: freezed == accessExpiresAt
          ? _value.accessExpiresAt
          : accessExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshExpiresAt: freezed == refreshExpiresAt
          ? _value.refreshExpiresAt
          : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenPairImpl implements _TokenPair {
  const _$TokenPairImpl(
      {@JsonKey(name: 'access_token') required this.accessToken,
      @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
      this.accessExpiresAt,
      @JsonKey(name: 'refresh_token') required this.refreshToken,
      @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
      this.refreshExpiresAt});

  factory _$TokenPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenPairImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? accessExpiresAt;
  @override
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @override
  @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? refreshExpiresAt;

  @override
  String toString() {
    return 'TokenPair(accessToken: $accessToken, accessExpiresAt: $accessExpiresAt, refreshToken: $refreshToken, refreshExpiresAt: $refreshExpiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenPairImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.accessExpiresAt, accessExpiresAt) ||
                other.accessExpiresAt == accessExpiresAt) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.refreshExpiresAt, refreshExpiresAt) ||
                other.refreshExpiresAt == refreshExpiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, accessExpiresAt,
      refreshToken, refreshExpiresAt);

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      __$$TokenPairImplCopyWithImpl<_$TokenPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenPairImplToJson(
      this,
    );
  }
}

abstract class _TokenPair implements TokenPair {
  const factory _TokenPair(
      {@JsonKey(name: 'access_token') required final String accessToken,
      @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? accessExpiresAt,
      @JsonKey(name: 'refresh_token') required final String refreshToken,
      @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? refreshExpiresAt}) = _$TokenPairImpl;

  factory _TokenPair.fromJson(Map<String, dynamic> json) =
      _$TokenPairImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @override
  @JsonKey(name: 'access_expires_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get accessExpiresAt;
  @override
  @JsonKey(name: 'refresh_token')
  String get refreshToken;
  @override
  @JsonKey(name: 'refresh_expires_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get refreshExpiresAt;

  /// Create a copy of TokenPair
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenPairImplCopyWith<_$TokenPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
