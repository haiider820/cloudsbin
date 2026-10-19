// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  PaymentRequestStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_slug')
  String? get planSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_price_cents')
  int? get planPriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cents')
  int? get totalCents => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  bool? get autoscale => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_specs')
  Map<String, dynamic>? get customSpecs => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_receipt')
  bool? get hasReceipt => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_id')
  int? get serverId => throw _privateConstructorUsedError;
  @JsonKey(
      name: 'server_status',
      fromJson: ServerStatus.fromJson,
      toJson: ServerStatus.toJson)
  ServerStatus? get serverStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_address')
  String? get ipAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_note')
  String? get adminNote => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      PaymentRequestStatus status,
      @JsonKey(name: 'plan_slug') String? planSlug,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'plan_price_cents') int? planPriceCents,
      @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
      @JsonKey(name: 'total_cents') int? totalCents,
      String? region,
      String? image,
      bool? autoscale,
      @JsonKey(name: 'custom_specs') Map<String, dynamic>? customSpecs,
      @JsonKey(name: 'has_receipt') bool? hasReceipt,
      @JsonKey(name: 'server_id') int? serverId,
      @JsonKey(
          name: 'server_status',
          fromJson: ServerStatus.fromJson,
          toJson: ServerStatus.toJson)
      ServerStatus? serverStatus,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'admin_note') String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? planSlug = freezed,
    Object? planName = freezed,
    Object? planPriceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? totalCents = freezed,
    Object? region = freezed,
    Object? image = freezed,
    Object? autoscale = freezed,
    Object? customSpecs = freezed,
    Object? hasReceipt = freezed,
    Object? serverId = freezed,
    Object? serverStatus = freezed,
    Object? ipAddress = freezed,
    Object? adminNote = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentRequestStatus,
      planSlug: freezed == planSlug
          ? _value.planSlug
          : planSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      planPriceCents: freezed == planPriceCents
          ? _value.planPriceCents
          : planPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: freezed == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      autoscale: freezed == autoscale
          ? _value.autoscale
          : autoscale // ignore: cast_nullable_to_non_nullable
              as bool?,
      customSpecs: freezed == customSpecs
          ? _value.customSpecs
          : customSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hasReceipt: freezed == hasReceipt
          ? _value.hasReceipt
          : hasReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
      serverStatus: freezed == serverStatus
          ? _value.serverStatus
          : serverStatus // ignore: cast_nullable_to_non_nullable
              as ServerStatus?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
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
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
          _$OrderItemImpl value, $Res Function(_$OrderItemImpl) then) =
      __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      PaymentRequestStatus status,
      @JsonKey(name: 'plan_slug') String? planSlug,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'plan_price_cents') int? planPriceCents,
      @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
      @JsonKey(name: 'total_cents') int? totalCents,
      String? region,
      String? image,
      bool? autoscale,
      @JsonKey(name: 'custom_specs') Map<String, dynamic>? customSpecs,
      @JsonKey(name: 'has_receipt') bool? hasReceipt,
      @JsonKey(name: 'server_id') int? serverId,
      @JsonKey(
          name: 'server_status',
          fromJson: ServerStatus.fromJson,
          toJson: ServerStatus.toJson)
      ServerStatus? serverStatus,
      @JsonKey(name: 'ip_address') String? ipAddress,
      @JsonKey(name: 'admin_note') String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
      _$OrderItemImpl _value, $Res Function(_$OrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? planSlug = freezed,
    Object? planName = freezed,
    Object? planPriceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? totalCents = freezed,
    Object? region = freezed,
    Object? image = freezed,
    Object? autoscale = freezed,
    Object? customSpecs = freezed,
    Object? hasReceipt = freezed,
    Object? serverId = freezed,
    Object? serverStatus = freezed,
    Object? ipAddress = freezed,
    Object? adminNote = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$OrderItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentRequestStatus,
      planSlug: freezed == planSlug
          ? _value.planSlug
          : planSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      planPriceCents: freezed == planPriceCents
          ? _value.planPriceCents
          : planPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: freezed == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      autoscale: freezed == autoscale
          ? _value.autoscale
          : autoscale // ignore: cast_nullable_to_non_nullable
              as bool?,
      customSpecs: freezed == customSpecs
          ? _value._customSpecs
          : customSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      hasReceipt: freezed == hasReceipt
          ? _value.hasReceipt
          : hasReceipt // ignore: cast_nullable_to_non_nullable
              as bool?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
      serverStatus: freezed == serverStatus
          ? _value.serverStatus
          : serverStatus // ignore: cast_nullable_to_non_nullable
              as ServerStatus?,
      ipAddress: freezed == ipAddress
          ? _value.ipAddress
          : ipAddress // ignore: cast_nullable_to_non_nullable
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
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl(
      {required this.id,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      required this.status,
      @JsonKey(name: 'plan_slug') this.planSlug,
      @JsonKey(name: 'plan_name') this.planName,
      @JsonKey(name: 'plan_price_cents') this.planPriceCents,
      @JsonKey(name: 'eip_price_cents') this.eipPriceCents,
      @JsonKey(name: 'total_cents') this.totalCents,
      this.region,
      this.image,
      this.autoscale,
      @JsonKey(name: 'custom_specs') final Map<String, dynamic>? customSpecs,
      @JsonKey(name: 'has_receipt') this.hasReceipt,
      @JsonKey(name: 'server_id') this.serverId,
      @JsonKey(
          name: 'server_status',
          fromJson: ServerStatus.fromJson,
          toJson: ServerStatus.toJson)
      this.serverStatus,
      @JsonKey(name: 'ip_address') this.ipAddress,
      @JsonKey(name: 'admin_note') this.adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt})
      : _customSpecs = customSpecs;

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  final PaymentRequestStatus status;
  @override
  @JsonKey(name: 'plan_slug')
  final String? planSlug;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'plan_price_cents')
  final int? planPriceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  final int? eipPriceCents;
  @override
  @JsonKey(name: 'total_cents')
  final int? totalCents;
  @override
  final String? region;
  @override
  final String? image;
  @override
  final bool? autoscale;
  final Map<String, dynamic>? _customSpecs;
  @override
  @JsonKey(name: 'custom_specs')
  Map<String, dynamic>? get customSpecs {
    final value = _customSpecs;
    if (value == null) return null;
    if (_customSpecs is EqualUnmodifiableMapView) return _customSpecs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'has_receipt')
  final bool? hasReceipt;
  @override
  @JsonKey(name: 'server_id')
  final int? serverId;
  @override
  @JsonKey(
      name: 'server_status',
      fromJson: ServerStatus.fromJson,
      toJson: ServerStatus.toJson)
  final ServerStatus? serverStatus;
  @override
  @JsonKey(name: 'ip_address')
  final String? ipAddress;
  @override
  @JsonKey(name: 'admin_note')
  final String? adminNote;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'OrderItem(id: $id, status: $status, planSlug: $planSlug, planName: $planName, planPriceCents: $planPriceCents, eipPriceCents: $eipPriceCents, totalCents: $totalCents, region: $region, image: $image, autoscale: $autoscale, customSpecs: $customSpecs, hasReceipt: $hasReceipt, serverId: $serverId, serverStatus: $serverStatus, ipAddress: $ipAddress, adminNote: $adminNote, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.planSlug, planSlug) ||
                other.planSlug == planSlug) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.planPriceCents, planPriceCents) ||
                other.planPriceCents == planPriceCents) &&
            (identical(other.eipPriceCents, eipPriceCents) ||
                other.eipPriceCents == eipPriceCents) &&
            (identical(other.totalCents, totalCents) ||
                other.totalCents == totalCents) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.autoscale, autoscale) ||
                other.autoscale == autoscale) &&
            const DeepCollectionEquality()
                .equals(other._customSpecs, _customSpecs) &&
            (identical(other.hasReceipt, hasReceipt) ||
                other.hasReceipt == hasReceipt) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.serverStatus, serverStatus) ||
                other.serverStatus == serverStatus) &&
            (identical(other.ipAddress, ipAddress) ||
                other.ipAddress == ipAddress) &&
            (identical(other.adminNote, adminNote) ||
                other.adminNote == adminNote) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      planSlug,
      planName,
      planPriceCents,
      eipPriceCents,
      totalCents,
      region,
      image,
      autoscale,
      const DeepCollectionEquality().hash(_customSpecs),
      hasReceipt,
      serverId,
      serverStatus,
      ipAddress,
      adminNote,
      createdAt);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(
      this,
    );
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem(
      {required final int id,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      required final PaymentRequestStatus status,
      @JsonKey(name: 'plan_slug') final String? planSlug,
      @JsonKey(name: 'plan_name') final String? planName,
      @JsonKey(name: 'plan_price_cents') final int? planPriceCents,
      @JsonKey(name: 'eip_price_cents') final int? eipPriceCents,
      @JsonKey(name: 'total_cents') final int? totalCents,
      final String? region,
      final String? image,
      final bool? autoscale,
      @JsonKey(name: 'custom_specs') final Map<String, dynamic>? customSpecs,
      @JsonKey(name: 'has_receipt') final bool? hasReceipt,
      @JsonKey(name: 'server_id') final int? serverId,
      @JsonKey(
          name: 'server_status',
          fromJson: ServerStatus.fromJson,
          toJson: ServerStatus.toJson)
      final ServerStatus? serverStatus,
      @JsonKey(name: 'ip_address') final String? ipAddress,
      @JsonKey(name: 'admin_note') final String? adminNote,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  PaymentRequestStatus get status;
  @override
  @JsonKey(name: 'plan_slug')
  String? get planSlug;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'plan_price_cents')
  int? get planPriceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents;
  @override
  @JsonKey(name: 'total_cents')
  int? get totalCents;
  @override
  String? get region;
  @override
  String? get image;
  @override
  bool? get autoscale;
  @override
  @JsonKey(name: 'custom_specs')
  Map<String, dynamic>? get customSpecs;
  @override
  @JsonKey(name: 'has_receipt')
  bool? get hasReceipt;
  @override
  @JsonKey(name: 'server_id')
  int? get serverId;
  @override
  @JsonKey(
      name: 'server_status',
      fromJson: ServerStatus.fromJson,
      toJson: ServerStatus.toJson)
  ServerStatus? get serverStatus;
  @override
  @JsonKey(name: 'ip_address')
  String? get ipAddress;
  @override
  @JsonKey(name: 'admin_note')
  String? get adminNote;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReceiptResult _$ReceiptResultFromJson(Map<String, dynamic> json) {
  return _ReceiptResult.fromJson(json);
}

/// @nodoc
mixin _$ReceiptResult {
  @JsonKey(name: 'request_id')
  int get requestId => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  PaymentRequestStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ReceiptResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceiptResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceiptResultCopyWith<ReceiptResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiptResultCopyWith<$Res> {
  factory $ReceiptResultCopyWith(
          ReceiptResult value, $Res Function(ReceiptResult) then) =
      _$ReceiptResultCopyWithImpl<$Res, ReceiptResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'request_id') int requestId,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      PaymentRequestStatus status});
}

