import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_summary.freezed.dart';
part 'home_summary.g.dart';

/// `GET /home` — dashboard summary (§6.10).
///
/// Wallet balances arrive as DECIMAL strings (`"84.00"`) — shown verbatim
/// via [MoneyFormatter.usdString], never parsed for arithmetic.
@freezed
class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    required ServerCounts servers,
    required WalletSummary wallet,
    @JsonKey(name: 'unread_notifications') int? unreadNotifications,
    @JsonKey(name: 'pending_topups') int? pendingTopups,
  }) = _HomeSummary;

  factory HomeSummary.fromJson(Map<String, dynamic> json) =>
      _$HomeSummaryFromJson(json);
}

@freezed
class ServerCounts with _$ServerCounts {
  const factory ServerCounts({
    @Default(0) int total,
    @Default(0) int active,
    @Default(0) int provisioning,
    @Default(0) int other,
  }) = _ServerCounts;

  factory ServerCounts.fromJson(Map<String, dynamic> json) =>
      _$ServerCountsFromJson(json);
}

@freezed
class WalletSummary with _$WalletSummary {
  const factory WalletSummary({
    @JsonKey(name: 'available_usd') String? availableUsd,
    @JsonKey(name: 'pending_usd') String? pendingUsd,
    @JsonKey(name: 'lifetime_earned_usd') String? lifetimeEarnedUsd,
  }) = _WalletSummary;

  factory WalletSummary.fromJson(Map<String, dynamic> json) =>
      _$WalletSummaryFromJson(json);
}
