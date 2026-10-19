import 'package:dio/dio.dart';

/// Normalised API failure.
///
/// Every failure from the API arrives as
/// `{"error":"<human>","code":"<MACHINE>","request_id":"<16hex>"}`
/// (FLUTTER_API_GUIDE §4). Non-API failures (timeouts, sockets) are mapped to
/// synthetic codes so the UI always has something human-readable.
class ApiError implements Exception {
  const ApiError({
    required this.code,
    required this.message,
    this.requestId,
    this.statusCode,
    this.retryAfterSeconds,
  });

  final String code;
  final String message;
  final String? requestId;
  final int? statusCode;

  /// Parsed from the `Retry-After` header on 429 (seconds).
  final int? retryAfterSeconds;

  factory ApiError.fromDio(DioException e) {
    final response = e.response;
    final status = response?.statusCode;
    final headers = response?.headers;

    final retryAfter = _parseRetryAfter(headers?.value('retry-after'));

    final data = response?.data;
    if (data is Map) {
      final map = data.cast<dynamic, dynamic>();
      final code = map['code']?.toString();
      final message = map['error']?.toString();
      if (code != null && message != null) {
        return ApiError(
          code: code,
          message: message,
          requestId: map['request_id']?.toString(),
          statusCode: status,
          retryAfterSeconds: retryAfter,
        );
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiError(
          code: 'TIMEOUT',
          message: 'The request timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const ApiError(
          code: 'NETWORK_ERROR',
          message: 'Could not reach the server. Check your connection.',
        );
      case DioExceptionType.cancel:
        return const ApiError(code: 'CANCELLED', message: 'Request cancelled.');
      case DioExceptionType.badCertificate:
        return const ApiError(
          code: 'BAD_CERTIFICATE',
          message: 'The server certificate could not be verified.',
        );
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        break;
    }

    if (status == 429) {
      return ApiError(
        code: 'RATE_LIMITED',
        message: 'Too many requests. Please slow down.',
        statusCode: status,
        retryAfterSeconds: retryAfter,
      );
    }

    return ApiError(
      code: 'SERVER_ERROR',
      message: 'Something went wrong on the server.',
      statusCode: status,
      retryAfterSeconds: retryAfter,
    );
  }

  static int? _parseRetryAfter(String? raw) {
    if (raw == null) return null;
    final seconds = int.tryParse(raw.trim());
    if (seconds != null) return seconds;
    // `Retry-After` may also be an HTTP date.
    final date = DateTime.tryParse(raw.trim());
    if (date != null) {
      final diff = date.difference(DateTime.now().toUtc()).inSeconds;
      return diff > 0 ? diff : null;
    }
    return null;
  }

  /// User-facing message, applying the per-code overrides from the task spec.
  String get userMessage {
    switch (code) {
      case 'VALIDATION_FAILED':
        return message; // server names the offending field
      case 'INVALID_CIDR':
        return message.isNotEmpty ? message : 'That IP or CIDR is not valid.';
      case 'INSUFFICIENT_BALANCE':
        return 'Insufficient wallet balance. Top up your wallet.';
      case 'REAUTH_REQUIRED':
        return 'Please confirm your password to continue.';
      case 'NOT_FOUND':
      case 'SERVER_NOT_FOUND':
      case 'ORDER_NOT_FOUND':
        return "Not found or you don't have access.";
      case 'NO_CREDENTIALS':
        return 'No credentials stored. Try regenerate.';
      case 'SERVER_NOT_ACTIVE':
        return 'Server is not ready yet.';
      case 'CONFLICT':
        return message.isNotEmpty ? message : 'This action conflicts with the current state.';
      case 'IDEMPOTENCY_MISMATCH':
        return 'That request was already submitted differently. Retrying.';
      case 'RATE_LIMITED':
        return retryAfterSeconds != null
            ? 'Too many requests, wait ${retryAfterSeconds}s.'
            : 'Too many requests. Please slow down.';
      case 'PROVIDER_ERROR':
        return 'Provider unreachable. Try again in a moment.';
      case 'SERVER_ERROR':
      case 'DB_ERROR':
        return 'Something went wrong on the server.';
      case 'AUTH_REQUIRED':
        return 'Please sign in again.';
      case 'TOKEN_EXPIRED':
        return 'Your session expired. Please sign in again.';
      case 'SESSION_REVOKED':
        return 'Your session was revoked. Please sign in again.';
      default:
        return message.isNotEmpty ? message : 'Unexpected error.';
    }
  }

  @override
  String toString() => 'ApiError($code, $statusCode): $message';
}
