// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_checkout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoCheckoutResultImpl _$$CryptoCheckoutResultImplFromJson(
        Map<String, dynamic> json) =>
    _$CryptoCheckoutResultImpl(
      message: json['message'] as String?,
      id: (json['id'] as num?)?.toInt(),
      orderId: json['order_id'] as String,
      walletAddress: json['wallet_address'] as String?,
      amountRequested: json['amount_requested'] as String?,
      asset: json['asset'] as String?,
      chain: json['chain'] as String?,
      tokenSymbol: json['token_symbol'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      confirmationsRequired: (json['confirmations_required'] as num?)?.toInt(),
      network: json['network'] as String?,
      networkName: json['network_name'] as String?,
      explorer: json['explorer'] as String?,
      expiresInSec: (json['expires_in_sec'] as num?)?.toInt(),
      checkoutUrl: json['checkout_url'] as String?,
    );

Map<String, dynamic> _$$CryptoCheckoutResultImplToJson(
        _$CryptoCheckoutResultImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'id': instance.id,
      'order_id': instance.orderId,
      'wallet_address': instance.walletAddress,
      'amount_requested': instance.amountRequested,
      'asset': instance.asset,
      'chain': instance.chain,
      'token_symbol': instance.tokenSymbol,
      'decimals': instance.decimals,
      'confirmations_required': instance.confirmationsRequired,
      'network': instance.network,
      'network_name': instance.networkName,
      'explorer': instance.explorer,
      'expires_in_sec': instance.expiresInSec,
      'checkout_url': instance.checkoutUrl,
    };
