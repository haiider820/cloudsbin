// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeSummary _$HomeSummaryFromJson(Map<String, dynamic> json) {
  return _HomeSummary.fromJson(json);
}

/// @nodoc
mixin _$HomeSummary {
  ServerCounts get servers => throw _privateConstructorUsedError;
  WalletSummary get wallet => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_notifications')
  int? get unreadNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_topups')
  int? get pendingTopups => throw _privateConstructorUsedError;

  /// Serializes this HomeSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeSummaryCopyWith<HomeSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeSummaryCopyWith<$Res> {
  factory $HomeSummaryCopyWith(
          HomeSummary value, $Res Function(HomeSummary) then) =
      _$HomeSummaryCopyWithImpl<$Res, HomeSummary>;
  @useResult
  $Res call(
      {ServerCounts servers,
      WalletSummary wallet,
      @JsonKey(name: 'unread_notifications') int? unreadNotifications,
      @JsonKey(name: 'pending_topups') int? pendingTopups});

  $ServerCountsCopyWith<$Res> get servers;
  $WalletSummaryCopyWith<$Res> get wallet;
}

/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res, $Val extends HomeSummary>
    implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? servers = null,
    Object? wallet = null,
    Object? unreadNotifications = freezed,
    Object? pendingTopups = freezed,
  }) {
    return _then(_value.copyWith(
      servers: null == servers
          ? _value.servers
          : servers // ignore: cast_nullable_to_non_nullable
              as ServerCounts,
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as WalletSummary,
      unreadNotifications: freezed == unreadNotifications
          ? _value.unreadNotifications
          : unreadNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingTopups: freezed == pendingTopups
          ? _value.pendingTopups
          : pendingTopups // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ServerCountsCopyWith<$Res> get servers {
    return $ServerCountsCopyWith<$Res>(_value.servers, (value) {
      return _then(_value.copyWith(servers: value) as $Val);
    });
  }

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletSummaryCopyWith<$Res> get wallet {
    return $WalletSummaryCopyWith<$Res>(_value.wallet, (value) {
      return _then(_value.copyWith(wallet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeSummaryImplCopyWith<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  factory _$$HomeSummaryImplCopyWith(
          _$HomeSummaryImpl value, $Res Function(_$HomeSummaryImpl) then) =
      __$$HomeSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ServerCounts servers,
      WalletSummary wallet,
      @JsonKey(name: 'unread_notifications') int? unreadNotifications,
      @JsonKey(name: 'pending_topups') int? pendingTopups});

  @override
  $ServerCountsCopyWith<$Res> get servers;
  @override
  $WalletSummaryCopyWith<$Res> get wallet;
}

/// @nodoc
class __$$HomeSummaryImplCopyWithImpl<$Res>
    extends _$HomeSummaryCopyWithImpl<$Res, _$HomeSummaryImpl>
    implements _$$HomeSummaryImplCopyWith<$Res> {
  __$$HomeSummaryImplCopyWithImpl(
      _$HomeSummaryImpl _value, $Res Function(_$HomeSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? servers = null,
    Object? wallet = null,
    Object? unreadNotifications = freezed,
    Object? pendingTopups = freezed,
  }) {
    return _then(_$HomeSummaryImpl(
      servers: null == servers
          ? _value.servers
          : servers // ignore: cast_nullable_to_non_nullable
              as ServerCounts,
      wallet: null == wallet
          ? _value.wallet
          : wallet // ignore: cast_nullable_to_non_nullable
              as WalletSummary,
      unreadNotifications: freezed == unreadNotifications
          ? _value.unreadNotifications
          : unreadNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      pendingTopups: freezed == pendingTopups
          ? _value.pendingTopups
          : pendingTopups // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeSummaryImpl implements _HomeSummary {
  const _$HomeSummaryImpl(
      {required this.servers,
      required this.wallet,
      @JsonKey(name: 'unread_notifications') this.unreadNotifications,
      @JsonKey(name: 'pending_topups') this.pendingTopups});

  factory _$HomeSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeSummaryImplFromJson(json);

  @override
  final ServerCounts servers;
  @override
  final WalletSummary wallet;
  @override
  @JsonKey(name: 'unread_notifications')
  final int? unreadNotifications;
  @override
  @JsonKey(name: 'pending_topups')
  final int? pendingTopups;

  @override
  String toString() {
    return 'HomeSummary(servers: $servers, wallet: $wallet, unreadNotifications: $unreadNotifications, pendingTopups: $pendingTopups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeSummaryImpl &&
            (identical(other.servers, servers) || other.servers == servers) &&
            (identical(other.wallet, wallet) || other.wallet == wallet) &&
            (identical(other.unreadNotifications, unreadNotifications) ||
                other.unreadNotifications == unreadNotifications) &&
            (identical(other.pendingTopups, pendingTopups) ||
                other.pendingTopups == pendingTopups));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, servers, wallet, unreadNotifications, pendingTopups);

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeSummaryImplCopyWith<_$HomeSummaryImpl> get copyWith =>
      __$$HomeSummaryImplCopyWithImpl<_$HomeSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeSummaryImplToJson(
      this,
    );
  }
}

abstract class _HomeSummary implements HomeSummary {
  const factory _HomeSummary(
          {required final ServerCounts servers,
          required final WalletSummary wallet,
          @JsonKey(name: 'unread_notifications') final int? unreadNotifications,
          @JsonKey(name: 'pending_topups') final int? pendingTopups}) =
      _$HomeSummaryImpl;

  factory _HomeSummary.fromJson(Map<String, dynamic> json) =
      _$HomeSummaryImpl.fromJson;

  @override
  ServerCounts get servers;
  @override
  WalletSummary get wallet;
  @override
  @JsonKey(name: 'unread_notifications')
  int? get unreadNotifications;
  @override
  @JsonKey(name: 'pending_topups')
  int? get pendingTopups;

  /// Create a copy of HomeSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeSummaryImplCopyWith<_$HomeSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServerCounts _$ServerCountsFromJson(Map<String, dynamic> json) {
  return _ServerCounts.fromJson(json);
}

/// @nodoc
mixin _$ServerCounts {
  int get total => throw _privateConstructorUsedError;
  int get active => throw _privateConstructorUsedError;
  int get provisioning => throw _privateConstructorUsedError;
  int get other => throw _privateConstructorUsedError;

  /// Serializes this ServerCounts to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServerCounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServerCountsCopyWith<ServerCounts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServerCountsCopyWith<$Res> {
  factory $ServerCountsCopyWith(
          ServerCounts value, $Res Function(ServerCounts) then) =
      _$ServerCountsCopyWithImpl<$Res, ServerCounts>;
  @useResult
  $Res call({int total, int active, int provisioning, int other});
}

/// @nodoc
class _$ServerCountsCopyWithImpl<$Res, $Val extends ServerCounts>
    implements $ServerCountsCopyWith<$Res> {
  _$ServerCountsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServerCounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? active = null,
    Object? provisioning = null,
    Object? other = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      provisioning: null == provisioning
          ? _value.provisioning
          : provisioning // ignore: cast_nullable_to_non_nullable
              as int,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServerCountsImplCopyWith<$Res>
    implements $ServerCountsCopyWith<$Res> {
  factory _$$ServerCountsImplCopyWith(
          _$ServerCountsImpl value, $Res Function(_$ServerCountsImpl) then) =
      __$$ServerCountsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int total, int active, int provisioning, int other});
}

/// @nodoc
class __$$ServerCountsImplCopyWithImpl<$Res>
    extends _$ServerCountsCopyWithImpl<$Res, _$ServerCountsImpl>
    implements _$$ServerCountsImplCopyWith<$Res> {
  __$$ServerCountsImplCopyWithImpl(
      _$ServerCountsImpl _value, $Res Function(_$ServerCountsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServerCounts
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? active = null,
    Object? provisioning = null,
    Object? other = null,
  }) {
    return _then(_$ServerCountsImpl(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as int,
      provisioning: null == provisioning
          ? _value.provisioning
          : provisioning // ignore: cast_nullable_to_non_nullable
              as int,
      other: null == other
          ? _value.other
          : other // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServerCountsImpl implements _ServerCounts {
  const _$ServerCountsImpl(
      {this.total = 0, this.active = 0, this.provisioning = 0, this.other = 0});

  factory _$ServerCountsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServerCountsImplFromJson(json);

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int active;
  @override
  @JsonKey()
  final int provisioning;
  @override
  @JsonKey()
  final int other;

  @override
  String toString() {
    return 'ServerCounts(total: $total, active: $active, provisioning: $provisioning, other: $other)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerCountsImpl &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.provisioning, provisioning) ||
                other.provisioning == provisioning) &&
            (identical(other.other, this.other) || other.other == this.other));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, total, active, provisioning, other);

  /// Create a copy of ServerCounts
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerCountsImplCopyWith<_$ServerCountsImpl> get copyWith =>
      __$$ServerCountsImplCopyWithImpl<_$ServerCountsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServerCountsImplToJson(
      this,
    );
  }
}

abstract class _ServerCounts implements ServerCounts {
  const factory _ServerCounts(
      {final int total,
      final int active,
      final int provisioning,
      final int other}) = _$ServerCountsImpl;

  factory _ServerCounts.fromJson(Map<String, dynamic> json) =
      _$ServerCountsImpl.fromJson;

  @override
  int get total;
  @override
  int get active;
  @override
  int get provisioning;
  @override
  int get other;

  /// Create a copy of ServerCounts
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerCountsImplCopyWith<_$ServerCountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WalletSummary _$WalletSummaryFromJson(Map<String, dynamic> json) {
  return _WalletSummary.fromJson(json);
}

/// @nodoc
mixin _$WalletSummary {
  @JsonKey(name: 'available_usd')
  String? get availableUsd => throw _privateConstructorUsedError;
  @JsonKey(name: 'pending_usd')
  String? get pendingUsd => throw _privateConstructorUsedError;
  @JsonKey(name: 'lifetime_earned_usd')
  String? get lifetimeEarnedUsd => throw _privateConstructorUsedError;

  /// Serializes this WalletSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletSummaryCopyWith<WalletSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletSummaryCopyWith<$Res> {
  factory $WalletSummaryCopyWith(
          WalletSummary value, $Res Function(WalletSummary) then) =
      _$WalletSummaryCopyWithImpl<$Res, WalletSummary>;
  @useResult
  $Res call(
      {@JsonKey(name: 'available_usd') String? availableUsd,
      @JsonKey(name: 'pending_usd') String? pendingUsd,
      @JsonKey(name: 'lifetime_earned_usd') String? lifetimeEarnedUsd});
}

/// @nodoc
class _$WalletSummaryCopyWithImpl<$Res, $Val extends WalletSummary>
    implements $WalletSummaryCopyWith<$Res> {
  _$WalletSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableUsd = freezed,
    Object? pendingUsd = freezed,
    Object? lifetimeEarnedUsd = freezed,
  }) {
    return _then(_value.copyWith(
      availableUsd: freezed == availableUsd
          ? _value.availableUsd
          : availableUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUsd: freezed == pendingUsd
          ? _value.pendingUsd
          : pendingUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      lifetimeEarnedUsd: freezed == lifetimeEarnedUsd
          ? _value.lifetimeEarnedUsd
          : lifetimeEarnedUsd // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WalletSummaryImplCopyWith<$Res>
    implements $WalletSummaryCopyWith<$Res> {
  factory _$$WalletSummaryImplCopyWith(
          _$WalletSummaryImpl value, $Res Function(_$WalletSummaryImpl) then) =
      __$$WalletSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'available_usd') String? availableUsd,
      @JsonKey(name: 'pending_usd') String? pendingUsd,
      @JsonKey(name: 'lifetime_earned_usd') String? lifetimeEarnedUsd});
}

/// @nodoc
class __$$WalletSummaryImplCopyWithImpl<$Res>
    extends _$WalletSummaryCopyWithImpl<$Res, _$WalletSummaryImpl>
    implements _$$WalletSummaryImplCopyWith<$Res> {
  __$$WalletSummaryImplCopyWithImpl(
      _$WalletSummaryImpl _value, $Res Function(_$WalletSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? availableUsd = freezed,
    Object? pendingUsd = freezed,
    Object? lifetimeEarnedUsd = freezed,
  }) {
    return _then(_$WalletSummaryImpl(
      availableUsd: freezed == availableUsd
          ? _value.availableUsd
          : availableUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      pendingUsd: freezed == pendingUsd
          ? _value.pendingUsd
          : pendingUsd // ignore: cast_nullable_to_non_nullable
              as String?,
      lifetimeEarnedUsd: freezed == lifetimeEarnedUsd
          ? _value.lifetimeEarnedUsd
          : lifetimeEarnedUsd // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletSummaryImpl implements _WalletSummary {
  const _$WalletSummaryImpl(
      {@JsonKey(name: 'available_usd') this.availableUsd,
      @JsonKey(name: 'pending_usd') this.pendingUsd,
      @JsonKey(name: 'lifetime_earned_usd') this.lifetimeEarnedUsd});

  factory _$WalletSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'available_usd')
  final String? availableUsd;
  @override
  @JsonKey(name: 'pending_usd')
  final String? pendingUsd;
  @override
  @JsonKey(name: 'lifetime_earned_usd')
  final String? lifetimeEarnedUsd;

  @override
  String toString() {
    return 'WalletSummary(availableUsd: $availableUsd, pendingUsd: $pendingUsd, lifetimeEarnedUsd: $lifetimeEarnedUsd)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletSummaryImpl &&
            (identical(other.availableUsd, availableUsd) ||
                other.availableUsd == availableUsd) &&
            (identical(other.pendingUsd, pendingUsd) ||
                other.pendingUsd == pendingUsd) &&
            (identical(other.lifetimeEarnedUsd, lifetimeEarnedUsd) ||
                other.lifetimeEarnedUsd == lifetimeEarnedUsd));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, availableUsd, pendingUsd, lifetimeEarnedUsd);

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletSummaryImplCopyWith<_$WalletSummaryImpl> get copyWith =>
      __$$WalletSummaryImplCopyWithImpl<_$WalletSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletSummaryImplToJson(
      this,
    );
  }
}

abstract class _WalletSummary implements WalletSummary {
  const factory _WalletSummary(
      {@JsonKey(name: 'available_usd') final String? availableUsd,
      @JsonKey(name: 'pending_usd') final String? pendingUsd,
      @JsonKey(name: 'lifetime_earned_usd')
      final String? lifetimeEarnedUsd}) = _$WalletSummaryImpl;

  factory _WalletSummary.fromJson(Map<String, dynamic> json) =
      _$WalletSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'available_usd')
  String? get availableUsd;
  @override
  @JsonKey(name: 'pending_usd')
  String? get pendingUsd;
  @override
  @JsonKey(name: 'lifetime_earned_usd')
  String? get lifetimeEarnedUsd;

  /// Create a copy of WalletSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletSummaryImplCopyWith<_$WalletSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
