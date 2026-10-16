import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/utils/date_formatter.dart';

part 'crypto_asset.freezed.dart';
part 'crypto_asset.g.dart';

/// One entry of `GET /crypto/assets` → `assets[]` (§6.32).
@freezed
class CryptoAsset with _$CryptoAsset {
  const factory CryptoAsset({
    required String asset,
    String? chain,
    String? label,
    String? symbol,
    int? decimals,
    String? network,
    @JsonKey(name: 'network_name') String? networkName,
    @JsonKey(name: 'confirmations_required') int? confirmationsRequired,
  }) = _CryptoAsset;

  factory CryptoAsset.fromJson(Map<String, dynamic> json) =>
      _$CryptoAssetFromJson(json);
}

/// `GET /crypto/assets` → `btc_rate` (§6.32). Note the `Y-m-d H:i:s`
/// timestamp — parse with [DateFormatter.parseDbUtc].
@freezed
class BtcRate with _$BtcRate {
  const factory BtcRate({
    double? rate,
    @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
    DateTime? updatedAt,
    @JsonKey(name: 'age_sec') int? ageSec,
  }) = _BtcRate;

  factory BtcRate.fromJson(Map<String, dynamic> json) =>
      _$BtcRateFromJson(json);
}

/// `GET /crypto/assets` response (§6.32).
@freezed
class CryptoAssetsResponse with _$CryptoAssetsResponse {
  const factory CryptoAssetsResponse({
    String? network,
    @JsonKey(name: 'is_testnet') bool? isTestnet,
    @Default([]) List<CryptoAsset> assets,
    @JsonKey(name: 'btc_rate') BtcRate? btcRate,
  }) = _CryptoAssetsResponse;

  factory CryptoAssetsResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoAssetsResponseFromJson(json);
}
