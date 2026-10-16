import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/enums/app_enums.dart';
import '../../../../shared/utils/date_formatter.dart';

part 'crypto_order.freezed.dart';
part 'crypto_order.g.dart';

/// `GET /crypto/order?order=CRY-...` (§6.34).
///
/// Datetimes are `Y-m-d H:i:s` (no timezone) — the one v1 exception —
/// parsed with [DateFormatter.parseDbUtc]. Amounts are strings, shown
/// verbatim with the asset symbol.
@freezed
class CryptoOrder with _$CryptoOrder {
  const factory CryptoOrder({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'wallet_address') String? walletAddress,
    @JsonKey(name: 'amount_requested') String? amountRequested,
    @JsonKey(name: 'amount_received') String? amountReceived,
    @JsonKey(name: 'tx_hash') String? txHash,
    @JsonKey(name: 'tx_url') String? txUrl,
    @JsonKey(fromJson: CryptoPaymentStatus.fromJson, toJson: CryptoPaymentStatus.toJson)
    required CryptoPaymentStatus status,
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
    @JsonKey(name: 'server_id') int? serverId,
  }) = _CryptoOrder;

  factory CryptoOrder.fromJson(Map<String, dynamic> json) =>
      _$CryptoOrderFromJson(json);
}
