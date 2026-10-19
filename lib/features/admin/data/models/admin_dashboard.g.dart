// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminDashboardImpl _$$AdminDashboardImplFromJson(Map<String, dynamic> json) =>
    _$AdminDashboardImpl(
      users: json['users'] == null
          ? const AdminDashboardUsers()
          : AdminDashboardUsers.fromJson(json['users'] as Map<String, dynamic>),
      servers: json['servers'] == null
          ? const AdminDashboardServers()
          : AdminDashboardServers.fromJson(
              json['servers'] as Map<String, dynamic>),
      orders: json['orders'] == null
          ? const AdminDashboardOrders()
          : AdminDashboardOrders.fromJson(
              json['orders'] as Map<String, dynamic>),
      revenue: json['revenue'] == null
          ? const AdminDashboardRevenue()
          : AdminDashboardRevenue.fromJson(
              json['revenue'] as Map<String, dynamic>),
      tickets: json['tickets'] == null
          ? const AdminDashboardTickets()
          : AdminDashboardTickets.fromJson(
              json['tickets'] as Map<String, dynamic>),
      topups: json['topups'] == null
          ? const AdminDashboardTopups()
          : AdminDashboardTopups.fromJson(
              json['topups'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AdminDashboardImplToJson(
        _$AdminDashboardImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
      'servers': instance.servers,
      'orders': instance.orders,
      'revenue': instance.revenue,
      'tickets': instance.tickets,
      'topups': instance.topups,
    };

_$AdminDashboardUsersImpl _$$AdminDashboardUsersImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardUsersImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      newToday: (json['new_today'] as num?)?.toInt() ?? 0,
      newThisMonth: (json['new_this_month'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminDashboardUsersImplToJson(
        _$AdminDashboardUsersImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'new_today': instance.newToday,
      'new_this_month': instance.newThisMonth,
    };

_$AdminDashboardServersImpl _$$AdminDashboardServersImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardServersImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      active: (json['active'] as num?)?.toInt() ?? 0,
      provisioning: (json['provisioning'] as num?)?.toInt() ?? 0,
      destroyed: (json['destroyed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminDashboardServersImplToJson(
        _$AdminDashboardServersImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'provisioning': instance.provisioning,
      'destroyed': instance.destroyed,
    };

_$AdminDashboardOrdersImpl _$$AdminDashboardOrdersImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardOrdersImpl(
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      totalThisMonth: (json['total_this_month'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminDashboardOrdersImplToJson(
        _$AdminDashboardOrdersImpl instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'total_this_month': instance.totalThisMonth,
    };

_$AdminDashboardRevenueImpl _$$AdminDashboardRevenueImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardRevenueImpl(
      todayUsd: moneyString(json['today_usd']),
      thisMonthUsd: moneyString(json['this_month_usd']),
    );

Map<String, dynamic> _$$AdminDashboardRevenueImplToJson(
        _$AdminDashboardRevenueImpl instance) =>
    <String, dynamic>{
      'today_usd': instance.todayUsd,
      'this_month_usd': instance.thisMonthUsd,
    };

_$AdminDashboardTicketsImpl _$$AdminDashboardTicketsImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardTicketsImpl(
      open: (json['open'] as num?)?.toInt() ?? 0,
      unread: (json['unread'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminDashboardTicketsImplToJson(
        _$AdminDashboardTicketsImpl instance) =>
    <String, dynamic>{
      'open': instance.open,
      'unread': instance.unread,
    };

_$AdminDashboardTopupsImpl _$$AdminDashboardTopupsImplFromJson(
        Map<String, dynamic> json) =>
    _$AdminDashboardTopupsImpl(
      pendingCount: (json['pending_count'] as num?)?.toInt() ?? 0,
      pendingAmountUsd: moneyString(json['pending_amount_usd']),
    );

Map<String, dynamic> _$$AdminDashboardTopupsImplToJson(
        _$AdminDashboardTopupsImpl instance) =>
    <String, dynamic>{
      'pending_count': instance.pendingCount,
      'pending_amount_usd': instance.pendingAmountUsd,
    };
