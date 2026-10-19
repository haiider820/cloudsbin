// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_user_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminUserDetail _$AdminUserDetailFromJson(Map<String, dynamic> json) {
  return _AdminUserDetail.fromJson(json);
}

/// @nodoc
mixin _$AdminUserDetail {
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
  @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
  String? get lifetimeSpentUsd => throw _privateConstructorUsedError;
  @JsonKey(name: 'ticket_count')
  int get ticketCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'referral_code')
  String? get referralCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'referred_by_user_id')
  int? get referredByUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_login_ip')
  String? get lastLoginIp => throw _privateConstructorUsedError;

  /// Serializes this AdminUserDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminUserDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminUserDetailCopyWith<AdminUserDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminUserDetailCopyWith<$Res> {
  factory $AdminUserDetailCopyWith(
          AdminUserDetail value, $Res Function(AdminUserDetail) then) =
      _$AdminUserDetailCopyWithImpl<$Res, AdminUserDetail>;
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
      DateTime? lastLoginAt,
      @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
      String? lifetimeSpentUsd,
      @JsonKey(name: 'ticket_count') int ticketCount,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'referred_by_user_id') int? referredByUserId,
      @JsonKey(name: 'last_login_ip') String? lastLoginIp});
}

/// @nodoc
class _$AdminUserDetailCopyWithImpl<$Res, $Val extends AdminUserDetail>
    implements $AdminUserDetailCopyWith<$Res> {
  _$AdminUserDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminUserDetail
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
    Object? lifetimeSpentUsd = freezed,
    Object? ticketCount = null,
    Object? referralCode = freezed,
    Object? referredByUserId = freezed,
    Object? lastLoginIp = freezed,
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
      lifetimeSpentUsd: freezed == lifetimeSpentUsd
          ? _value.lifetimeSpentUsd
          : lifetimeSpentUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketCount: null == ticketCount
          ? _value.ticketCount
          : ticketCount // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referredByUserId: freezed == referredByUserId
          ? _value.referredByUserId
          : referredByUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastLoginIp: freezed == lastLoginIp
          ? _value.lastLoginIp
          : lastLoginIp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminUserDetailImplCopyWith<$Res>
    implements $AdminUserDetailCopyWith<$Res> {
  factory _$$AdminUserDetailImplCopyWith(_$AdminUserDetailImpl value,
          $Res Function(_$AdminUserDetailImpl) then) =
      __$$AdminUserDetailImplCopyWithImpl<$Res>;
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
      DateTime? lastLoginAt,
      @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
      String? lifetimeSpentUsd,
      @JsonKey(name: 'ticket_count') int ticketCount,
      @JsonKey(name: 'referral_code') String? referralCode,
      @JsonKey(name: 'referred_by_user_id') int? referredByUserId,
      @JsonKey(name: 'last_login_ip') String? lastLoginIp});
}

