// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloud_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CloudImageImpl _$$CloudImageImplFromJson(Map<String, dynamic> json) =>
    _$CloudImageImpl(
      slug: json['slug'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CloudImageImplToJson(_$CloudImageImpl instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
    };

_$ImagesResponseImpl _$$ImagesResponseImplFromJson(Map<String, dynamic> json) =>
    _$ImagesResponseImpl(
      defaultSlug: json['default'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => CloudImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ImagesResponseImplToJson(
        _$ImagesResponseImpl instance) =>
    <String, dynamic>{
      'default': instance.defaultSlug,
      'images': instance.images,
    };
