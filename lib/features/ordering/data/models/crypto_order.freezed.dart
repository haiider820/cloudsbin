// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crypto_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CryptoOrder _$CryptoOrderFromJson(Map<String, dynamic> json) {
  return _CryptoOrder.fromJson(json);
}

/// @nodoc
mixin _$CryptoOrder {
  @JsonKey(name: 'order_id')
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_address')
  String? get walletAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_requested')
  String? get amountRequested => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_received')
  String? get amountReceived => throw _privateConstructorUsedError;
  @JsonKey(name: 'tx_hash')
  String? get txHash => throw _privateConstructorUsedError;
  @JsonKey(name: 'tx_url')
  String? get txUrl => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: CryptoPaymentStatus.fromJson,
      toJson: CryptoPaymentStatus.toJson)
  CryptoPaymentStatus get status => throw _privateConstructorUsedError;
  String? get asset => throw _privateConstructorUsedError;
  String? get chain => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  @JsonKey(name: 'network_name')
  String? get networkName => throw _privateConstructorUsedError;
  String? get explorer => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_symbol')
  String? get tokenSymbol => throw _privateConstructorUsedError;
  int? get decimals => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get verifiedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_expired')
  bool? get isExpired => throw _privateConstructorUsedError;
  @JsonKey(name: 'seconds_left')
  int? get secondsLeft => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_request_id')
  int? get paymentRequestId => throw _privateConstructorUsedError;
  @JsonKey(name: 'provision_status')
  String? get provisionStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'server_id')
  int? get serverId => throw _privateConstructorUsedError;

  /// Serializes this CryptoOrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CryptoOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoOrderCopyWith<CryptoOrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoOrderCopyWith<$Res> {
  factory $CryptoOrderCopyWith(
          CryptoOrder value, $Res Function(CryptoOrder) then) =
      _$CryptoOrderCopyWithImpl<$Res, CryptoOrder>;
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'wallet_address') String? walletAddress,
      @JsonKey(name: 'amount_requested') String? amountRequested,
      @JsonKey(name: 'amount_received') String? amountReceived,
      @JsonKey(name: 'tx_hash') String? txHash,
      @JsonKey(name: 'tx_url') String? txUrl,
      @JsonKey(
          fromJson: CryptoPaymentStatus.fromJson,
          toJson: CryptoPaymentStatus.toJson)
      CryptoPaymentStatus status,
      String? asset,
      String? chain,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      String? explorer,
      @JsonKey(name: 'token_symbol') String? tokenSymbol,
      int? decimals,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? createdAt,
      @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? expiresAt,
      @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? verifiedAt,
      @JsonKey(name: 'is_expired') bool? isExpired,
      @JsonKey(name: 'seconds_left') int? secondsLeft,
      @JsonKey(name: 'payment_request_id') int? paymentRequestId,
      @JsonKey(name: 'provision_status') String? provisionStatus,
      @JsonKey(name: 'server_id') int? serverId});
}

