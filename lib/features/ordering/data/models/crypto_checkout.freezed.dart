// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crypto_checkout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CryptoCheckoutResult _$CryptoCheckoutResultFromJson(Map<String, dynamic> json) {
  return _CryptoCheckoutResult.fromJson(json);
}

/// @nodoc
mixin _$CryptoCheckoutResult {
  String? get message => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_id')
  String get orderId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wallet_address')
  String? get walletAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount_requested')
  String? get amountRequested => throw _privateConstructorUsedError;
  String? get asset => throw _privateConstructorUsedError;
  String? get chain => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_symbol')
  String? get tokenSymbol => throw _privateConstructorUsedError;
  int? get decimals => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmations_required')
  int? get confirmationsRequired => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  @JsonKey(name: 'network_name')
  String? get networkName => throw _privateConstructorUsedError;
  String? get explorer => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in_sec')
  int? get expiresInSec => throw _privateConstructorUsedError;
  @JsonKey(name: 'checkout_url')
  String? get checkoutUrl => throw _privateConstructorUsedError;

  /// Serializes this CryptoCheckoutResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CryptoCheckoutResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoCheckoutResultCopyWith<CryptoCheckoutResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoCheckoutResultCopyWith<$Res> {
  factory $CryptoCheckoutResultCopyWith(CryptoCheckoutResult value,
          $Res Function(CryptoCheckoutResult) then) =
      _$CryptoCheckoutResultCopyWithImpl<$Res, CryptoCheckoutResult>;
  @useResult
  $Res call(
      {String? message,
      int? id,
      @JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'wallet_address') String? walletAddress,
      @JsonKey(name: 'amount_requested') String? amountRequested,
      String? asset,
      String? chain,
      @JsonKey(name: 'token_symbol') String? tokenSymbol,
      int? decimals,
      @JsonKey(name: 'confirmations_required') int? confirmationsRequired,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      String? explorer,
      @JsonKey(name: 'expires_in_sec') int? expiresInSec,
      @JsonKey(name: 'checkout_url') String? checkoutUrl});
}

/// @nodoc
class _$CryptoCheckoutResultCopyWithImpl<$Res,
        $Val extends CryptoCheckoutResult>
    implements $CryptoCheckoutResultCopyWith<$Res> {
  _$CryptoCheckoutResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CryptoCheckoutResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? id = freezed,
    Object? orderId = null,
    Object? walletAddress = freezed,
    Object? amountRequested = freezed,
    Object? asset = freezed,
    Object? chain = freezed,
    Object? tokenSymbol = freezed,
    Object? decimals = freezed,
    Object? confirmationsRequired = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? explorer = freezed,
    Object? expiresInSec = freezed,
    Object? checkoutUrl = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenSymbol: freezed == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      confirmationsRequired: freezed == confirmationsRequired
          ? _value.confirmationsRequired
          : confirmationsRequired // ignore: cast_nullable_to_non_nullable
              as int?,
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
      expiresInSec: freezed == expiresInSec
          ? _value.expiresInSec
          : expiresInSec // ignore: cast_nullable_to_non_nullable
              as int?,
      checkoutUrl: freezed == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CryptoCheckoutResultImplCopyWith<$Res>
    implements $CryptoCheckoutResultCopyWith<$Res> {
  factory _$$CryptoCheckoutResultImplCopyWith(_$CryptoCheckoutResultImpl value,
          $Res Function(_$CryptoCheckoutResultImpl) then) =
      __$$CryptoCheckoutResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      int? id,
      @JsonKey(name: 'order_id') String orderId,
      @JsonKey(name: 'wallet_address') String? walletAddress,
      @JsonKey(name: 'amount_requested') String? amountRequested,
      String? asset,
      String? chain,
      @JsonKey(name: 'token_symbol') String? tokenSymbol,
      int? decimals,
      @JsonKey(name: 'confirmations_required') int? confirmationsRequired,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      String? explorer,
      @JsonKey(name: 'expires_in_sec') int? expiresInSec,
      @JsonKey(name: 'checkout_url') String? checkoutUrl});
}

