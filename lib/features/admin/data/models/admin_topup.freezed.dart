// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_topup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminTopup _$AdminTopupFromJson(Map<String, dynamic> json) {
  return _AdminTopup.fromJson(json);
}

/// @nodoc
mixin _$AdminTopup {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_email')
  String? get userEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_usd', fromJson: moneyString)
  String? get amountUsd => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'receipt_url')
  String? get receiptUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminTopup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminTopup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminTopupCopyWith<AdminTopup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminTopupCopyWith<$Res> {
  factory $AdminTopupCopyWith(
          AdminTopup value, $Res Function(AdminTopup) then) =
      _$AdminTopupCopyWithImpl<$Res, AdminTopup>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
      String? method,
      String status,
      @JsonKey(name: 'receipt_url') String? receiptUrl,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$AdminTopupCopyWithImpl<$Res, $Val extends AdminTopup>
    implements $AdminTopupCopyWith<$Res> {
  _$AdminTopupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminTopup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? amountUsd = freezed,
    Object? method = freezed,
    Object? status = null,
    Object? receiptUrl = freezed,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminTopupImplCopyWith<$Res>
    implements $AdminTopupCopyWith<$Res> {
  factory _$$AdminTopupImplCopyWith(
          _$AdminTopupImpl value, $Res Function(_$AdminTopupImpl) then) =
      __$$AdminTopupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) String? amountUsd,
      String? method,
      String status,
      @JsonKey(name: 'receipt_url') String? receiptUrl,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$AdminTopupImplCopyWithImpl<$Res>
    extends _$AdminTopupCopyWithImpl<$Res, _$AdminTopupImpl>
    implements _$$AdminTopupImplCopyWith<$Res> {
  __$$AdminTopupImplCopyWithImpl(
      _$AdminTopupImpl _value, $Res Function(_$AdminTopupImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminTopup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? amountUsd = freezed,
    Object? method = freezed,
    Object? status = null,
    Object? receiptUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminTopupImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminTopupImpl implements _AdminTopup {
  const _$AdminTopupImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_email') this.userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString) this.amountUsd,
      this.method,
      this.status = 'pending',
      @JsonKey(name: 'receipt_url') this.receiptUrl,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$AdminTopupImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminTopupImplFromJson(json);

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
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'receipt_url')
  final String? receiptUrl;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminTopup(id: $id, userId: $userId, userEmail: $userEmail, amountUsd: $amountUsd, method: $method, status: $status, receiptUrl: $receiptUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminTopupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.amountUsd, amountUsd) ||
                other.amountUsd == amountUsd) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userEmail, amountUsd,
      method, status, receiptUrl, createdAt);

  /// Create a copy of AdminTopup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminTopupImplCopyWith<_$AdminTopupImpl> get copyWith =>
      __$$AdminTopupImplCopyWithImpl<_$AdminTopupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminTopupImplToJson(
      this,
    );
  }
}

abstract class _AdminTopup implements AdminTopup {
  const factory _AdminTopup(
      {required final int id,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'user_email') final String? userEmail,
      @JsonKey(name: 'amount_usd', fromJson: moneyString)
      final String? amountUsd,
      final String? method,
      final String status,
      @JsonKey(name: 'receipt_url') final String? receiptUrl,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$AdminTopupImpl;

  factory _AdminTopup.fromJson(Map<String, dynamic> json) =
      _$AdminTopupImpl.fromJson;

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
  String get status;
  @override
  @JsonKey(name: 'receipt_url')
  String? get receiptUrl;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of AdminTopup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminTopupImplCopyWith<_$AdminTopupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
