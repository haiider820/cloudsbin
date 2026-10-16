// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crypto_asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CryptoAsset _$CryptoAssetFromJson(Map<String, dynamic> json) {
  return _CryptoAsset.fromJson(json);
}

/// @nodoc
mixin _$CryptoAsset {
  String get asset => throw _privateConstructorUsedError;
  String? get chain => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;
  int? get decimals => throw _privateConstructorUsedError;
  String? get network => throw _privateConstructorUsedError;
  @JsonKey(name: 'network_name')
  String? get networkName => throw _privateConstructorUsedError;
  @JsonKey(name: 'confirmations_required')
  int? get confirmationsRequired => throw _privateConstructorUsedError;

  /// Serializes this CryptoAsset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CryptoAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoAssetCopyWith<CryptoAsset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoAssetCopyWith<$Res> {
  factory $CryptoAssetCopyWith(
          CryptoAsset value, $Res Function(CryptoAsset) then) =
      _$CryptoAssetCopyWithImpl<$Res, CryptoAsset>;
  @useResult
  $Res call(
      {String asset,
      String? chain,
      String? label,
      String? symbol,
      int? decimals,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      @JsonKey(name: 'confirmations_required') int? confirmationsRequired});
}

/// @nodoc
class _$CryptoAssetCopyWithImpl<$Res, $Val extends CryptoAsset>
    implements $CryptoAssetCopyWith<$Res> {
  _$CryptoAssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CryptoAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asset = null,
    Object? chain = freezed,
    Object? label = freezed,
    Object? symbol = freezed,
    Object? decimals = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? confirmationsRequired = freezed,
  }) {
    return _then(_value.copyWith(
      asset: null == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      networkName: freezed == networkName
          ? _value.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmationsRequired: freezed == confirmationsRequired
          ? _value.confirmationsRequired
          : confirmationsRequired // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CryptoAssetImplCopyWith<$Res>
    implements $CryptoAssetCopyWith<$Res> {
  factory _$$CryptoAssetImplCopyWith(
          _$CryptoAssetImpl value, $Res Function(_$CryptoAssetImpl) then) =
      __$$CryptoAssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String asset,
      String? chain,
      String? label,
      String? symbol,
      int? decimals,
      String? network,
      @JsonKey(name: 'network_name') String? networkName,
      @JsonKey(name: 'confirmations_required') int? confirmationsRequired});
}

/// @nodoc
class __$$CryptoAssetImplCopyWithImpl<$Res>
    extends _$CryptoAssetCopyWithImpl<$Res, _$CryptoAssetImpl>
    implements _$$CryptoAssetImplCopyWith<$Res> {
  __$$CryptoAssetImplCopyWithImpl(
      _$CryptoAssetImpl _value, $Res Function(_$CryptoAssetImpl) _then)
      : super(_value, _then);

  /// Create a copy of CryptoAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? asset = null,
    Object? chain = freezed,
    Object? label = freezed,
    Object? symbol = freezed,
    Object? decimals = freezed,
    Object? network = freezed,
    Object? networkName = freezed,
    Object? confirmationsRequired = freezed,
  }) {
    return _then(_$CryptoAssetImpl(
      asset: null == asset
          ? _value.asset
          : asset // ignore: cast_nullable_to_non_nullable
              as String,
      chain: freezed == chain
          ? _value.chain
          : chain // ignore: cast_nullable_to_non_nullable
              as String?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      decimals: freezed == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int?,
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      networkName: freezed == networkName
          ? _value.networkName
          : networkName // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmationsRequired: freezed == confirmationsRequired
          ? _value.confirmationsRequired
          : confirmationsRequired // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CryptoAssetImpl implements _CryptoAsset {
  const _$CryptoAssetImpl(
      {required this.asset,
      this.chain,
      this.label,
      this.symbol,
      this.decimals,
      this.network,
      @JsonKey(name: 'network_name') this.networkName,
      @JsonKey(name: 'confirmations_required') this.confirmationsRequired});

  factory _$CryptoAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CryptoAssetImplFromJson(json);

  @override
  final String asset;
  @override
  final String? chain;
  @override
  final String? label;
  @override
  final String? symbol;
  @override
  final int? decimals;
  @override
  final String? network;
  @override
  @JsonKey(name: 'network_name')
  final String? networkName;
  @override
  @JsonKey(name: 'confirmations_required')
  final int? confirmationsRequired;

  @override
  String toString() {
    return 'CryptoAsset(asset: $asset, chain: $chain, label: $label, symbol: $symbol, decimals: $decimals, network: $network, networkName: $networkName, confirmationsRequired: $confirmationsRequired)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoAssetImpl &&
            (identical(other.asset, asset) || other.asset == asset) &&
            (identical(other.chain, chain) || other.chain == chain) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.networkName, networkName) ||
                other.networkName == networkName) &&
            (identical(other.confirmationsRequired, confirmationsRequired) ||
                other.confirmationsRequired == confirmationsRequired));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, asset, chain, label, symbol,
      decimals, network, networkName, confirmationsRequired);

  /// Create a copy of CryptoAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoAssetImplCopyWith<_$CryptoAssetImpl> get copyWith =>
      __$$CryptoAssetImplCopyWithImpl<_$CryptoAssetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CryptoAssetImplToJson(
      this,
    );
  }
}

