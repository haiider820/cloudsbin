// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminProfile _$AdminProfileFromJson(Map<String, dynamic> json) {
  return _AdminProfile.fromJson(json);
}

/// @nodoc
mixin _$AdminProfile {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'referral_code')
  String? get referralCode => throw _privateConstructorUsedError;

  /// Serializes this AdminProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminProfileCopyWith<AdminProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminProfileCopyWith<$Res> {
  factory $AdminProfileCopyWith(
          AdminProfile value, $Res Function(AdminProfile) then) =
      _$AdminProfileCopyWithImpl<$Res, AdminProfile>;
  @useResult
  $Res call(
      {int id,
      String email,
      String role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'referral_code') String? referralCode});
}

/// @nodoc
class _$AdminProfileCopyWithImpl<$Res, $Val extends AdminProfile>
    implements $AdminProfileCopyWith<$Res> {
  _$AdminProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? referralCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminProfileImplCopyWith<$Res>
    implements $AdminProfileCopyWith<$Res> {
  factory _$$AdminProfileImplCopyWith(
          _$AdminProfileImpl value, $Res Function(_$AdminProfileImpl) then) =
      __$$AdminProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'referral_code') String? referralCode});
}

/// @nodoc
class __$$AdminProfileImplCopyWithImpl<$Res>
    extends _$AdminProfileCopyWithImpl<$Res, _$AdminProfileImpl>
    implements _$$AdminProfileImplCopyWith<$Res> {
  __$$AdminProfileImplCopyWithImpl(
      _$AdminProfileImpl _value, $Res Function(_$AdminProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? referralCode = freezed,
  }) {
    return _then(_$AdminProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminProfileImpl implements _AdminProfile {
  const _$AdminProfileImpl(
      {required this.id,
      required this.email,
      required this.role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt,
      @JsonKey(name: 'referral_code') this.referralCode});

  factory _$AdminProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminProfileImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String role;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'referral_code')
  final String? referralCode;

  @override
  String toString() {
    return 'AdminProfile(id: $id, email: $email, role: $role, createdAt: $createdAt, referralCode: $referralCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, email, role, createdAt, referralCode);

  /// Create a copy of AdminProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminProfileImplCopyWith<_$AdminProfileImpl> get copyWith =>
      __$$AdminProfileImplCopyWithImpl<_$AdminProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminProfileImplToJson(
      this,
    );
  }
}

abstract class _AdminProfile implements AdminProfile {
  const factory _AdminProfile(
          {required final int id,
          required final String email,
          required final String role,
          @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
          final DateTime? createdAt,
          @JsonKey(name: 'referral_code') final String? referralCode}) =
      _$AdminProfileImpl;

  factory _AdminProfile.fromJson(Map<String, dynamic> json) =
      _$AdminProfileImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get role;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'referral_code')
  String? get referralCode;

  /// Create a copy of AdminProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminProfileImplCopyWith<_$AdminProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
