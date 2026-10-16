// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CryptoAssetImpl _$$CryptoAssetImplFromJson(Map<String, dynamic> json) =>
    _$CryptoAssetImpl(
      asset: json['asset'] as String,
      chain: json['chain'] as String?,
      label: json['label'] as String?,
      symbol: json['symbol'] as String?,
      decimals: (json['decimals'] as num?)?.toInt(),
      network: json['network'] as String?,
      networkName: json['network_name'] as String?,
      confirmationsRequired: (json['confirmations_required'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$CryptoAssetImplToJson(_$CryptoAssetImpl instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'chain': instance.chain,
      'label': instance.label,
      'symbol': instance.symbol,
      'decimals': instance.decimals,
      'network': instance.network,
      'network_name': instance.networkName,
      'confirmations_required': instance.confirmationsRequired,
    };

_$BtcRateImpl _$$BtcRateImplFromJson(Map<String, dynamic> json) =>
    _$BtcRateImpl(
      rate: (json['rate'] as num?)?.toDouble(),
      updatedAt: DateFormatter.parseDbUtc(json['updated_at'] as String?),
      ageSec: (json['age_sec'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$BtcRateImplToJson(_$BtcRateImpl instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'age_sec': instance.ageSec,
    };

_$CryptoAssetsResponseImpl _$$CryptoAssetsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CryptoAssetsResponseImpl(
      network: json['network'] as String?,
      isTestnet: json['is_testnet'] as bool?,
      assets: (json['assets'] as List<dynamic>?)
              ?.map((e) => CryptoAsset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      btcRate: json['btc_rate'] == null
          ? null
          : BtcRate.fromJson(json['btc_rate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CryptoAssetsResponseImplToJson(
        _$CryptoAssetsResponseImpl instance) =>
    <String, dynamic>{
      'network': instance.network,
      'is_testnet': instance.isTestnet,
      'assets': instance.assets,
      'btc_rate': instance.btcRate,
    };