abstract class _CryptoAsset implements CryptoAsset {
  const factory _CryptoAsset(
      {required final String asset,
      final String? chain,
      final String? label,
      final String? symbol,
      final int? decimals,
      final String? network,
      @JsonKey(name: 'network_name') final String? networkName,
      @JsonKey(name: 'confirmations_required')
      final int? confirmationsRequired}) = _$CryptoAssetImpl;

  factory _CryptoAsset.fromJson(Map<String, dynamic> json) =
      _$CryptoAssetImpl.fromJson;

  @override
  String get asset;
  @override
  String? get chain;
  @override
  String? get label;
  @override
  String? get symbol;
  @override
  int? get decimals;
  @override
  String? get network;
  @override
  @JsonKey(name: 'network_name')
  String? get networkName;
  @override
  @JsonKey(name: 'confirmations_required')
  int? get confirmationsRequired;

  /// Create a copy of CryptoAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoAssetImplCopyWith<_$CryptoAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BtcRate _$BtcRateFromJson(Map<String, dynamic> json) {
  return _BtcRate.fromJson(json);
}

/// @nodoc
mixin _$BtcRate {
  double? get rate => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_sec')
  int? get ageSec => throw _privateConstructorUsedError;

  /// Serializes this BtcRate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BtcRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BtcRateCopyWith<BtcRate> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BtcRateCopyWith<$Res> {
  factory $BtcRateCopyWith(BtcRate value, $Res Function(BtcRate) then) =
      _$BtcRateCopyWithImpl<$Res, BtcRate>;
  @useResult
  $Res call(
      {double? rate,
      @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? updatedAt,
      @JsonKey(name: 'age_sec') int? ageSec});
}

/// @nodoc
class _$BtcRateCopyWithImpl<$Res, $Val extends BtcRate>
    implements $BtcRateCopyWith<$Res> {
  _$BtcRateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BtcRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rate = freezed,
    Object? updatedAt = freezed,
    Object? ageSec = freezed,
  }) {
    return _then(_value.copyWith(
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ageSec: freezed == ageSec
          ? _value.ageSec
          : ageSec // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BtcRateImplCopyWith<$Res> implements $BtcRateCopyWith<$Res> {
  factory _$$BtcRateImplCopyWith(
          _$BtcRateImpl value, $Res Function(_$BtcRateImpl) then) =
      __$$BtcRateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? rate,
      @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
      DateTime? updatedAt,
      @JsonKey(name: 'age_sec') int? ageSec});
}