/// @nodoc
class __$$CryptoCheckoutResultImplCopyWithImpl<$Res>
    extends _$CryptoCheckoutResultCopyWithImpl<$Res, _$CryptoCheckoutResultImpl>
    implements _$$CryptoCheckoutResultImplCopyWith<$Res> {
  __$$CryptoCheckoutResultImplCopyWithImpl(_$CryptoCheckoutResultImpl _value,
      $Res Function(_$CryptoCheckoutResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of CryptoCheckoutResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? id = freezed,
    Object? orderId = null,
    Object? walletAddress = freezed,
    Object? amountRequested = freezed,
    Object? asset = freezed,
    Object? chain = freezed,
    Object? tokenSymbol = freezed,
    Object? decimals = freezed,
    Object? confirmationsRequired = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? explorer = freezed,
    Object? expiresInSec = freezed,
    Object? checkoutUrl = freezed,
  }) {
    return _then(_$CryptoCheckoutResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      asset: freezed == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String?,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenSymbol: freezed == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      confirmationsRequired: freezed == confirmationsRequired
          ? _value.confirmationsRequired
          : confirmationsRequired // ignore: cast_nullable_to_non_nullable
              as int?,
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
      expiresInSec: freezed == expiresInSec
          ? _value.expiresInSec
          : expiresInSec // ignore: cast_nullable_to_non_nullable
              as int?,
      checkoutUrl: freezed == checkoutUrl
          ? _value.checkoutUrl
          : checkoutUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CryptoCheckoutResultImpl implements _CryptoCheckoutResult {
  const _$CryptoCheckoutResultImpl(
      {this.message,
      this.id,
      @JsonKey(name: 'order_id') required this.orderId,
      @JsonKey(name: 'wallet_address') this.walletAddress,
      @JsonKey(name: 'amount_requested') this.amountRequested,
      this.asset,
      this.chain,
      @JsonKey(name: 'token_symbol') this.tokenSymbol,
      this.decimals,
      @JsonKey(name: 'confirmations_required') this.confirmationsRequired,
      this.network,
      @JsonKey(name: 'network_name') this.networkName,
      this.explorer,
      @JsonKey(name: 'expires_in_sec') this.expiresInSec,
      @JsonKey(name: 'checkout_url') this.checkoutUrl});

  factory _$CryptoCheckoutResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$CryptoCheckoutResultImplFromJson(json);

  @override
  final String? message;
  @override
  final int? id;
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
  final String? asset;
  @override
  final String? chain;
  @override
  @JsonKey(name: 'token_symbol')
  final String? tokenSymbol;
  @override
  final int? decimals;
  @override
  @JsonKey(name: 'confirmations_required')
  final int? confirmationsRequired;
  @override
  final String? network;
  @override
  @JsonKey(name: 'network_name')
  final String? networkName;
  @override
  final String? explorer;
  @override
  @JsonKey(name: 'expires_in_sec')
  final int? expiresInSec;
  @override
  @JsonKey(name: 'checkout_url')
  final String? checkoutUrl;

  @override
  String toString() {
    return 'CryptoCheckoutResult(message: $message, id: $id, orderId: $orderId, walletAddress: $walletAddress, amountRequested: $amountRequested, asset: $asset, chain: $chain, tokenSymbol: $tokenSymbol, decimals: $decimals, confirmationsRequired: $confirmationsRequired, network: $network, networkName: $networkName, explorer: $explorer, expiresInSec: $expiresInSec, checkoutUrl: $checkoutUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoCheckoutResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.amountRequested, amountRequested) ||
                other.amountRequested == amountRequested) &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.chain, chain) || other.chain == chain) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.confirmationsRequired, confirmationsRequired) ||
                other.confirmationsRequired == confirmationsRequired) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.explorer, explorer) ||
                other.explorer == explorer) &&
            (identical(other.expiresInSec, expiresInSec) ||
                other.expiresInSec == expiresInSec) &&
            (identical(other.checkoutUrl, checkoutUrl) ||
                other.checkoutUrl == checkoutUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      message,
      id,
      orderId,
      walletAddress,
      amountRequested,
      asset,
      chain,
      tokenSymbol,
      decimals,
      confirmationsRequired,
      network,
      networkName,
      explorer,
      expiresInSec,
      checkoutUrl);

  /// Create a copy of CryptoCheckoutResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoCheckoutResultImplCopyWith<_$CryptoCheckoutResultImpl>
      get copyWith =>
          __$$CryptoCheckoutResultImplCopyWithImpl<_$CryptoCheckoutResultImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CryptoCheckoutResultImplToJson(
      this,
    );
  }
}

abstract class _CryptoCheckoutResult implements CryptoCheckoutResult {
  const factory _CryptoCheckoutResult(
      {final String? message,
      final int? id,
      @JsonKey(name: 'order_id') required final String orderId,
      @JsonKey(name: 'wallet_address') final String? walletAddress,
      @JsonKey(name: 'amount_requested') final String? amountRequested,
      final String? asset,
      final String? chain,
      @JsonKey(name: 'token_symbol') final String? tokenSymbol,
      final int? decimals,
      @JsonKey(name: 'confirmations_required') final int? confirmationsRequired,
      final String? network,
      @JsonKey(name: 'network_name') final String? networkName,
      final String? explorer,
      @JsonKey(name: 'expires_in_sec') final int? expiresInSec,
      @JsonKey(name: 'checkout_url')
      final String? checkoutUrl}) = _$CryptoCheckoutResultImpl;

  factory _CryptoCheckoutResult.fromJson(Map<String, dynamic> json) =
      _$CryptoCheckoutResultImpl.fromJson;

  @override
  String? get message;
  @override
  int? get id;
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
  String? get asset;
  @override
  String? get chain;
  @override
  @JsonKey(name: 'token_symbol')
  String? get tokenSymbol;
  @override
  int? get decimals;
  @override
  @JsonKey(name: 'confirmations_required')
  int? get confirmationsRequired;
  @override
  String? get network;
  @override
  @JsonKey(name: 'network_name')
  String? get networkName;
  @override
  String? get explorer;
  @override
  @JsonKey(name: 'expires_in_sec')
  int? get expiresInSec;
  @override
  @JsonKey(name: 'checkout_url')
  String? get checkoutUrl;

  /// Create a copy of CryptoCheckoutResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoCheckoutResultImplCopyWith<_$CryptoCheckoutResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