/// @nodoc
class _$CryptoOrderCopyWithImpl<$Res, $Val extends CryptoOrder>
    implements $CryptoOrderCopyWith<$Res> {
  _$CryptoOrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CryptoOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? walletAddress = freezed,
    Object? amountRequested = freezed,
    Object? amountReceived = freezed,
    Object? txHash = freezed,
    Object? txUrl = freezed,
    Object? status = null,
    Object? asset = freezed,
    Object? chain = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? explorer = freezed,
    Object? tokenSymbol = freezed,
    Object? decimals = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? verifiedAt = freezed,
    Object? isExpired = freezed,
    Object? secondsLeft = freezed,
    Object? paymentRequestId = freezed,
    Object? provisionStatus = freezed,
    Object? serverId = freezed,
  }) {
    return _then(_value.copyWith(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountRequested: freezed == amountRequested
          ? _value.amountRequested
          : amountRequested // ignore: cast_nullable_to_non_nullable
              as String?,
      amountReceived: freezed == amountReceived
          ? _value.amountReceived
          : amountReceived // ignore: cast_nullable_to_non_nullable
              as String?,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      txUrl: freezed == txUrl
          ? _value.txUrl
          : txUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CryptoPaymentStatus,
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      networkName: freezed == networkName
          ? _value.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String?,
      explorer: freezed == explorer
          ? _value.explorer
          : explorer // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenSymbol: freezed == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedAt: freezed == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isExpired: freezed == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool?,
      secondsLeft: freezed == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentRequestId: freezed == paymentRequestId
          ? _value.paymentRequestId
          : paymentRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      provisionStatus: freezed == provisionStatus
          ? _value.provisionStatus
          : provisionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CryptoOrderImplCopyWith<$Res>
    implements $CryptoOrderCopyWith<$Res> {
  factory _$$CryptoOrderImplCopyWith(
          _$CryptoOrderImpl value, $Res Function(_$CryptoOrderImpl) then) =
      __$$CryptoOrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'wallet_address') String? walletAddress,
      @JsonKey(name: 'amount_requested') String? amountRequested,
      @JsonKey(name: 'amount_received') String? amountReceived,
      @JsonKey(name: 'tx_hash') String? txHash,
      @JsonKey(name: 'tx_url') String? txUrl,
      @JsonKey(
          fromJson: CryptoPaymentStatus.fromJson,
          toJson: CryptoPaymentStatus.toJson)
      CryptoPaymentStatus status,
      String? asset,
      String? chain,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      String? explorer,
      @JsonKey(name: 'token_symbol') String? tokenSymbol,
      int? decimals,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? createdAt,
      @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? expiresAt,
      @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? verifiedAt,
      @JsonKey(name: 'is_expired') bool? isExpired,
      @JsonKey(name: 'seconds_left') int? secondsLeft,
      @JsonKey(name: 'payment_request_id') int? paymentRequestId,
      @JsonKey(name: 'provision_status') String? provisionStatus,
      @JsonKey(name: 'server_id') int? serverId});
}