/// @nodoc
class __$$BtcRateImplCopyWithImpl<$Res>
    extends _$BtcRateCopyWithImpl<$Res, _$BtcRateImpl>
    implements _$$BtcRateImplCopyWith<$Res> {
  __$$BtcRateImplCopyWithImpl(
      _$BtcRateImpl _value, $Res Function(_$BtcRateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BtcRate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rate = freezed,
    Object? updatedAt = freezed,
    Object? ageSec = freezed,
  }) {
    return _then(_$BtcRateImpl(
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ageSec: freezed == ageSec
          ? _value.ageSec
          : ageSec // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BtcRateImpl implements _BtcRate {
  const _$BtcRateImpl(
      {this.rate,
      @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
      this.updatedAt,
      @JsonKey(name: 'age_sec') this.ageSec});

  factory _$BtcRateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BtcRateImplFromJson(json);

  @override
  final double? rate;
  @override
  @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
  final DateTime? updatedAt;
  @override
  @JsonKey(name: 'age_sec')
  final int? ageSec;

  @override
  String toString() {
    return 'BtcRate(rate: $rate, updatedAt: $updatedAt, ageSec: $ageSec)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BtcRateImpl &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.ageSec, ageSec) || other.ageSec == ageSec));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rate, updatedAt, ageSec);

  /// Create a copy of BtcRate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BtcRateImplCopyWith<_$BtcRateImpl> get copyWith =>
      __$$BtcRateImplCopyWithImpl<_$BtcRateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BtcRateImplToJson(
      this,
    );
  }
}

abstract class _BtcRate implements BtcRate {
  const factory _BtcRate(
      {final double? rate,
      @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
      final DateTime? updatedAt,
      @JsonKey(name: 'age_sec') final int? ageSec}) = _$BtcRateImpl;

  factory _BtcRate.fromJson(Map<String, dynamic> json) = _$BtcRateImpl.fromJson;

  @override
  double? get rate;
  @override
  @JsonKey(name: 'updated_at', fromJson: DateFormatter.parseDbUtc)
  DateTime? get updatedAt;
  @override
  @JsonKey(name: 'age_sec')
  int? get ageSec;

  /// Create a copy of BtcRate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BtcRateImplCopyWith<_$BtcRateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CryptoAssetsResponse _$CryptoAssetsResponseFromJson(Map<String, dynamic> json) {
  return _CryptoAssetsResponse.fromJson(json);
}

/// @nodoc
mixin _$CryptoAssetsResponse {
  String? get network => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_testnet')
  bool? get isTestnet => throw _privateConstructorUsedError;
  List<CryptoAsset> get assets => throw _privateConstructorUsedError;
  @JsonKey(name: 'btc_rate')
  BtcRate? get btcRate => throw _privateConstructorUsedError;

  /// Serializes this CryptoAssetsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoAssetsResponseCopyWith<CryptoAssetsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoAssetsResponseCopyWith<$Res> {
  factory $CryptoAssetsResponseCopyWith(CryptoAssetsResponse value,
          $Res Function(CryptoAssetsResponse) then) =
      _$CryptoAssetsResponseCopyWithImpl<$Res, CryptoAssetsResponse>;
  @useResult
  $Res call(
      {String? network,
      @JsonKey(name: 'is_testnet') bool? isTestnet,
      List<CryptoAsset> assets,
      @JsonKey(name: 'btc_rate') BtcRate? btcRate});

  $BtcRateCopyWith<$Res>? get btcRate;
}

/// @nodoc
class _$CryptoAssetsResponseCopyWithImpl<$Res,
        $Val extends CryptoAssetsResponse>
    implements $CryptoAssetsResponseCopyWith<$Res> {
  _$CryptoAssetsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = freezed,
    Object? isTestnet = freezed,
    Object? assets = null,
    Object? btcRate = freezed,
  }) {
    return _then(_value.copyWith(
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      isTestnet: freezed == isTestnet
          ? _value.isTestnet
          : isTestnet // ignore: cast_nullable_to_non_nullable
              as bool?,
      assets: null == assets
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<CryptoAsset>,
      btcRate: freezed == btcRate
          ? _value.btcRate
          : btcRate // ignore: cast_nullable_to_non_nullable
              as BtcRate?,
    ) as $Val);
  }

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BtcRateCopyWith<$Res>? get btcRate {
    if (_value.btcRate == null) {
      return null;
    }

    return $BtcRateCopyWith<$Res>(_value.btcRate!, (value) {
      return _then(_value.copyWith(btcRate: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CryptoAssetsResponseImplCopyWith<$Res>
    implements $CryptoAssetsResponseCopyWith<$Res> {
  factory _$$CryptoAssetsResponseImplCopyWith(_$CryptoAssetsResponseImpl value,
          $Res Function(_$CryptoAssetsResponseImpl) then) =
      __$$CryptoAssetsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? network,
      @JsonKey(name: 'is_testnet') bool? isTestnet,
      List<CryptoAsset> assets,
      @JsonKey(name: 'btc_rate') BtcRate? btcRate});

  @override
  $BtcRateCopyWith<$Res>? get btcRate;
}

/// @nodoc
class __$$CryptoAssetsResponseImplCopyWithImpl<$Res>
    extends _$CryptoAssetsResponseCopyWithImpl<$Res, _$CryptoAssetsResponseImpl>
    implements _$$CryptoAssetsResponseImplCopyWith<$Res> {
  __$$CryptoAssetsResponseImplCopyWithImpl(_$CryptoAssetsResponseImpl _value,
      $Res Function(_$CryptoAssetsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? network = freezed,
    Object? isTestnet = freezed,
    Object? assets = null,
    Object? btcRate = freezed,
  }) {
    return _then(_$CryptoAssetsResponseImpl(
      network: freezed == network
          ? _value.network
          : network // ignore: cast_nullable_to_non_nullable
              as String?,
      isTestnet: freezed == isTestnet
          ? _value.isTestnet
          : isTestnet // ignore: cast_nullable_to_non_nullable
              as bool?,
      assets: null == assets
          ? _value._assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<CryptoAsset>,
      btcRate: freezed == btcRate
          ? _value.btcRate
          : btcRate // ignore: cast_nullable_to_non_nullable
              as BtcRate?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CryptoAssetsResponseImpl implements _CryptoAssetsResponse {
  const _$CryptoAssetsResponseImpl(
      {this.network,
      @JsonKey(name: 'is_testnet') this.isTestnet,
      final List<CryptoAsset> assets = const [],
      @JsonKey(name: 'btc_rate') this.btcRate})
      : _assets = assets;

  factory _$CryptoAssetsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CryptoAssetsResponseImplFromJson(json);

  @override
  final String? network;
  @override
  @JsonKey(name: 'is_testnet')
  final bool? isTestnet;
  final List<CryptoAsset> _assets;
  @override
  @JsonKey()
  List<CryptoAsset> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  @override
  @JsonKey(name: 'btc_rate')
  final BtcRate? btcRate;

  @override
  String toString() {
    return 'CryptoAssetsResponse(network: $network, isTestnet: $isTestnet, assets: $assets, btcRate: $btcRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoAssetsResponseImpl &&
            (identical(other.network, network) || other.network == network) &&
            (identical(other.isTestnet, isTestnet) ||
                other.isTestnet == isTestnet) &&
            const DeepCollectionEquality().equals(other._assets, _assets) &&
            (identical(other.btcRate, btcRate) || other.btcRate == btcRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, network, isTestnet,
      const DeepCollectionEquality().hash(_assets), btcRate);

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoAssetsResponseImplCopyWith<_$CryptoAssetsResponseImpl>
      get copyWith =>
          __$$CryptoAssetsResponseImplCopyWithImpl<_$CryptoAssetsResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CryptoAssetsResponseImplToJson(
      this,
    );
  }
}

abstract class _CryptoAssetsResponse implements CryptoAssetsResponse {
  const factory _CryptoAssetsResponse(
          {final String? network,
          @JsonKey(name: 'is_testnet') final bool? isTestnet,
          final List<CryptoAsset> assets,
          @JsonKey(name: 'btc_rate') final BtcRate? btcRate}) =
      _$CryptoAssetsResponseImpl;

  factory _CryptoAssetsResponse.fromJson(Map<String, dynamic> json) =
      _$CryptoAssetsResponseImpl.fromJson;

  @override
  String? get network;
  @override
  @JsonKey(name: 'is_testnet')
  bool? get isTestnet;
  @override
  List<CryptoAsset> get assets;
  @override
  @JsonKey(name: 'btc_rate')
  BtcRate? get btcRate;

  /// Create a copy of CryptoAssetsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoAssetsResponseImplCopyWith<_$CryptoAssetsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
