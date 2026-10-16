// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firewall.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FirewallRule _$FirewallRuleFromJson(Map<String, dynamic> json) {
  return _FirewallRule.fromJson(json);
}

/// @nodoc
mixin _$FirewallRule {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  FirewallDirection? get direction => throw _privateConstructorUsedError;
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  FirewallProtocol? get protocol => throw _privateConstructorUsedError;
  @JsonKey(name: 'port_start')
  int? get portStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'port_end')
  int? get portEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FirewallRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FirewallRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FirewallRuleCopyWith<FirewallRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirewallRuleCopyWith<$Res> {
  factory $FirewallRuleCopyWith(
          FirewallRule value, $Res Function(FirewallRule) then) =
      _$FirewallRuleCopyWithImpl<$Res, FirewallRule>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') int? portStart,
      @JsonKey(name: 'port_end') int? portEnd,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class _$FirewallRuleCopyWithImpl<$Res, $Val extends FirewallRule>
    implements $FirewallRuleCopyWith<$Res> {
  _$FirewallRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FirewallRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? direction = freezed,
    Object? protocol = freezed,
    Object? portStart = freezed,
    Object? portEnd = freezed,
    Object? ipCidr = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as FirewallDirection?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as FirewallProtocol?,
      portStart: freezed == portStart
          ? _value.portStart
          : portStart // ignore: cast_nullable_to_non_nullable
              as int?,
      portEnd: freezed == portEnd
          ? _value.portEnd
          : portEnd // ignore: cast_nullable_to_non_nullable
              as int?,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirewallRuleImplCopyWith<$Res>
    implements $FirewallRuleCopyWith<$Res> {
  factory _$$FirewallRuleImplCopyWith(
          _$FirewallRuleImpl value, $Res Function(_$FirewallRuleImpl) then) =
      __$$FirewallRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') int? portStart,
      @JsonKey(name: 'port_end') int? portEnd,
      @JsonKey(name: 'ip_cidr') String? ipCidr,
      String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      DateTime? createdAt});
}

/// @nodoc
class __$$FirewallRuleImplCopyWithImpl<$Res>
    extends _$FirewallRuleCopyWithImpl<$Res, _$FirewallRuleImpl>
    implements _$$FirewallRuleImplCopyWith<$Res> {
  __$$FirewallRuleImplCopyWithImpl(
      _$FirewallRuleImpl _value, $Res Function(_$FirewallRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of FirewallRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? direction = freezed,
    Object? protocol = freezed,
    Object? portStart = freezed,
    Object? portEnd = freezed,
    Object? ipCidr = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$FirewallRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as FirewallDirection?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as FirewallProtocol?,
      portStart: freezed == portStart
          ? _value.portStart
          : portStart // ignore: cast_nullable_to_non_nullable
              as int?,
      portEnd: freezed == portEnd
          ? _value.portEnd
          : portEnd // ignore: cast_nullable_to_non_nullable
              as int?,
      ipCidr: freezed == ipCidr
          ? _value.ipCidr
          : ipCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirewallRuleImpl implements _FirewallRule {
  const _$FirewallRuleImpl(
      {required this.id,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      this.direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      this.protocol,
      @JsonKey(name: 'port_start') this.portStart,
      @JsonKey(name: 'port_end') this.portEnd,
      @JsonKey(name: 'ip_cidr') this.ipCidr,
      this.description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      this.createdAt});

  factory _$FirewallRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirewallRuleImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  final FirewallDirection? direction;
  @override
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  final FirewallProtocol? protocol;
  @override
  @JsonKey(name: 'port_start')
  final int? portStart;
  @override
  @JsonKey(name: 'port_end')
  final int? portEnd;
  @override
  @JsonKey(name: 'ip_cidr')
  final String? ipCidr;
  @override
  final String? description;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FirewallRule(id: $id, direction: $direction, protocol: $protocol, portStart: $portStart, portEnd: $portEnd, ipCidr: $ipCidr, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirewallRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.portStart, portStart) ||
                other.portStart == portStart) &&
            (identical(other.portEnd, portEnd) || other.portEnd == portEnd) &&
            (identical(other.ipCidr, ipCidr) || other.ipCidr == ipCidr) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, direction, protocol,
      portStart, portEnd, ipCidr, description, createdAt);

  /// Create a copy of FirewallRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FirewallRuleImplCopyWith<_$FirewallRuleImpl> get copyWith =>
      __$$FirewallRuleImplCopyWithImpl<_$FirewallRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirewallRuleImplToJson(
      this,
    );
  }
}

