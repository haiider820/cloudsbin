// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminOrder _$AdminOrderFromJson(Map<String, dynamic> json) {
  return _AdminOrder.fromJson(json);
}

/// @nodoc
mixin _$AdminOrder {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_email')
  String? get userEmail => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cents')
  int get totalCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_receipt')
  bool get hasReceipt => throw _privateConstructorUsedError;
  @JsonKey(name: 'receipt_url')
  String? get receiptUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_note')
  String? get adminNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminOrderCopyWith<AdminOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminOrderCopyWith<$Res> {
  factory $AdminOrderCopyWith(
          AdminOrder value, $Res Function(AdminOrder) then) =
      _$AdminOrderCopyWithImpl<$Res, AdminOrder>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      String status,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'total_cents') int totalCents,
      @JsonKey(name: 'has_receipt') bool hasReceipt,
      @JsonKey(name: 'receipt_url') String? receiptUrl,
      @JsonKey(name: 'admin_note') String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$AdminOrderCopyWithImpl<$Res, $Val extends AdminOrder>
    implements $AdminOrderCopyWith<$Res> {
  _$AdminOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? status = null,
    Object? planName = freezed,
    Object? totalCents = null,
    Object? hasReceipt = null,
    Object? receiptUrl = freezed,
    Object? adminNote = freezed,
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalCents: null == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int,
      hasReceipt: null == hasReceipt
          ? _value.hasReceipt
          : hasReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminOrderImplCopyWith<$Res>
    implements $AdminOrderCopyWith<$Res> {
  factory _$$AdminOrderImplCopyWith(
          _$AdminOrderImpl value, $Res Function(_$AdminOrderImpl) then) =
      __$$AdminOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      String status,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'total_cents') int totalCents,
      @JsonKey(name: 'has_receipt') bool hasReceipt,
      @JsonKey(name: 'receipt_url') String? receiptUrl,
      @JsonKey(name: 'admin_note') String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$AdminOrderImplCopyWithImpl<$Res>
    extends _$AdminOrderCopyWithImpl<$Res, _$AdminOrderImpl>
    implements _$$AdminOrderImplCopyWith<$Res> {
  __$$AdminOrderImplCopyWithImpl(
      _$AdminOrderImpl _value, $Res Function(_$AdminOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? status = null,
    Object? planName = freezed,
    Object? totalCents = null,
    Object? hasReceipt = null,
    Object? receiptUrl = freezed,
    Object? adminNote = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminOrderImpl(
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
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalCents: null == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int,
      hasReceipt: null == hasReceipt
          ? _value.hasReceipt
          : hasReceipt // ignore: cast_nullable_to_non_nullable
              as bool,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      adminNote: freezed == adminNote
          ? _value.adminNote
          : adminNote // ignore: cast_nullable_to_non_nullable
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
class _$AdminOrderImpl implements _AdminOrder {
  const _$AdminOrderImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_email') this.userEmail,
      this.status = 'pending',
      @JsonKey(name: 'plan_name') this.planName,
      @JsonKey(name: 'total_cents') this.totalCents = 0,
      @JsonKey(name: 'has_receipt') this.hasReceipt = false,
      @JsonKey(name: 'receipt_url') this.receiptUrl,
      @JsonKey(name: 'admin_note') this.adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$AdminOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminOrderImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'user_email')
  final String? userEmail;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'total_cents')
  final int totalCents;
  @override
  @JsonKey(name: 'has_receipt')
  final bool hasReceipt;
  @override
  @JsonKey(name: 'receipt_url')
  final String? receiptUrl;
  @override
  @JsonKey(name: 'admin_note')
  final String? adminNote;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminOrder(id: $id, userId: $userId, userEmail: $userEmail, status: $status, planName: $planName, totalCents: $totalCents, hasReceipt: $hasReceipt, receiptUrl: $receiptUrl, adminNote: $adminNote, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminOrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.totalCents, totalCents) ||
                other.totalCents == totalCents) &&
            (identical(other.hasReceipt, hasReceipt) ||
                other.hasReceipt == hasReceipt) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userEmail, status,
      planName, totalCents, hasReceipt, receiptUrl, adminNote, createdAt);

  /// Create a copy of AdminOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminOrderImplCopyWith<_$AdminOrderImpl> get copyWith =>
      __$$AdminOrderImplCopyWithImpl<_$AdminOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminOrderImplToJson(
      this,
    );
  }
}

abstract class _AdminOrder implements AdminOrder {
  const factory _AdminOrder(
      {required final int id,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'user_email') final String? userEmail,
      final String status,
      @JsonKey(name: 'plan_name') final String? planName,
      @JsonKey(name: 'total_cents') final int totalCents,
      @JsonKey(name: 'has_receipt') final bool hasReceipt,
      @JsonKey(name: 'receipt_url') final String? receiptUrl,
      @JsonKey(name: 'admin_note') final String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$AdminOrderImpl;

  factory _AdminOrder.fromJson(Map<String, dynamic> json) =
      _$AdminOrderImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'user_email')
  String? get userEmail;
  @override
  String get status;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'total_cents')
  int get totalCents;
  @override
  @JsonKey(name: 'has_receipt')
  bool get hasReceipt;
  @override
  @JsonKey(name: 'receipt_url')
  String? get receiptUrl;
  @override
  @JsonKey(name: 'admin_note')
  String? get adminNote;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of AdminOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminOrderImplCopyWith<_$AdminOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
