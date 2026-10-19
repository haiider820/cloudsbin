// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_create_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServerCreateResult _$ServerCreateResultFromJson(Map<String, dynamic> json) {
  return _ServerCreateResult.fromJson(json);
}

/// @nodoc
mixin _$ServerCreateResult {
  @JsonKey(name: 'server_id')
  int get serverId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_request_id')
  int? get paymentRequestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'plan_name')
  String? get planName => throw _privateConstructorUsedError;
  @JsonKey(name: 'price_cents')
  int? get priceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_cents')
  int? get totalCents => throw _privateConstructorUsedError;
  bool? get autoscale => throw _privateConstructorUsedError;

  /// Serializes this ServerCreateResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerCreateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerCreateResultCopyWith<ServerCreateResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerCreateResultCopyWith<$Res> {
  factory $ServerCreateResultCopyWith(
          ServerCreateResult value, $Res Function(ServerCreateResult) then) =
      _$ServerCreateResultCopyWithImpl<$Res, ServerCreateResult>;
  @useResult
  $Res call(
      {@JsonKey(name: 'server_id') int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'payment_request_id') int? paymentRequestId,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'price_cents') int? priceCents,
      @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
      @JsonKey(name: 'total_cents') int? totalCents,
      bool? autoscale});
}

/// @nodoc
class _$ServerCreateResultCopyWithImpl<$Res, $Val extends ServerCreateResult>
    implements $ServerCreateResultCopyWith<$Res> {
  _$ServerCreateResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerCreateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = null,
    Object? paymentRequestId = freezed,
    Object? planName = freezed,
    Object? priceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? totalCents = freezed,
    Object? autoscale = freezed,
  }) {
    return _then(_value.copyWith(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      paymentRequestId: freezed == paymentRequestId
          ? _value.paymentRequestId
          : paymentRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: freezed == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      autoscale: freezed == autoscale
          ? _value.autoscale
          : autoscale // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerCreateResultImplCopyWith<$Res>
    implements $ServerCreateResultCopyWith<$Res> {
  factory _$$ServerCreateResultImplCopyWith(_$ServerCreateResultImpl value,
          $Res Function(_$ServerCreateResultImpl) then) =
      __$$ServerCreateResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'server_id') int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      ServerStatus status,
      @JsonKey(name: 'payment_request_id') int? paymentRequestId,
      @JsonKey(name: 'plan_name') String? planName,
      @JsonKey(name: 'price_cents') int? priceCents,
      @JsonKey(name: 'eip_price_cents') int? eipPriceCents,
      @JsonKey(name: 'total_cents') int? totalCents,
      bool? autoscale});
}