/// @nodoc
class __$$CryptoOrderImplCopyWithImpl<$Res>
    extends _$CryptoOrderCopyWithImpl<$Res, _$CryptoOrderImpl>
    implements _$$CryptoOrderImplCopyWith<$Res> {
  __$$CryptoOrderImplCopyWithImpl(
      _$CryptoOrderImpl _value, $Res Function(_$CryptoOrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of CryptoOrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderId = null,
    Object? walletAddress = freezed,
    Object? amountRequested = freezed,
    Object? amountReceived = freezed,
    Object? txHash = freezed,
    Object? txUrl = freezed,
    Object? status = null,
    Object? asset = freezed,
    Object? chain = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? explorer = freezed,
    Object? tokenSymbol = freezed,
    Object? decimals = freezed,
    Object? createdAt = freezed,
    Object? expiresAt = freezed,
    Object? verifiedAt = freezed,
    Object? isExpired = freezed,
    Object? secondsLeft = freezed,
    Object? paymentRequestId = freezed,
    Object? provisionStatus = freezed,
    Object? serverId = freezed,
  }) {
    return _then(_$CryptoOrderImpl(
      orderId: null == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      amountRequested: freezed == amountRequested
          ? _value.amountRequested
          : amountRequested // ignore: cast_nullable_to_non_nullable
              as String?,
      amountReceived: freezed == amountReceived
          ? _value.amountReceived
          : amountReceived // ignore: cast_nullable_to_non_nullable
              as String?,
      txHash: freezed == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String?,
      txUrl: freezed == txUrl
          ? _value.txUrl
          : txUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CryptoPaymentStatus,
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      networkName: freezed == networkName
          ? _value.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String?,
      explorer: freezed == explorer
          ? _value.explorer
          : explorer // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenSymbol: freezed == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      verifiedAt: freezed == verifiedAt
          ? _value.verifiedAt
          : verifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isExpired: freezed == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool?,
      secondsLeft: freezed == secondsLeft
          ? _value.secondsLeft
          : secondsLeft // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentRequestId: freezed == paymentRequestId
          ? _value.paymentRequestId
          : paymentRequestId // ignore: cast_nullable_to_non_nullable
              as int?,
      provisionStatus: freezed == provisionStatus
          ? _value.provisionStatus
          : provisionStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CryptoOrderImpl implements _CryptoOrder {
  const _$CryptoOrderImpl(
      {@JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'wallet_address') this.walletAddress,
      @JsonKey(name: 'amount_requested') this.amountRequested,
      @JsonKey(name: 'amount_received') this.amountReceived,
      @JsonKey(name: 'tx_hash') this.txHash,
      @JsonKey(name: 'tx_url') this.txUrl,
      @JsonKey(
          fromJson: CryptoPaymentStatus.fromJson,
          toJson: CryptoPaymentStatus.toJson)
      required this.status,
      this.asset,
      this.chain,
      this.network,
      @JsonKey(name: 'network_name') this.networkName,
      this.explorer,
      @JsonKey(name: 'token_symbol') this.tokenSymbol,
      this.decimals,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
      this.createdAt,
      @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
      this.expiresAt,
      @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
      this.verifiedAt,
      @JsonKey(name: 'is_expired') this.isExpired,
      @JsonKey(name: 'seconds_left') this.secondsLeft,
      @JsonKey(name: 'payment_request_id') this.paymentRequestId,
      @JsonKey(name: 'provision_status') this.provisionStatus,
      @JsonKey(name: 'server_id') this.serverId});

  factory _$CryptoOrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$CryptoOrderImplFromJson(json);

  @override
  @JsonKey(name: 'order_id')
  final String orderId;
  @override
  @JsonKey(name: 'wallet_address')
  final String? walletAddress;
  @override
  @JsonKey(name: 'amount_requested')
  final String? amountRequested;
  @override
  @JsonKey(name: 'amount_received')
  final String? amountReceived;
  @override
  @JsonKey(name: 'tx_hash')
  final String? txHash;
  @override
  @JsonKey(name: 'tx_url')
  final String? txUrl;
  @override
  @JsonKey(
      fromJson: CryptoPaymentStatus.fromJson,
      toJson: CryptoPaymentStatus.toJson)
  final CryptoPaymentStatus status;
  @override
  final String? asset;
  @override
  final String? chain;
  @override
  final String? network;
  @override
  @JsonKey(name: 'network_name')
  final String? networkName;
  @override
  final String? explorer;
  @override
  @JsonKey(name: 'token_symbol')
  final String? tokenSymbol;
  @override
  final int? decimals;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
  final DateTime? createdAt;
  @override
  @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
  final DateTime? expiresAt;
  @override
  @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
  final DateTime? verifiedAt;
  @override
  @JsonKey(name: 'is_expired')
  final bool? isExpired;
  @override
  @JsonKey(name: 'seconds_left')
  final int? secondsLeft;
  @override
  @JsonKey(name: 'payment_request_id')
  final int? paymentRequestId;
  @override
  @JsonKey(name: 'provision_status')
  final String? provisionStatus;
  @override
  @JsonKey(name: 'server_id')
  final int? serverId;

  @override
  String toString() {
    return 'CryptoOrder(orderId: $orderId, walletAddress: $walletAddress, amountRequested: $amountRequested, amountReceived: $amountReceived, txHash: $txHash, txUrl: $txUrl, status: $status, asset: $asset, chain: $chain, network: $network, networkName: $networkName, explorer: $explorer, tokenSymbol: $tokenSymbol, decimals: $decimals, createdAt: $createdAt, expiresAt: $expiresAt, verifiedAt: $verifiedAt, isExpired: $isExpired, secondsLeft: $secondsLeft, paymentRequestId: $paymentRequestId, provisionStatus: $provisionStatus, serverId: $serverId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoOrderImpl &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.amountRequested, amountRequested) ||
                other.amountRequested == amountRequested) &&
            (identical(other.amountReceived, amountReceived) ||
                other.amountReceived == amountReceived) &&
            (identical(other.txHash, txHash) || other.txHash == txHash) &&
            (identical(other.txUrl, txUrl) || other.txUrl == txUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.chain, chain) || other.chain == chain) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.explorer, explorer) ||
                other.explorer == explorer) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt) &&
            (identical(other.isExpired, isExpired) ||
                other.isExpired == isExpired) &&
            (identical(other.secondsLeft, secondsLeft) ||
                other.secondsLeft == secondsLeft) &&
            (identical(other.paymentRequestId, paymentRequestId) ||
                other.paymentRequestId == paymentRequestId) &&
            (identical(other.provisionStatus, provisionStatus) ||
                other.provisionStatus == provisionStatus) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        orderId,
        walletAddress,
        amountRequested,
        amountReceived,
        txHash,
        txUrl,
        status,
        asset,
        chain,
        network,
        networkName,
        explorer,
        tokenSymbol,
        decimals,
        createdAt,
        expiresAt,
        verifiedAt,
        isExpired,
        secondsLeft,
        paymentRequestId,
        provisionStatus,
        serverId
      ]);

  /// Create a copy of CryptoOrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoOrderImplCopyWith<_$CryptoOrderImpl> get copyWith =>
      __$$CryptoOrderImplCopyWithImpl<_$CryptoOrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CryptoOrderImplToJson(
      this,
    );
  }
}

