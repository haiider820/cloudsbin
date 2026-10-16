// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'credential_reveal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CredentialReveal _$CredentialRevealFromJson(Map<String, dynamic> json) {
  return _CredentialReveal.fromJson(json);
}

/// @nodoc
mixin _$CredentialReveal {
  @JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
  AuthType get authType => throw _privateConstructorUsedError;
  String? get credential => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_address')
  String? get ipAddress => throw _privateConstructorUsedError;

  /// Serializes this CredentialReveal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CredentialReveal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CredentialRevealCopyWith<CredentialReveal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CredentialRevealCopyWith<$Res> {
  factory $CredentialRevealCopyWith(
          CredentialReveal value, $Res Function(CredentialReveal) then) =
      _$CredentialRevealCopyWithImpl<$Res, CredentialReveal>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
      AuthType authType,
      String? credential,
      @JsonKey(name: 'ip_address') String? ipAddress});
}

/// @nodoc
class _$CredentialRevealCopyWithImpl<$Res, $Val extends CredentialReveal>
    implements $CredentialRevealCopyWith<$Res> {
  _$CredentialRevealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CredentialReveal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authType = null,
    Object? credential = freezed,
    Object? ipAddress = freezed,
  }) {
    return _then(_value.copyWith(
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as AuthType,
      credential: freezed == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CredentialRevealImplCopyWith<$Res>
    implements $CredentialRevealCopyWith<$Res> {
  factory _$$CredentialRevealImplCopyWith(_$CredentialRevealImpl value,
          $Res Function(_$CredentialRevealImpl) then) =
      __$$CredentialRevealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
      AuthType authType,
      String? credential,
      @JsonKey(name: 'ip_address') String? ipAddress});
}

/// @nodoc
class __$$CredentialRevealImplCopyWithImpl<$Res>
    extends _$CredentialRevealCopyWithImpl<$Res, _$CredentialRevealImpl>
    implements _$$CredentialRevealImplCopyWith<$Res> {
  __$$CredentialRevealImplCopyWithImpl(_$CredentialRevealImpl _value,
      $Res Function(_$CredentialRevealImpl) _then)
      : super(_value, _then);

  /// Create a copy of CredentialReveal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authType = null,
    Object? credential = freezed,
    Object? ipAddress = freezed,
  }) {
    return _then(_$CredentialRevealImpl(
      authType: null == authType
          ? _value.authType
          : authType // ignore: cast_nullable_to_non_nullable
              as AuthType,
      credential: freezed == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as String?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CredentialRevealImpl implements _CredentialReveal {
  const _$CredentialRevealImpl(
      {@JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
      required this.authType,
      this.credential,
      @JsonKey(name: 'ip_address') this.ipAddress});

  factory _$CredentialRevealImpl.fromJson(Map<String, dynamic> json) =>
      _$$CredentialRevealImplFromJson(json);

  @override
  @JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
  final AuthType authType;
  @override
  final String? credential;
  @override
  @JsonKey(name: 'ip_address')
  final String? ipAddress;

  @override
  String toString() {
    return 'CredentialReveal(authType: $authType, credential: $credential, ipAddress: $ipAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CredentialRevealImpl &&
            (identical(other.authType, authType) ||
                other.authType == authType) &&
            (identical(other.credential, credential) ||
                other.credential == credential) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, authType, credential, ipAddress);

  /// Create a copy of CredentialReveal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CredentialRevealImplCopyWith<_$CredentialRevealImpl> get copyWith =>
      __$$CredentialRevealImplCopyWithImpl<_$CredentialRevealImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CredentialRevealImplToJson(
      this,
    );
  }
}

abstract class _CredentialReveal implements CredentialReveal {
  const factory _CredentialReveal(
          {@JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
          required final AuthType authType,
          final String? credential,
          @JsonKey(name: 'ip_address') final String? ipAddress}) =
      _$CredentialRevealImpl;

  factory _CredentialReveal.fromJson(Map<String, dynamic> json) =
      _$CredentialRevealImpl.fromJson;

  @override
  @JsonKey(fromJson: AuthType.fromJson, toJson: AuthType.toJson)
  AuthType get authType;
  @override
  String? get credential;
  @override
  @JsonKey(name: 'ip_address')
  String? get ipAddress;

  /// Create a copy of CredentialReveal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CredentialRevealImplCopyWith<_$CredentialRevealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