/// @nodoc
class _$ReceiptResultCopyWithImpl<$Res, $Val extends ReceiptResult>
    implements $ReceiptResultCopyWith<$Res> {
  _$ReceiptResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceiptResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentRequestStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiptResultImplCopyWith<$Res>
    implements $ReceiptResultCopyWith<$Res> {
  factory _$$ReceiptResultImplCopyWith(
          _$ReceiptResultImpl value, $Res Function(_$ReceiptResultImpl) then) =
      __$$ReceiptResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'request_id') int requestId,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      PaymentRequestStatus status});
}

/// @nodoc
class __$$ReceiptResultImplCopyWithImpl<$Res>
    extends _$ReceiptResultCopyWithImpl<$Res, _$ReceiptResultImpl>
    implements _$$ReceiptResultImplCopyWith<$Res> {
  __$$ReceiptResultImplCopyWithImpl(
      _$ReceiptResultImpl _value, $Res Function(_$ReceiptResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReceiptResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? status = null,
  }) {
    return _then(_$ReceiptResultImpl(
      requestId: null == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentRequestStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReceiptResultImpl implements _ReceiptResult {
  const _$ReceiptResultImpl(
      {@JsonKey(name: 'request_id') required this.requestId,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      required this.status});

  factory _$ReceiptResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiptResultImplFromJson(json);

  @override
  @JsonKey(name: 'request_id')
  final int requestId;
  @override
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  final PaymentRequestStatus status;

  @override
  String toString() {
    return 'ReceiptResult(requestId: $requestId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiptResultImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, requestId, status);

  /// Create a copy of ReceiptResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiptResultImplCopyWith<_$ReceiptResultImpl> get copyWith =>
      __$$ReceiptResultImplCopyWithImpl<_$ReceiptResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiptResultImplToJson(
      this,
    );
  }
}

abstract class _ReceiptResult implements ReceiptResult {
  const factory _ReceiptResult(
      {@JsonKey(name: 'request_id') required final int requestId,
      @JsonKey(
          fromJson: PaymentRequestStatus.fromJson,
          toJson: PaymentRequestStatus.toJson)
      required final PaymentRequestStatus status}) = _$ReceiptResultImpl;

  factory _ReceiptResult.fromJson(Map<String, dynamic> json) =
      _$ReceiptResultImpl.fromJson;

  @override
  @JsonKey(name: 'request_id')
  int get requestId;
  @override
  @JsonKey(
      fromJson: PaymentRequestStatus.fromJson,
      toJson: PaymentRequestStatus.toJson)
  PaymentRequestStatus get status;

  /// Create a copy of ReceiptResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReceiptResultImplCopyWith<_$ReceiptResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
