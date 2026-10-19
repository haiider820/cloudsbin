// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) {
  return _AdminUser.fromJson(json);
}

/// @nodoc
mixin _$AdminUser {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
  String? get walletBalanceUsd => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_count')
  int get serverCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this AdminUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminUserCopyWith<AdminUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminUserCopyWith<$Res> {
  factory $AdminUserCopyWith(AdminUser value, $Res Function(AdminUser) then) =
      _$AdminUserCopyWithImpl<$Res, AdminUser>;
  @useResult
  $Res call(
      {int id,
      String email,
      String role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
      String? walletBalanceUsd,
      @JsonKey(name: 'server_count') int serverCount,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastLoginAt});
}

/// @nodoc
class _$AdminUserCopyWithImpl<$Res, $Val extends AdminUser>
    implements $AdminUserCopyWith<$Res> {
  _$AdminUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? walletBalanceUsd = freezed,
    Object? serverCount = null,
    Object? isActive = null,
    Object? lastLoginAt = freezed,
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
      walletBalanceUsd: freezed == walletBalanceUsd
          ? _value.walletBalanceUsd
          : walletBalanceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      serverCount: null == serverCount
          ? _value.serverCount
          : serverCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminUserImplCopyWith<$Res>
    implements $AdminUserCopyWith<$Res> {
  factory _$$AdminUserImplCopyWith(
          _$AdminUserImpl value, $Res Function(_$AdminUserImpl) then) =
      __$$AdminUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt,
      @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
      String? walletBalanceUsd,
      @JsonKey(name: 'server_count') int serverCount,
      @JsonKey(name: 'is_active') bool isActive,
      @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastLoginAt});
}

/// @nodoc
class __$$AdminUserImplCopyWithImpl<$Res>
    extends _$AdminUserCopyWithImpl<$Res, _$AdminUserImpl>
    implements _$$AdminUserImplCopyWith<$Res> {
  __$$AdminUserImplCopyWithImpl(
      _$AdminUserImpl _value, $Res Function(_$AdminUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? role = null,
    Object? createdAt = freezed,
    Object? walletBalanceUsd = freezed,
    Object? serverCount = null,
    Object? isActive = null,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_$AdminUserImpl(
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
      walletBalanceUsd: freezed == walletBalanceUsd
          ? _value.walletBalanceUsd
          : walletBalanceUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      serverCount: null == serverCount
          ? _value.serverCount
          : serverCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminUserImpl implements _AdminUser {
  const _$AdminUserImpl(
      {required this.id,
      required this.email,
      this.role = 'user',
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt,
      @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
      this.walletBalanceUsd,
      @JsonKey(name: 'server_count') this.serverCount = 0,
      @JsonKey(name: 'is_active') this.isActive = true,
      @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
      this.lastLoginAt});

  factory _$AdminUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminUserImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  @JsonKey()
  final String role;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
  final String? walletBalanceUsd;
  @override
  @JsonKey(name: 'server_count')
  final int serverCount;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'AdminUser(id: $id, email: $email, role: $role, createdAt: $createdAt, walletBalanceUsd: $walletBalanceUsd, serverCount: $serverCount, isActive: $isActive, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.walletBalanceUsd, walletBalanceUsd) ||
                other.walletBalanceUsd == walletBalanceUsd) &&
            (identical(other.serverCount, serverCount) ||
                other.serverCount == serverCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, role, createdAt,
      walletBalanceUsd, serverCount, isActive, lastLoginAt);

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminUserImplCopyWith<_$AdminUserImpl> get copyWith =>
      __$$AdminUserImplCopyWithImpl<_$AdminUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminUserImplToJson(
      this,
    );
  }
}

abstract class _AdminUser implements AdminUser {
  const factory _AdminUser(
      {required final int id,
      required final String email,
      final String role,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt,
      @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
      final String? walletBalanceUsd,
      @JsonKey(name: 'server_count') final int serverCount,
      @JsonKey(name: 'is_active') final bool isActive,
      @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? lastLoginAt}) = _$AdminUserImpl;

  factory _AdminUser.fromJson(Map<String, dynamic> json) =
      _$AdminUserImpl.fromJson;

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
  @JsonKey(name: 'wallet_balance_usd', fromJson: moneyString)
  String? get walletBalanceUsd;
  @override
  @JsonKey(name: 'server_count')
  int get serverCount;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'last_login_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastLoginAt;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminUserImplCopyWith<_$AdminUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
