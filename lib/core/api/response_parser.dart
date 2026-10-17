import 'package:dio/dio.dart';

import 'api_error.dart';

/// Safely extracts a JSON object body from a successful [response] and hands
/// it to [fromJson].
///
/// Repositories used to force-unwrap `response.data!`, which turned an empty
/// or non-object 2xx body (a 500 handled upstream, a `204`, a stray HTML
/// payload) into a raw `Null check operator used on a null value` /
/// `TypeError` that callers never catch. Every failure here is normalised to
/// an [ApiError] with code `SERVER_ERROR`, so screens show a real message
/// instead of hanging on a spinner.
T parseResponse<T>(
  Response<dynamic> response,
  T Function(Map<String, dynamic>) fromJson,
) {
  final data = response.data;
  if (data == null) {
    throw ApiError(
      code: 'SERVER_ERROR',
      message: 'Empty response from server.',
      statusCode: response.statusCode ?? 500,
    );
  }
  if (data is! Map<String, dynamic>) {
    throw ApiError(
      code: 'SERVER_ERROR',
      message: 'Unexpected response format.',
      statusCode: response.statusCode ?? 500,
    );
  }
  return fromJson(data);
}
