// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_withdrawal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminWithdrawal _$AdminWithdrawalFromJson(Map<String, dynamic> json) {
  return _AdminWithdrawal.fromJson(json);
}

/// @nodoc
mixin _$AdminWithdrawal {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_email')
  String? get userEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_usd', fromJson: moneyString)
  String? get amountUsd => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_details')
  String? get accountDetails => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminWithdrawal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminWithdrawal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminWithdrawalCopyWith<AdminWithdrawal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminWithdrawalCopyWith<$Res> {
  factory $AdminWithdrawalCopyWith(
          AdminWithdrawal value, $Res Function(AdminWithdrawal) then) =
      _$AdminWithdrawalCopyWithImpl<$Res, AdminWithdrawal>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
      String? method,
      @JsonKey(name: 'account_details') String? accountDetails,
      String status,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$AdminWithdrawalCopyWithImpl<$Res, $Val extends AdminWithdrawal>
    implements $AdminWithdrawalCopyWith<$Res> {
  _$AdminWithdrawalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminWithdrawal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? amountUsd = freezed,
    Object? method = freezed,
    Object? accountDetails = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      amountUsd: freezed == amountUsd
          ? _value.amountUsd
          : amountUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      accountDetails: freezed == accountDetails
          ? _value.accountDetails
          : accountDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminWithdrawalImplCopyWith<$Res>
    implements $AdminWithdrawalCopyWith<$Res> {
  factory _$$AdminWithdrawalImplCopyWith(_$AdminWithdrawalImpl value,
          $Res Function(_$AdminWithdrawalImpl) then) =
      __$$AdminWithdrawalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
      String? method,
      @JsonKey(name: 'account_details') String? accountDetails,
      String status,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$AdminWithdrawalImplCopyWithImpl<$Res>
    extends _$AdminWithdrawalCopyWithImpl<$Res, _$AdminWithdrawalImpl>
    implements _$$AdminWithdrawalImplCopyWith<$Res> {
  __$$AdminWithdrawalImplCopyWithImpl(
      _$AdminWithdrawalImpl _value, $Res Function(_$AdminWithdrawalImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminWithdrawal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? amountUsd = freezed,
    Object? method = freezed,
    Object? accountDetails = freezed,
    Object? status = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminWithdrawalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      amountUsd: freezed == amountUsd
          ? _value.amountUsd
          : amountUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      accountDetails: freezed == accountDetails
          ? _value.accountDetails
          : accountDetails // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminWithdrawalImpl implements _AdminWithdrawal {
  const _$AdminWithdrawalImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_email') this.userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) this.amountUsd,
      this.method,
      @JsonKey(name: 'account_details') this.accountDetails,
      this.status = 'pending',
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$AdminWithdrawalImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminWithdrawalImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'user_email')
  final String? userEmail;
  @override
  @JsonKey(name: 'amount_usd', fromJson: moneyString)
  final String? amountUsd;
  @override
  final String? method;
  @override
  @JsonKey(name: 'account_details')
  final String? accountDetails;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminWithdrawal(id: $id, userId: $userId, userEmail: $userEmail, amountUsd: $amountUsd, method: $method, accountDetails: $accountDetails, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminWithdrawalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.amountUsd, amountUsd) ||
                other.amountUsd == amountUsd) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.accountDetails, accountDetails) ||
                other.accountDetails == accountDetails) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userEmail, amountUsd,
      method, accountDetails, status, createdAt);

  /// Create a copy of AdminWithdrawal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminWithdrawalImplCopyWith<_$AdminWithdrawalImpl> get copyWith =>
      __$$AdminWithdrawalImplCopyWithImpl<_$AdminWithdrawalImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminWithdrawalImplToJson(
      this,
    );
  }
}

abstract class _AdminWithdrawal implements AdminWithdrawal {
  const factory _AdminWithdrawal(
      {required final int id,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'user_email') final String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString)
      final String? amountUsd,
      final String? method,
      @JsonKey(name: 'account_details') final String? accountDetails,
      final String status,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$AdminWithdrawalImpl;

  factory _AdminWithdrawal.fromJson(Map<String, dynamic> json) =
      _$AdminWithdrawalImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'user_email')
  String? get userEmail;
  @override
  @JsonKey(name: 'amount_usd', fromJson: moneyString)
  String? get amountUsd;
  @override
  String? get method;
  @override
  @JsonKey(name: 'account_details')
  String? get accountDetails;
  @override
  String get status;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of AdminWithdrawal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminWithdrawalImplCopyWith<_$AdminWithdrawalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