abstract class _FirewallRule implements FirewallRule {
  const factory _FirewallRule(
      {required final int id,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      final FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      final FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') final int? portStart,
      @JsonKey(name: 'port_end') final int? portEnd,
      @JsonKey(name: 'ip_cidr') final String? ipCidr,
      final String? description,
      @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
      final DateTime? createdAt}) = _$FirewallRuleImpl;

  factory _FirewallRule.fromJson(Map<String, dynamic> json) =
      _$FirewallRuleImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  FirewallDirection? get direction;
  @override
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  FirewallProtocol? get protocol;
  @override
  @JsonKey(name: 'port_start')
  int? get portStart;
  @override
  @JsonKey(name: 'port_end')
  int? get portEnd;
  @override
  @JsonKey(name: 'ip_cidr')
  String? get ipCidr;
  @override
  String? get description;
  @override
  @JsonKey(name: 'created_at', fromJson: DateFormatter.parseIsoUtc)
  DateTime? get createdAt;

  /// Create a copy of FirewallRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FirewallRuleImplCopyWith<_$FirewallRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FirewallResponse _$FirewallResponseFromJson(Map<String, dynamic> json) {
  return _FirewallResponse.fromJson(json);
}

/// @nodoc
mixin _$FirewallResponse {
  List<FirewallRule> get rules => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;
  List<String> get directions => throw _privateConstructorUsedError;

  /// Serializes this FirewallResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FirewallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FirewallResponseCopyWith<FirewallResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirewallResponseCopyWith<$Res> {
  factory $FirewallResponseCopyWith(
          FirewallResponse value, $Res Function(FirewallResponse) then) =
      _$FirewallResponseCopyWithImpl<$Res, FirewallResponse>;
  @useResult
  $Res call(
      {List<FirewallRule> rules,
      @JsonKey(name: 'access_port') int? accessPort,
      List<String> directions});
}

