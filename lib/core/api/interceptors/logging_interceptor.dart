import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Minimal request/response logger.
///
/// SECURITY: never log Authorization / X-Reauth-Token headers, bodies, or
/// query strings that could carry secrets. Only method, path, status, and a
/// timing line are emitted — and only in debug builds.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.enabled = kDebugMode});

  final bool enabled;

  static const _startKey = '_logging_start';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (enabled) {
      options.extra[_startKey] = DateTime.now().microsecondsSinceEpoch;
      debugPrint('→ ${options.method} ${_safePath(options)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (enabled) {
      final ms = _elapsed(response.requestOptions);
      debugPrint(
        '← ${response.statusCode} ${response.requestOptions.method} '
        '${_safePath(response.requestOptions)} (${ms}ms)',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enabled) {
      final ms = _elapsed(err.requestOptions);
      debugPrint(
        '✗ ${err.response?.statusCode ?? '-'} ${err.requestOptions.method} '
        '${_safePath(err.requestOptions)} (${ms}ms) ${err.type}',
      );
    }
    handler.next(err);
  }

  int _elapsed(RequestOptions options) {
    final start = options.extra[_startKey];
    if (start is int) {
      return (DateTime.now().microsecondsSinceEpoch - start) ~/ 1000;
    }
    return 0;
  }

  String _safePath(RequestOptions options) {
    final uri = options.uri;
    return uri.path;
  }
}
