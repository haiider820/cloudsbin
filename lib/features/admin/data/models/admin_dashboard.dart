import 'package:freezed_annotation/freezed_annotation.dart';

import 'admin_json.dart';

part 'admin_dashboard.freezed.dart';
part 'admin_dashboard.g.dart';

/// `GET /admin/dashboard` — platform-wide counters. Every nested block is
/// defaulted so a partial payload still renders.
@freezed
class AdminDashboard with _$AdminDashboard {
  const factory AdminDashboard({
    @Default(AdminDashboardUsers()) AdminDashboardUsers users,
    @Default(AdminDashboardServers()) AdminDashboardServers servers,
    @Default(AdminDashboardOrders()) AdminDashboardOrders orders,
    @Default(AdminDashboardRevenue()) AdminDashboardRevenue revenue,
    @Default(AdminDashboardTickets()) AdminDashboardTickets tickets,
    @Default(AdminDashboardTopups()) AdminDashboardTopups topups,
  }) = _AdminDashboard;

  factory AdminDashboard.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardFromJson(json);
}

@freezed
class AdminDashboardUsers with _$AdminDashboardUsers {
  const factory AdminDashboardUsers({
    @Default(0) int total,
    @JsonKey(name: 'new_today') @Default(0) int newToday,
    @JsonKey(name: 'new_this_month') @Default(0) int newThisMonth,
  }) = _AdminDashboardUsers;

  factory AdminDashboardUsers.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardUsersFromJson(json);
}

@freezed
class AdminDashboardServers with _$AdminDashboardServers {
  const factory AdminDashboardServers({
    @Default(0) int total,
    @Default(0) int active,
    @Default(0) int provisioning,
    @Default(0) int destroyed,
  }) = _AdminDashboardServers;

  factory AdminDashboardServers.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardServersFromJson(json);
}

@freezed
class AdminDashboardOrders with _$AdminDashboardOrders {
  const factory AdminDashboardOrders({
    @Default(0) int pending,
    @JsonKey(name: 'total_this_month') @Default(0) int totalThisMonth,
  }) = _AdminDashboardOrders;

  factory AdminDashboardOrders.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardOrdersFromJson(json);
}

@freezed
class AdminDashboardRevenue with _$AdminDashboardRevenue {
  const factory AdminDashboardRevenue({
    @JsonKey(name: 'today_usd', fromJson: moneyString) String? todayUsd,
    @JsonKey(name: 'this_month_usd', fromJson: moneyString) String? thisMonthUsd,
  }) = _AdminDashboardRevenue;

  factory AdminDashboardRevenue.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardRevenueFromJson(json);
}

@freezed
class AdminDashboardTickets with _$AdminDashboardTickets {
  const factory AdminDashboardTickets({
    @Default(0) int open,
    @Default(0) int unread,
  }) = _AdminDashboardTickets;

  factory AdminDashboardTickets.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardTicketsFromJson(json);
}

@freezed
class AdminDashboardTopups with _$AdminDashboardTopups {
  const factory AdminDashboardTopups({
    @JsonKey(name: 'pending_count') @Default(0) int pendingCount,
    @JsonKey(name: 'pending_amount_usd', fromJson: moneyString)
    String? pendingAmountUsd,
  }) = _AdminDashboardTopups;

  factory AdminDashboardTopups.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardTopupsFromJson(json);
}
