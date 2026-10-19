// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_ticket_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminTicketDetail _$AdminTicketDetailFromJson(Map<String, dynamic> json) {
  return _AdminTicketDetail.fromJson(json);
}

/// @nodoc
mixin _$AdminTicketDetail {
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
  List<AdminTicketMessage> get messages => throw _privateConstructorUsedError;

  /// Serializes this AdminTicketDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminTicketDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminTicketDetailCopyWith<AdminTicketDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminTicketDetailCopyWith<$Res> {
  factory $AdminTicketDetailCopyWith(
          AdminTicketDetail value, $Res Function(AdminTicketDetail) then) =
      _$AdminTicketDetailCopyWithImpl<$Res, AdminTicketDetail>;
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
      DateTime? createdAt,
      List<AdminTicketMessage> messages});
}

/// @nodoc
class _$AdminTicketDetailCopyWithImpl<$Res, $Val extends AdminTicketDetail>
    implements $AdminTicketDetailCopyWith<$Res> {
  _$AdminTicketDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminTicketDetail
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
    Object? messages = null,
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
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<AdminTicketMessage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminTicketDetailImplCopyWith<$Res>
    implements $AdminTicketDetailCopyWith<$Res> {
  factory _$$AdminTicketDetailImplCopyWith(_$AdminTicketDetailImpl value,
          $Res Function(_$AdminTicketDetailImpl) then) =
      __$$AdminTicketDetailImplCopyWithImpl<$Res>;
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
      DateTime? createdAt,
      List<AdminTicketMessage> messages});
}

/// @nodoc
class __$$AdminTicketDetailImplCopyWithImpl<$Res>
    extends _$AdminTicketDetailCopyWithImpl<$Res, _$AdminTicketDetailImpl>
    implements _$$AdminTicketDetailImplCopyWith<$Res> {
  __$$AdminTicketDetailImplCopyWithImpl(_$AdminTicketDetailImpl _value,
      $Res Function(_$AdminTicketDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminTicketDetail
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
    Object? messages = null,
  }) {
    return _then(_$AdminTicketDetailImpl(
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
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<AdminTicketMessage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminTicketDetailImpl implements _AdminTicketDetail {
  const _$AdminTicketDetailImpl(
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
      this.createdAt,
      final List<AdminTicketMessage> messages = const <AdminTicketMessage>[]})
      : _messages = messages;

  factory _$AdminTicketDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminTicketDetailImplFromJson(json);

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
  final List<AdminTicketMessage> _messages;
  @override
  @JsonKey()
  List<AdminTicketMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'AdminTicketDetail(id: $id, userId: $userId, userEmail: $userEmail, subject: $subject, status: $status, priority: $priority, lastReplyAt: $lastReplyAt, unreadCount: $unreadCount, createdAt: $createdAt, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminTicketDetailImpl &&
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
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      userEmail,
      subject,
      status,
      priority,
      lastReplyAt,
      unreadCount,
      createdAt,
      const DeepCollectionEquality().hash(_messages));

  /// Create a copy of AdminTicketDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminTicketDetailImplCopyWith<_$AdminTicketDetailImpl> get copyWith =>
      __$$AdminTicketDetailImplCopyWithImpl<_$AdminTicketDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminTicketDetailImplToJson(
      this,
    );
  }
}

abstract class _AdminTicketDetail implements AdminTicketDetail {
  const factory _AdminTicketDetail(
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
      final DateTime? createdAt,
      final List<AdminTicketMessage> messages}) = _$AdminTicketDetailImpl;

  factory _AdminTicketDetail.fromJson(Map<String, dynamic> json) =
      _$AdminTicketDetailImpl.fromJson;

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
  @override
  List<AdminTicketMessage> get messages;

  /// Create a copy of AdminTicketDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminTicketDetailImplCopyWith<_$AdminTicketDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminTicketMessage _$AdminTicketMessageFromJson(Map<String, dynamic> json) {
  return _AdminTicketMessage.fromJson(json);
}

/// @nodoc
mixin _$AdminTicketMessage {
  int get id => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminTicketMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminTicketMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminTicketMessageCopyWith<AdminTicketMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminTicketMessageCopyWith<$Res> {
  factory $AdminTicketMessageCopyWith(
          AdminTicketMessage value, $Res Function(AdminTicketMessage) then) =
      _$AdminTicketMessageCopyWithImpl<$Res, AdminTicketMessage>;
  @useResult
  $Res call(
      {int id,
      String sender,
      String message,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$AdminTicketMessageCopyWithImpl<$Res, $Val extends AdminTicketMessage>
    implements $AdminTicketMessageCopyWith<$Res> {
  _$AdminTicketMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminTicketMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? message = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminTicketMessageImplCopyWith<$Res>
    implements $AdminTicketMessageCopyWith<$Res> {
  factory _$$AdminTicketMessageImplCopyWith(_$AdminTicketMessageImpl value,
          $Res Function(_$AdminTicketMessageImpl) then) =
      __$$AdminTicketMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String sender,
      String message,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$AdminTicketMessageImplCopyWithImpl<$Res>
    extends _$AdminTicketMessageCopyWithImpl<$Res, _$AdminTicketMessageImpl>
    implements _$$AdminTicketMessageImplCopyWith<$Res> {
  __$$AdminTicketMessageImplCopyWithImpl(_$AdminTicketMessageImpl _value,
      $Res Function(_$AdminTicketMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminTicketMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? message = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminTicketMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$AdminTicketMessageImpl implements _AdminTicketMessage {
  const _$AdminTicketMessageImpl(
      {required this.id,
      this.sender = 'user',
      this.message = '',
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$AdminTicketMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminTicketMessageImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String sender;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminTicketMessage(id: $id, sender: $sender, message: $message, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminTicketMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, sender, message, createdAt);

  /// Create a copy of AdminTicketMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminTicketMessageImplCopyWith<_$AdminTicketMessageImpl> get copyWith =>
      __$$AdminTicketMessageImplCopyWithImpl<_$AdminTicketMessageImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminTicketMessageImplToJson(
      this,
    );
  }
}

abstract class _AdminTicketMessage implements AdminTicketMessage {
  const factory _AdminTicketMessage(
      {required final int id,
      final String sender,
      final String message,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$AdminTicketMessageImpl;

  factory _AdminTicketMessage.fromJson(Map<String, dynamic> json) =
      _$AdminTicketMessageImpl.fromJson;

  @override
  int get id;
  @override
  String get sender;
  @override
  String get message;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of AdminTicketMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminTicketMessageImplCopyWith<_$AdminTicketMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
