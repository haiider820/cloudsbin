// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cloud_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CloudImage _$CloudImageFromJson(Map<String, dynamic> json) {
  return _CloudImage.fromJson(json);
}

/// @nodoc
mixin _$CloudImage {
  String get slug => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this CloudImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CloudImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CloudImageCopyWith<CloudImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CloudImageCopyWith<$Res> {
  factory $CloudImageCopyWith(
          CloudImage value, $Res Function(CloudImage) then) =
      _$CloudImageCopyWithImpl<$Res, CloudImage>;
  @useResult
  $Res call({String slug, String name});
}

/// @nodoc
class _$CloudImageCopyWithImpl<$Res, $Val extends CloudImage>
    implements $CloudImageCopyWith<$Res> {
  _$CloudImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CloudImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CloudImageImplCopyWith<$Res>
    implements $CloudImageCopyWith<$Res> {
  factory _$$CloudImageImplCopyWith(
          _$CloudImageImpl value, $Res Function(_$CloudImageImpl) then) =
      __$$CloudImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String slug, String name});
}

/// @nodoc
class __$$CloudImageImplCopyWithImpl<$Res>
    extends _$CloudImageCopyWithImpl<$Res, _$CloudImageImpl>
    implements _$$CloudImageImplCopyWith<$Res> {
  __$$CloudImageImplCopyWithImpl(
      _$CloudImageImpl _value, $Res Function(_$CloudImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of CloudImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slug = null,
    Object? name = null,
  }) {
    return _then(_$CloudImageImpl(
      slug: null == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CloudImageImpl implements _CloudImage {
  const _$CloudImageImpl({required this.slug, required this.name});

  factory _$CloudImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CloudImageImplFromJson(json);

  @override
  final String slug;
  @override
  final String name;

  @override
  String toString() {
    return 'CloudImage(slug: $slug, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CloudImageImpl &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slug, name);

  /// Create a copy of CloudImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CloudImageImplCopyWith<_$CloudImageImpl> get copyWith =>
      __$$CloudImageImplCopyWithImpl<_$CloudImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CloudImageImplToJson(
      this,
    );
  }
}

abstract class _CloudImage implements CloudImage {
  const factory _CloudImage(
      {required final String slug,
      required final String name}) = _$CloudImageImpl;

  factory _CloudImage.fromJson(Map<String, dynamic> json) =
      _$CloudImageImpl.fromJson;

  @override
  String get slug;
  @override
  String get name;

  /// Create a copy of CloudImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CloudImageImplCopyWith<_$CloudImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ImagesResponse _$ImagesResponseFromJson(Map<String, dynamic> json) {
  return _ImagesResponse.fromJson(json);
}

/// @nodoc
mixin _$ImagesResponse {
  @JsonKey(name: 'default')
  String? get defaultSlug => throw _privateConstructorUsedError;
  List<CloudImage> get images => throw _privateConstructorUsedError;

  /// Serializes this ImagesResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ImagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ImagesResponseCopyWith<ImagesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesResponseCopyWith<$Res> {
  factory $ImagesResponseCopyWith(
          ImagesResponse value, $Res Function(ImagesResponse) then) =
      _$ImagesResponseCopyWithImpl<$Res, ImagesResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'default') String? defaultSlug, List<CloudImage> images});
}

/// @nodoc
class _$ImagesResponseCopyWithImpl<$Res, $Val extends ImagesResponse>
    implements $ImagesResponseCopyWith<$Res> {
  _$ImagesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ImagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultSlug = freezed,
    Object? images = null,
  }) {
    return _then(_value.copyWith(
      defaultSlug: freezed == defaultSlug
          ? _value.defaultSlug
          : defaultSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<CloudImage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImagesResponseImplCopyWith<$Res>
    implements $ImagesResponseCopyWith<$Res> {
  factory _$$ImagesResponseImplCopyWith(_$ImagesResponseImpl value,
          $Res Function(_$ImagesResponseImpl) then) =
      __$$ImagesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'default') String? defaultSlug, List<CloudImage> images});
}

/// @nodoc
class __$$ImagesResponseImplCopyWithImpl<$Res>
    extends _$ImagesResponseCopyWithImpl<$Res, _$ImagesResponseImpl>
    implements _$$ImagesResponseImplCopyWith<$Res> {
  __$$ImagesResponseImplCopyWithImpl(
      _$ImagesResponseImpl _value, $Res Function(_$ImagesResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ImagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? defaultSlug = freezed,
    Object? images = null,
  }) {
    return _then(_$ImagesResponseImpl(
      defaultSlug: freezed == defaultSlug
          ? _value.defaultSlug
          : defaultSlug // ignore: cast_nullable_to_non_nullable
              as String?,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<CloudImage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImagesResponseImpl implements _ImagesResponse {
  const _$ImagesResponseImpl(
      {@JsonKey(name: 'default') this.defaultSlug,
      final List<CloudImage> images = const []})
      : _images = images;

  factory _$ImagesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImagesResponseImplFromJson(json);

  @override
  @JsonKey(name: 'default')
  final String? defaultSlug;
  final List<CloudImage> _images;
  @override
  @JsonKey()
  List<CloudImage> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  String toString() {
    return 'ImagesResponse(defaultSlug: $defaultSlug, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImagesResponseImpl &&
            (identical(other.defaultSlug, defaultSlug) ||
                other.defaultSlug == defaultSlug) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, defaultSlug, const DeepCollectionEquality().hash(_images));

  /// Create a copy of ImagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ImagesResponseImplCopyWith<_$ImagesResponseImpl> get copyWith =>
      __$$ImagesResponseImplCopyWithImpl<_$ImagesResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImagesResponseImplToJson(
      this,
    );
  }
}

abstract class _ImagesResponse implements ImagesResponse {
  const factory _ImagesResponse(
      {@JsonKey(name: 'default') final String? defaultSlug,
      final List<CloudImage> images}) = _$ImagesResponseImpl;

  factory _ImagesResponse.fromJson(Map<String, dynamic> json) =
      _$ImagesResponseImpl.fromJson;

  @override
  @JsonKey(name: 'default')
  String? get defaultSlug;
  @override
  List<CloudImage> get images;

  /// Create a copy of ImagesResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ImagesResponseImplCopyWith<_$ImagesResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