/// @nodoc
class __$$AdminUserDetailImplCopyWithImpl<$Res>
    extends _$AdminUserDetailCopyWithImpl<$Res, _$AdminUserDetailImpl>
    implements _$$AdminUserDetailImplCopyWith<$Res> {
  __$$AdminUserDetailImplCopyWithImpl(
      _$AdminUserDetailImpl _value, $Res Function(_$AdminUserDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminUserDetail
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
    Object? lifetimeSpentUsd = freezed,
    Object? ticketCount = null,
    Object? referralCode = freezed,
    Object? referredByUserId = freezed,
    Object? lastLoginIp = freezed,
  }) {
    return _then(_$AdminUserDetailImpl(
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
      lifetimeSpentUsd: freezed == lifetimeSpentUsd
          ? _value.lifetimeSpentUsd
          : lifetimeSpentUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      ticketCount: null == ticketCount
          ? _value.ticketCount
          : ticketCount // ignore: cast_nullable_to_non_nullable
              as int,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      referredByUserId: freezed == referredByUserId
          ? _value.referredByUserId
          : referredByUserId // ignore: cast_nullable_to_non_nullable
              as int?,
      lastLoginIp: freezed == lastLoginIp
          ? _value.lastLoginIp
          : lastLoginIp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminUserDetailImpl implements _AdminUserDetail {
  const _$AdminUserDetailImpl(
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
      this.lastLoginAt,
      @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
      this.lifetimeSpentUsd,
      @JsonKey(name: 'ticket_count') this.ticketCount = 0,
      @JsonKey(name: 'referral_code') this.referralCode,
      @JsonKey(name: 'referred_by_user_id') this.referredByUserId,
      @JsonKey(name: 'last_login_ip') this.lastLoginIp});

  factory _$AdminUserDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminUserDetailImplFromJson(json);

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
  @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
  final String? lifetimeSpentUsd;
  @override
  @JsonKey(name: 'ticket_count')
  final int ticketCount;
  @override
  @JsonKey(name: 'referral_code')
  final String? referralCode;
  @override
  @JsonKey(name: 'referred_by_user_id')
  final int? referredByUserId;
  @override
  @JsonKey(name: 'last_login_ip')
  final String? lastLoginIp;

  @override
  String toString() {
    return 'AdminUserDetail(id: $id, email: $email, role: $role, createdAt: $createdAt, walletBalanceUsd: $walletBalanceUsd, serverCount: $serverCount, isActive: $isActive, lastLoginAt: $lastLoginAt, lifetimeSpentUsd: $lifetimeSpentUsd, ticketCount: $ticketCount, referralCode: $referralCode, referredByUserId: $referredByUserId, lastLoginIp: $lastLoginIp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminUserDetailImpl &&
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
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.lifetimeSpentUsd, lifetimeSpentUsd) ||
                other.lifetimeSpentUsd == lifetimeSpentUsd) &&
            (identical(other.ticketCount, ticketCount) ||
                other.ticketCount == ticketCount) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referredByUserId, referredByUserId) ||
                other.referredByUserId == referredByUserId) &&
            (identical(other.lastLoginIp, lastLoginIp) ||
                other.lastLoginIp == lastLoginIp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      role,
      createdAt,
      walletBalanceUsd,
      serverCount,
      isActive,
      lastLoginAt,
      lifetimeSpentUsd,
      ticketCount,
      referralCode,
      referredByUserId,
      lastLoginIp);

  /// Create a copy of AdminUserDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminUserDetailImplCopyWith<_$AdminUserDetailImpl> get copyWith =>
      __$$AdminUserDetailImplCopyWithImpl<_$AdminUserDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminUserDetailImplToJson(
      this,
    );
  }
}

abstract class _AdminUserDetail implements AdminUserDetail {
  const factory _AdminUserDetail(
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
          final DateTime? lastLoginAt,
          @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
          final String? lifetimeSpentUsd,
          @JsonKey(name: 'ticket_count') final int ticketCount,
          @JsonKey(name: 'referral_code') final String? referralCode,
          @JsonKey(name: 'referred_by_user_id') final int? referredByUserId,
          @JsonKey(name: 'last_login_ip') final String? lastLoginIp}) =
      _$AdminUserDetailImpl;

  factory _AdminUserDetail.fromJson(Map<String, dynamic> json) =
      _$AdminUserDetailImpl.fromJson;

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
  @override
  @JsonKey(name: 'lifetime_spent_usd', fromJson: moneyString)
  String? get lifetimeSpentUsd;
  @override
  @JsonKey(name: 'ticket_count')
  int get ticketCount;
  @override
  @JsonKey(name: 'referral_code')
  String? get referralCode;
  @override
  @JsonKey(name: 'referred_by_user_id')
  int? get referredByUserId;
  @override
  @JsonKey(name: 'last_login_ip')
  String? get lastLoginIp;

  /// Create a copy of AdminUserDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminUserDetailImplCopyWith<_$AdminUserDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