/// @nodoc
class __$$ServerCreateResultImplCopyWithImpl<$Res>
    extends _$ServerCreateResultCopyWithImpl<$Res, _$ServerCreateResultImpl>
    implements _$$ServerCreateResultImplCopyWith<$Res> {
  __$$ServerCreateResultImplCopyWithImpl(_$ServerCreateResultImpl _value,
      $Res Function(_$ServerCreateResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerCreateResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serverId = null,
    Object? status = null,
    Object? paymentRequestId = freezed,
    Object? planName = freezed,
    Object? priceCents = freezed,
    Object? eipPriceCents = freezed,
    Object? totalCents = freezed,
    Object? autoscale = freezed,
  }) {
    return _then(_$ServerCreateResultImpl(
      serverId: null == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ServerStatus,
      paymentRequestId: freezed == paymentRequestId
          ? _value.paymentRequestId
          : paymentRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      planName: freezed == planName
          ? _value.planName
          : planName // ignore: cast_nullable_to_non_nullable
              as String?,
      priceCents: freezed == priceCents
          ? _value.priceCents
          : priceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      eipPriceCents: freezed == eipPriceCents
          ? _value.eipPriceCents
          : eipPriceCents // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: freezed == totalCents
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      autoscale: freezed == autoscale
          ? _value.autoscale
          : autoscale // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerCreateResultImpl implements _ServerCreateResult {
  const _$ServerCreateResultImpl(
      {@JsonKey(name: 'server_id') required this.serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      required this.status,
      @JsonKey(name: 'payment_request_id') this.paymentRequestId,
      @JsonKey(name: 'plan_name') this.planName,
      @JsonKey(name: 'price_cents') this.priceCents,
      @JsonKey(name: 'eip_price_cents') this.eipPriceCents,
      @JsonKey(name: 'total_cents') this.totalCents,
      this.autoscale});

  factory _$ServerCreateResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerCreateResultImplFromJson(json);

  @override
  @JsonKey(name: 'server_id')
  final int serverId;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  final ServerStatus status;
  @override
  @JsonKey(name: 'payment_request_id')
  final int? paymentRequestId;
  @override
  @JsonKey(name: 'plan_name')
  final String? planName;
  @override
  @JsonKey(name: 'price_cents')
  final int? priceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  final int? eipPriceCents;
  @override
  @JsonKey(name: 'total_cents')
  final int? totalCents;
  @override
  final bool? autoscale;

  @override
  String toString() {
    return 'ServerCreateResult(serverId: $serverId, status: $status, paymentRequestId: $paymentRequestId, planName: $planName, priceCents: $priceCents, eipPriceCents: $eipPriceCents, totalCents: $totalCents, autoscale: $autoscale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerCreateResultImpl &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentRequestId, paymentRequestId) ||
                other.paymentRequestId == paymentRequestId) &&
            (identical(other.planName, planName) ||
                other.planName == planName) &&
            (identical(other.priceCents, priceCents) ||
                other.priceCents == priceCents) &&
            (identical(other.eipPriceCents, eipPriceCents) ||
                other.eipPriceCents == eipPriceCents) &&
            (identical(other.totalCents, totalCents) ||
                other.totalCents == totalCents) &&
            (identical(other.autoscale, autoscale) ||
                other.autoscale == autoscale));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      serverId,
      status,
      paymentRequestId,
      planName,
      priceCents,
      eipPriceCents,
      totalCents,
      autoscale);

  /// Create a copy of ServerCreateResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerCreateResultImplCopyWith<_$ServerCreateResultImpl> get copyWith =>
      __$$ServerCreateResultImplCopyWithImpl<_$ServerCreateResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerCreateResultImplToJson(
      this,
    );
  }
}

abstract class _ServerCreateResult implements ServerCreateResult {
  const factory _ServerCreateResult(
      {@JsonKey(name: 'server_id') required final int serverId,
      @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
      required final ServerStatus status,
      @JsonKey(name: 'payment_request_id') final int? paymentRequestId,
      @JsonKey(name: 'plan_name') final String? planName,
      @JsonKey(name: 'price_cents') final int? priceCents,
      @JsonKey(name: 'eip_price_cents') final int? eipPriceCents,
      @JsonKey(name: 'total_cents') final int? totalCents,
      final bool? autoscale}) = _$ServerCreateResultImpl;

  factory _ServerCreateResult.fromJson(Map<String, dynamic> json) =
      _$ServerCreateResultImpl.fromJson;

  @override
  @JsonKey(name: 'server_id')
  int get serverId;
  @override
  @JsonKey(fromJson: ServerStatus.fromJson, toJson: ServerStatus.toJson)
  ServerStatus get status;
  @override
  @JsonKey(name: 'payment_request_id')
  int? get paymentRequestId;
  @override
  @JsonKey(name: 'plan_name')
  String? get planName;
  @override
  @JsonKey(name: 'price_cents')
  int? get priceCents;
  @override
  @JsonKey(name: 'eip_price_cents')
  int? get eipPriceCents;
  @override
  @JsonKey(name: 'total_cents')
  int? get totalCents;
  @override
  bool? get autoscale;

  /// Create a copy of ServerCreateResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerCreateResultImplCopyWith<_$ServerCreateResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
