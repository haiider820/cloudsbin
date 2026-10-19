// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_ticket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminTicket _$AdminTicketFromJson(Map<String, dynamic> json) {
  return _AdminTicket.fromJson(json);
}

/// @nodoc
mixin _$AdminTicket {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_email')
  String? get userEmail => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastReplyAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminTicket to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminTicketCopyWith<AdminTicket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminTicketCopyWith<$Res> {
  factory $AdminTicketCopyWith(
          AdminTicket value, $Res Function(AdminTicket) then) =
      _$AdminTicketCopyWithImpl<$Res, AdminTicket>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      String subject,
      String status,
      String priority,
      @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastReplyAt,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$AdminTicketCopyWithImpl<$Res, $Val extends AdminTicket>
    implements $AdminTicketCopyWith<$Res> {
  _$AdminTicketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? subject = null,
    Object? status = null,
    Object? priority = null,
    Object? lastReplyAt = freezed,
    Object? unreadCount = null,
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
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      lastReplyAt: freezed == lastReplyAt
          ? _value.lastReplyAt
          : lastReplyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminTicketImplCopyWith<$Res>
    implements $AdminTicketCopyWith<$Res> {
  factory _$$AdminTicketImplCopyWith(
          _$AdminTicketImpl value, $Res Function(_$AdminTicketImpl) then) =
      __$$AdminTicketImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'user_email') String? userEmail,
      String subject,
      String status,
      String priority,
      @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? lastReplyAt,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$AdminTicketImplCopyWithImpl<$Res>
    extends _$AdminTicketCopyWithImpl<$Res, _$AdminTicketImpl>
    implements _$$AdminTicketImplCopyWith<$Res> {
  __$$AdminTicketImplCopyWithImpl(
      _$AdminTicketImpl _value, $Res Function(_$AdminTicketImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminTicket
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? userEmail = freezed,
    Object? subject = null,
    Object? status = null,
    Object? priority = null,
    Object? lastReplyAt = freezed,
    Object? unreadCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminTicketImpl(
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
      subject: null == subject
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      lastReplyAt: freezed == lastReplyAt
          ? _value.lastReplyAt
          : lastReplyAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: null == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminTicketImpl implements _AdminTicket {
  const _$AdminTicketImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'user_email') this.userEmail,
      this.subject = '',
      this.status = 'open',
      this.priority = 'normal',
      @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
      this.lastReplyAt,
      @JsonKey(name: 'unread_count') this.unreadCount = 0,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$AdminTicketImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminTicketImplFromJson(json);

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
  final String subject;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String priority;
  @override
  @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? lastReplyAt;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminTicket(id: $id, userId: $userId, userEmail: $userEmail, subject: $subject, status: $status, priority: $priority, lastReplyAt: $lastReplyAt, unreadCount: $unreadCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminTicketImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.lastReplyAt, lastReplyAt) ||
                other.lastReplyAt == lastReplyAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, userEmail, subject,
      status, priority, lastReplyAt, unreadCount, createdAt);

  /// Create a copy of AdminTicket
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminTicketImplCopyWith<_$AdminTicketImpl> get copyWith =>
      __$$AdminTicketImplCopyWithImpl<_$AdminTicketImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminTicketImplToJson(
      this,
    );
  }
}

abstract class _AdminTicket implements AdminTicket {
  const factory _AdminTicket(
      {required final int id,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'user_email') final String? userEmail,
      final String subject,
      final String status,
      final String priority,
      @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? lastReplyAt,
      @JsonKey(name: 'unread_count') final int unreadCount,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$AdminTicketImpl;

  factory _AdminTicket.fromJson(Map<String, dynamic> json) =
      _$AdminTicketImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'user_email')
  String? get userEmail;
  @override
  String get subject;
  @override
  String get status;
  @override
  String get priority;
  @override
  @JsonKey(name: 'last_reply_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get lastReplyAt;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of AdminTicket
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminTicketImplCopyWith<_$AdminTicketImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
