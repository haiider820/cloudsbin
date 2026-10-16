// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeSummaryImpl _$$HomeSummaryImplFromJson(Map<String, dynamic> json) =>
    _$HomeSummaryImpl(
      servers: ServerCounts.fromJson(json['servers'] as Map<String, dynamic>),
      wallet: WalletSummary.fromJson(json['wallet'] as Map<String, dynamic>),
      unreadNotifications: (json['unread_notifications'] as num?)?.toInt(),
      pendingTopups: (json['pending_topups'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HomeSummaryImplToJson(_$HomeSummaryImpl instance) =>
    <String, dynamic>{
      'servers': instance.servers,
      'wallet': instance.wallet,
      'unread_notifications': instance.unreadNotifications,
      'pending_topups': instance.pendingTopups,
    };

_$ServerCountsImpl _$$ServerCountsImplFromJson(Map<String, dynamic> json) =>
    _$ServerCountsImpl(
      total: (json['total'] as num?)?.toInt() ?? 0,
      active: (json['active'] as num?)?.toInt() ?? 0,
      provisioning: (json['provisioning'] as num?)?.toInt() ?? 0,
      other: (json['other'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ServerCountsImplToJson(_$ServerCountsImpl instance) =>
    <String, dynamic>{
      'total': instance.total,
      'active': instance.active,
      'provisioning': instance.provisioning,
      'other': instance.other,
    };

_$WalletSummaryImpl _$$WalletSummaryImplFromJson(Map<String, dynamic> json) =>
    _$WalletSummaryImpl(
      availableUsd: json['available_usd'] as String?,
      pendingUsd: json['pending_usd'] as String?,
      lifetimeEarnedUsd: json['lifetime_earned_usd'] as String?,
    );

Map<String, dynamic> _$$WalletSummaryImplToJson(_$WalletSummaryImpl instance) =>
    <String, dynamic>{
      'available_usd': instance.availableUsd,
      'pending_usd': instance.pendingUsd,
      'lifetime_earned_usd': instance.lifetimeEarnedUsd,
    };
