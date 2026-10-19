import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_error.dart';
import 'package:cloudsbin/core/api/response_parser.dart';

Response<dynamic> _response(dynamic data, {int? status}) => Response<dynamic>(
      requestOptions: RequestOptions(path: '/x'),
      data: data,
      statusCode: status ?? 200,
    );

void main() {
  group('parseResponse', () {
    test('parses a valid JSON object body', () {
      final result = parseResponse<Map<String, dynamic>>(
        _response({'id': 7, 'name': 'box'}),
        (json) => json,
      );
      expect(result, {'id': 7, 'name': 'box'});
    });

    test('null body throws SERVER_ERROR with the response status', () {
      expect(
        () => parseResponse<Map<String, dynamic>>(
          _response(null, status: 500),
          (json) => json,
        ),
        throwsA(
          isA<ApiError>()
              .having((e) => e.code, 'code', 'SERVER_ERROR')
              .having((e) => e.statusCode, 'statusCode', 500),
        ),
      );
    });

    test('non-object body throws SERVER_ERROR', () {
      expect(
        () => parseResponse<Map<String, dynamic>>(
          _response('<html>oops</html>'),
          (json) => json,
        ),
        throwsA(isA<ApiError>().having((e) => e.code, 'code', 'SERVER_ERROR')),
      );
    });

    test('list body throws SERVER_ERROR (not a Map)', () {
      expect(
        () => parseResponse<Map<String, dynamic>>(
          _response([1, 2, 3]),
          (json) => json,
        ),
        throwsA(isA<ApiError>()),
      );
    });
  });
}
