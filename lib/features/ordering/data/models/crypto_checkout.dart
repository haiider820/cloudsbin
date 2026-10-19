import 'package:freezed_annotation/freezed_annotation.dart';

part 'crypto_checkout.freezed.dart';
part 'crypto_checkout.g.dart';

/// `POST /crypto/checkout` → 201 (§6.33). Creates a PENDING order;
/// no chain activity happens yet. Amounts are strings — show verbatim.
@freezed
class CryptoCheckoutResult with _$CryptoCheckoutResult {
  const factory CryptoCheckoutResult({
    String? message,
    int? id,
    @JsonKey(name: 'order_id') required String orderId,
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
    @JsonKey(name: 'checkout_url') String? checkoutUrl,
  }) = _CryptoCheckoutResult;

  factory CryptoCheckoutResult.fromJson(Map<String, dynamic> json) =>
      _$CryptoCheckoutResultFromJson(json);
}
