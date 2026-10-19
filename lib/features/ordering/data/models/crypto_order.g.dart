// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoOrderImpl _$$CryptoOrderImplFromJson(Map<String, dynamic> json) =>
    _$CryptoOrderImpl(
      orderId: json['order_id'] as String,
      walletAddress: json['wallet_address'] as String?,
      amountRequested: json['amount_requested'] as String?,
      amountReceived: json['amount_received'] as String?,
      txHash: json['tx_hash'] as String?,
      txUrl: json['tx_url'] as String?,
      status: CryptoPaymentStatus.fromJson(json['status']),
      asset: json['asset'] as String?,
      chain: json['chain'] as String?,
      network: json['network'] as String?,
      networkName: json['network_name'] as String?,
      explorer: json['explorer'] as String?,
      tokenSymbol: json['token_symbol'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      createdAt: DateFormatter.parseDbUtc(json['created_at'] as String?),
      expiresAt: DateFormatter.parseDbUtc(json['expires_at'] as String?),
      verifiedAt: DateFormatter.parseDbUtc(json['verified_at'] as String?),
      isExpired: json['is_expired'] as bool?,
      secondsLeft: (json['seconds_left'] as num?)?.toInt(),
      paymentRequestId: (json['payment_request_id'] as num?)?.toInt(),
      provisionStatus: json['provision_status'] as String?,
      serverId: (json['server_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CryptoOrderImplToJson(_$CryptoOrderImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'wallet_address': instance.walletAddress,
      'amount_requested': instance.amountRequested,
      'amount_received': instance.amountReceived,
      'tx_hash': instance.txHash,
      'tx_url': instance.txUrl,
      'status': CryptoPaymentStatus.toJson(instance.status),
      'asset': instance.asset,
      'chain': instance.chain,
      'network': instance.network,
      'network_name': instance.networkName,
      'explorer': instance.explorer,
      'token_symbol': instance.tokenSymbol,
      'decimals': instance.decimals,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'verified_at': instance.verifiedAt?.toIso8601String(),
      'is_expired': instance.isExpired,
      'seconds_left': instance.secondsLeft,
      'payment_request_id': instance.paymentRequestId,
      'provision_status': instance.provisionStatus,
      'server_id': instance.serverId,
    };