abstract class _CryptoOrder implements CryptoOrder {
  const factory _CryptoOrder(
      {@JsonKey(name: 'order_id') required final String orderId,
      @JsonKey(name: 'wallet_address') final String? walletAddress,
      @JsonKey(name: 'amount_requested') final String? amountRequested,
      @JsonKey(name: 'amount_received') final String? amountReceived,
      @JsonKey(name: 'tx_hash') final String? txHash,
      @JsonKey(name: 'tx_url') final String? txUrl,
      @JsonKey(
          fromJson: CryptoPaymentStatus.fromJson,
          toJson: CryptoPaymentStatus.toJson)
      required final CryptoPaymentStatus status,
      final String? asset,
      final String? chain,
      final String? network,
      @JsonKey(name: 'network_name') final String? networkName,
      final String? explorer,
      @JsonKey(name: 'token_symbol') final String? tokenSymbol,
      final int? decimals,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
      final DateTime? createdAt,
      @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
      final DateTime? expiresAt,
      @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
      final DateTime? verifiedAt,
      @JsonKey(name: 'is_expired') final bool? isExpired,
      @JsonKey(name: 'seconds_left') final int? secondsLeft,
      @JsonKey(name: 'payment_request_id') final int? paymentRequestId,
      @JsonKey(name: 'provision_status') final String? provisionStatus,
      @JsonKey(name: 'server_id') final int? serverId}) = _$CryptoOrderImpl;

  factory _CryptoOrder.fromJson(Map<String, dynamic> json) =
      _$CryptoOrderImpl.fromJson;

  @override
  @JsonKey(name: 'order_id')
  String get orderId;
  @override
  @JsonKey(name: 'wallet_address')
  String? get walletAddress;
  @override
  @JsonKey(name: 'amount_requested')
  String? get amountRequested;
  @override
  @JsonKey(name: 'amount_received')
  String? get amountReceived;
  @override
  @JsonKey(name: 'tx_hash')
  String? get txHash;
  @override
  @JsonKey(name: 'tx_url')
  String? get txUrl;
  @override
  @JsonKey(
      fromJson: CryptoPaymentStatus.fromJson,
      toJson: CryptoPaymentStatus.toJson)
  CryptoPaymentStatus get status;
  @override
  String? get asset;
  @override
  String? get chain;
  @override
  String? get network;
  @override
  @JsonKey(name: 'network_name')
  String? get networkName;
  @override
  String? get explorer;
  @override
  @JsonKey(name: 'token_symbol')
  String? get tokenSymbol;
  @override
  int? get decimals;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get createdAt;
  @override
  @JsonKey(name: 'expires_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get expiresAt;
  @override
  @JsonKey(name: 'verified_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get verifiedAt;
  @override
  @JsonKey(name: 'is_expired')
  bool? get isExpired;
  @override
  @JsonKey(name: 'seconds_left')
  int? get secondsLeft;
  @override
  @JsonKey(name: 'payment_request_id')
  int? get paymentRequestId;
  @override
  @JsonKey(name: 'provision_status')
  String? get provisionStatus;
  @override
  @JsonKey(name: 'server_id')
  int? get serverId;

  /// Create a copy of CryptoOrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoOrderImplCopyWith<_$CryptoOrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
