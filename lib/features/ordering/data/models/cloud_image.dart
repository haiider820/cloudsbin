import 'package:freezed_annotation/freezed_annotation.dart';

part 'cloud_image.freezed.dart';
part 'cloud_image.g.dart';

/// One item of `GET /images/list` (§6.13). Named `CloudImage` to avoid
/// clashing with Flutter's `Image` widget.
@freezed
class CloudImage with _$CloudImage {
  const factory CloudImage({
    required String slug,
    required String name,
  }) = _CloudImage;

  factory CloudImage.fromJson(Map<String, dynamic> json) =>
      _$CloudImageFromJson(json);
}

/// `GET /images/list` response: `{default, images}` — no envelope (§6.13).
@freezed
class ImagesResponse with _$ImagesResponse {
  const factory ImagesResponse({
    @JsonKey(name: 'default') String? defaultSlug,
    @Default([]) List<CloudImage> images,
  }) = _ImagesResponse;

  factory ImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseFromJson(json);
}