/// @nodoc
class _$FirewallResponseCopyWithImpl<$Res, $Val extends FirewallResponse>
    implements $FirewallResponseCopyWith<$Res> {
  _$FirewallResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FirewallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rules = null,
    Object? accessPort = freezed,
    Object? directions = null,
  }) {
    return _then(_value.copyWith(
      rules: null == rules
          ? _value.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<FirewallRule>,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      directions: null == directions
          ? _value.directions
          : directions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirewallResponseImplCopyWith<$Res>
    implements $FirewallResponseCopyWith<$Res> {
  factory _$$FirewallResponseImplCopyWith(_$FirewallResponseImpl value,
          $Res Function(_$FirewallResponseImpl) then) =
      __$$FirewallResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FirewallRule> rules,
      @JsonKey(name: 'access_port') int? accessPort,
      List<String> directions});
}

/// @nodoc
class __$$FirewallResponseImplCopyWithImpl<$Res>
    extends _$FirewallResponseCopyWithImpl<$Res, _$FirewallResponseImpl>
    implements _$$FirewallResponseImplCopyWith<$Res> {
  __$$FirewallResponseImplCopyWithImpl(_$FirewallResponseImpl _value,
      $Res Function(_$FirewallResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FirewallResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rules = null,
    Object? accessPort = freezed,
    Object? directions = null,
  }) {
    return _then(_$FirewallResponseImpl(
      rules: null == rules
          ? _value._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<FirewallRule>,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
      directions: null == directions
          ? _value._directions
          : directions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirewallResponseImpl implements _FirewallResponse {
  const _$FirewallResponseImpl(
      {final List<FirewallRule> rules = const <FirewallRule>[],
      @JsonKey(name: 'access_port') this.accessPort,
      final List<String> directions = const <String>[]})
      : _rules = rules,
        _directions = directions;

  factory _$FirewallResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirewallResponseImplFromJson(json);

  final List<FirewallRule> _rules;
  @override
  @JsonKey()
  List<FirewallRule> get rules {
    if (_rules is EqualUnmodifiableListView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rules);
  }

  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;
  final List<String> _directions;
  @override
  @JsonKey()
  List<String> get directions {
    if (_directions is EqualUnmodifiableListView) return _directions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directions);
  }

  @override
  String toString() {
    return 'FirewallResponse(rules: $rules, accessPort: $accessPort, directions: $directions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirewallResponseImpl &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort) &&
            const DeepCollectionEquality()
                .equals(other._directions, _directions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_rules),
      accessPort,
      const DeepCollectionEquality().hash(_directions));

  /// Create a copy of FirewallResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FirewallResponseImplCopyWith<_$FirewallResponseImpl> get copyWith =>
      __$$FirewallResponseImplCopyWithImpl<_$FirewallResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirewallResponseImplToJson(
      this,
    );
  }
}

abstract class _FirewallResponse implements FirewallResponse {
  const factory _FirewallResponse(
      {final List<FirewallRule> rules,
      @JsonKey(name: 'access_port') final int? accessPort,
      final List<String> directions}) = _$FirewallResponseImpl;

  factory _FirewallResponse.fromJson(Map<String, dynamic> json) =
      _$FirewallResponseImpl.fromJson;

  @override
  List<FirewallRule> get rules;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;
  @override
  List<String> get directions;

  /// Create a copy of FirewallResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FirewallResponseImplCopyWith<_$FirewallResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FirewallAddResult _$FirewallAddResultFromJson(Map<String, dynamic> json) {
  return _FirewallAddResult.fromJson(json);
}

/// @nodoc
mixin _$FirewallAddResult {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  FirewallDirection? get direction => throw _privateConstructorUsedError;
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  FirewallProtocol? get protocol => throw _privateConstructorUsedError;
  @JsonKey(name: 'port_start')
  int? get portStart => throw _privateConstructorUsedError;
  @JsonKey(name: 'port_end')
  int? get portEnd => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_cidr')
  String? get sourceCidr => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_port')
  int? get accessPort => throw _privateConstructorUsedError;

  /// Serializes this FirewallAddResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FirewallAddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FirewallAddResultCopyWith<FirewallAddResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirewallAddResultCopyWith<$Res> {
  factory $FirewallAddResultCopyWith(
          FirewallAddResult value, $Res Function(FirewallAddResult) then) =
      _$FirewallAddResultCopyWithImpl<$Res, FirewallAddResult>;
  @useResult
  $Res call(
      {String? message,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') int? portStart,
      @JsonKey(name: 'port_end') int? portEnd,
      @JsonKey(name: 'source_cidr') String? sourceCidr,
      @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class _$FirewallAddResultCopyWithImpl<$Res, $Val extends FirewallAddResult>
    implements $FirewallAddResultCopyWith<$Res> {
  _$FirewallAddResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FirewallAddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? direction = freezed,
    Object? protocol = freezed,
    Object? portStart = freezed,
    Object? portEnd = freezed,
    Object? sourceCidr = freezed,
    Object? accessPort = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as FirewallDirection?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as FirewallProtocol?,
      portStart: freezed == portStart
          ? _value.portStart
          : portStart // ignore: cast_nullable_to_non_nullable
              as int?,
      portEnd: freezed == portEnd
          ? _value.portEnd
          : portEnd // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceCidr: freezed == sourceCidr
          ? _value.sourceCidr
          : sourceCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirewallAddResultImplCopyWith<$Res>
    implements $FirewallAddResultCopyWith<$Res> {
  factory _$$FirewallAddResultImplCopyWith(_$FirewallAddResultImpl value,
          $Res Function(_$FirewallAddResultImpl) then) =
      __$$FirewallAddResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') int? portStart,
      @JsonKey(name: 'port_end') int? portEnd,
      @JsonKey(name: 'source_cidr') String? sourceCidr,
      @JsonKey(name: 'access_port') int? accessPort});
}

/// @nodoc
class __$$FirewallAddResultImplCopyWithImpl<$Res>
    extends _$FirewallAddResultCopyWithImpl<$Res, _$FirewallAddResultImpl>
    implements _$$FirewallAddResultImplCopyWith<$Res> {
  __$$FirewallAddResultImplCopyWithImpl(_$FirewallAddResultImpl _value,
      $Res Function(_$FirewallAddResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of FirewallAddResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? direction = freezed,
    Object? protocol = freezed,
    Object? portStart = freezed,
    Object? portEnd = freezed,
    Object? sourceCidr = freezed,
    Object? accessPort = freezed,
  }) {
    return _then(_$FirewallAddResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: freezed == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as FirewallDirection?,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as FirewallProtocol?,
      portStart: freezed == portStart
          ? _value.portStart
          : portStart // ignore: cast_nullable_to_non_nullable
              as int?,
      portEnd: freezed == portEnd
          ? _value.portEnd
          : portEnd // ignore: cast_nullable_to_non_nullable
              as int?,
      sourceCidr: freezed == sourceCidr
          ? _value.sourceCidr
          : sourceCidr // ignore: cast_nullable_to_non_nullable
              as String?,
      accessPort: freezed == accessPort
          ? _value.accessPort
          : accessPort // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirewallAddResultImpl implements _FirewallAddResult {
  const _$FirewallAddResultImpl(
      {this.message,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      this.direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      this.protocol,
      @JsonKey(name: 'port_start') this.portStart,
      @JsonKey(name: 'port_end') this.portEnd,
      @JsonKey(name: 'source_cidr') this.sourceCidr,
      @JsonKey(name: 'access_port') this.accessPort});

  factory _$FirewallAddResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirewallAddResultImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  final FirewallDirection? direction;
  @override
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  final FirewallProtocol? protocol;
  @override
  @JsonKey(name: 'port_start')
  final int? portStart;
  @override
  @JsonKey(name: 'port_end')
  final int? portEnd;
  @override
  @JsonKey(name: 'source_cidr')
  final String? sourceCidr;
  @override
  @JsonKey(name: 'access_port')
  final int? accessPort;

  @override
  String toString() {
    return 'FirewallAddResult(message: $message, direction: $direction, protocol: $protocol, portStart: $portStart, portEnd: $portEnd, sourceCidr: $sourceCidr, accessPort: $accessPort)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirewallAddResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.portStart, portStart) ||
                other.portStart == portStart) &&
            (identical(other.portEnd, portEnd) || other.portEnd == portEnd) &&
            (identical(other.sourceCidr, sourceCidr) ||
                other.sourceCidr == sourceCidr) &&
            (identical(other.accessPort, accessPort) ||
                other.accessPort == accessPort));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, direction, protocol,
      portStart, portEnd, sourceCidr, accessPort);

  /// Create a copy of FirewallAddResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FirewallAddResultImplCopyWith<_$FirewallAddResultImpl> get copyWith =>
      __$$FirewallAddResultImplCopyWithImpl<_$FirewallAddResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirewallAddResultImplToJson(
      this,
    );
  }
}

abstract class _FirewallAddResult implements FirewallAddResult {
  const factory _FirewallAddResult(
      {final String? message,
      @JsonKey(
          fromJson: FirewallDirection.fromJson,
          toJson: FirewallDirection.toJson)
      final FirewallDirection? direction,
      @JsonKey(
          fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
      final FirewallProtocol? protocol,
      @JsonKey(name: 'port_start') final int? portStart,
      @JsonKey(name: 'port_end') final int? portEnd,
      @JsonKey(name: 'source_cidr') final String? sourceCidr,
      @JsonKey(name: 'access_port')
      final int? accessPort}) = _$FirewallAddResultImpl;

  factory _FirewallAddResult.fromJson(Map<String, dynamic> json) =
      _$FirewallAddResultImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(
      fromJson: FirewallDirection.fromJson, toJson: FirewallDirection.toJson)
  FirewallDirection? get direction;
  @override
  @JsonKey(fromJson: FirewallProtocol.fromJson, toJson: FirewallProtocol.toJson)
  FirewallProtocol? get protocol;
  @override
  @JsonKey(name: 'port_start')
  int? get portStart;
  @override
  @JsonKey(name: 'port_end')
  int? get portEnd;
  @override
  @JsonKey(name: 'source_cidr')
  String? get sourceCidr;
  @override
  @JsonKey(name: 'access_port')
  int? get accessPort;

  /// Create a copy of FirewallAddResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FirewallAddResultImplCopyWith<_$FirewallAddResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FirewallRemoveResult _$FirewallRemoveResultFromJson(Map<String, dynamic> json) {
  return _FirewallRemoveResult.fromJson(json);
}

/// @nodoc
mixin _$FirewallRemoveResult {
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'rule_id')
  int? get ruleId => throw _privateConstructorUsedError;
  bool? get removed => throw _privateConstructorUsedError;

  /// Serializes this FirewallRemoveResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FirewallRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FirewallRemoveResultCopyWith<FirewallRemoveResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirewallRemoveResultCopyWith<$Res> {
  factory $FirewallRemoveResultCopyWith(FirewallRemoveResult value,
          $Res Function(FirewallRemoveResult) then) =
      _$FirewallRemoveResultCopyWithImpl<$Res, FirewallRemoveResult>;
  @useResult
  $Res call(
      {String? message, @JsonKey(name: 'rule_id') int? ruleId, bool? removed});
}

/// @nodoc
class _$FirewallRemoveResultCopyWithImpl<$Res,
        $Val extends FirewallRemoveResult>
    implements $FirewallRemoveResultCopyWith<$Res> {
  _$FirewallRemoveResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FirewallRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ruleId = freezed,
    Object? removed = freezed,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ruleId: freezed == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as int?,
      removed: freezed == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirewallRemoveResultImplCopyWith<$Res>
    implements $FirewallRemoveResultCopyWith<$Res> {
  factory _$$FirewallRemoveResultImplCopyWith(_$FirewallRemoveResultImpl value,
          $Res Function(_$FirewallRemoveResultImpl) then) =
      __$$FirewallRemoveResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? message, @JsonKey(name: 'rule_id') int? ruleId, bool? removed});
}

/// @nodoc
class __$$FirewallRemoveResultImplCopyWithImpl<$Res>
    extends _$FirewallRemoveResultCopyWithImpl<$Res, _$FirewallRemoveResultImpl>
    implements _$$FirewallRemoveResultImplCopyWith<$Res> {
  __$$FirewallRemoveResultImplCopyWithImpl(_$FirewallRemoveResultImpl _value,
      $Res Function(_$FirewallRemoveResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of FirewallRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? ruleId = freezed,
    Object? removed = freezed,
  }) {
    return _then(_$FirewallRemoveResultImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      ruleId: freezed == ruleId
          ? _value.ruleId
          : ruleId // ignore: cast_nullable_to_non_nullable
              as int?,
      removed: freezed == removed
          ? _value.removed
          : removed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirewallRemoveResultImpl implements _FirewallRemoveResult {
  const _$FirewallRemoveResultImpl(
      {this.message, @JsonKey(name: 'rule_id') this.ruleId, this.removed});

  factory _$FirewallRemoveResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirewallRemoveResultImplFromJson(json);

  @override
  final String? message;
  @override
  @JsonKey(name: 'rule_id')
  final int? ruleId;
  @override
  final bool? removed;

  @override
  String toString() {
    return 'FirewallRemoveResult(message: $message, ruleId: $ruleId, removed: $removed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirewallRemoveResultImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.ruleId, ruleId) || other.ruleId == ruleId) &&
            (identical(other.removed, removed) || other.removed == removed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, ruleId, removed);

  /// Create a copy of FirewallRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FirewallRemoveResultImplCopyWith<_$FirewallRemoveResultImpl>
      get copyWith =>
          __$$FirewallRemoveResultImplCopyWithImpl<_$FirewallRemoveResultImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirewallRemoveResultImplToJson(
      this,
    );
  }
}

abstract class _FirewallRemoveResult implements FirewallRemoveResult {
  const factory _FirewallRemoveResult(
      {final String? message,
      @JsonKey(name: 'rule_id') final int? ruleId,
      final bool? removed}) = _$FirewallRemoveResultImpl;

  factory _FirewallRemoveResult.fromJson(Map<String, dynamic> json) =
      _$FirewallRemoveResultImpl.fromJson;

  @override
  String? get message;
  @override
  @JsonKey(name: 'rule_id')
  int? get ruleId;
  @override
  bool? get removed;

  /// Create a copy of FirewallRemoveResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FirewallRemoveResultImplCopyWith<_$FirewallRemoveResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
