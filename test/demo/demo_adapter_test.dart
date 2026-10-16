import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/demo/demo_adapter.dart';

/// Calls the adapter exactly like Dio would and returns the decoded JSON.
Future<(int, Map<String, dynamic>)> _call(
  DemoAdapter adapter,
  String method,
  String path, {
  Object? data,
  Map<String, dynamic>? query,
}) async {
  final response = await adapter.fetch(
    RequestOptions(
      baseUrl: 'http://demo.local/api/v1',
      path: path,
      method: method,
      data: data,
      queryParameters: query,
    ),
    null,
    null,
  );
  final bytes = await response.stream
      .fold<List<int>>(<int>[], (acc, chunk) => acc..addAll(chunk));
  final json = jsonDecode(utf8.decode(bytes));
  return (response.statusCode, json as Map<String, dynamic>);
}

DemoAdapter _adapter() {
  final adapter = DemoAdapter(latency: Duration.zero);
  addTearDown(adapter.close);
  return adapter;
}

void main() {
  group('DemoAdapter', () {
    test('login answers a token pair and user', () async {
      final (status, body) =
          await _call(_adapter(), 'POST', '/auth/login', data: const {});

      expect(status, 200);
      expect(body['access_token'], 'demo-access-token');
      expect(body['refresh_token'], 'demo-refresh-token');
      expect((body['user'] as Map)['role'], 'user');
    });

    test('servers/list returns the three sample servers', () async {
      final (status, body) = await _call(_adapter(), 'GET', '/servers/list');

      expect(status, 200);
      final items = body['items'] as List;
      expect(items, hasLength(3));
      expect(body['total'], 3);
      expect(body['has_more'], isFalse);
      expect(items.first['status'], 'active');
      expect(items.last['status'], 'destroyed');
    });

    test('power stop echoes and drives detail/list/refresh to stopping',
        () async {
      final adapter = _adapter();

      final (status, body) = await _call(
        adapter,
        'POST',
        '/servers/power',
        data: {'server_id': 9206568, 'action': 'stop'},
      );
      expect(status, 200);
      expect(body, {
        'action': 'stop',
        'status': 'stopping',
        'server_id': 9206568,
      });

      final (_, detail) = await _call(
        adapter,
        'GET',
        '/servers/detail',
        query: {'id': '9206568'},
      );
      expect(detail['status'], 'stopping');

      final (_, list) = await _call(adapter, 'GET', '/servers/list');
      expect((list['items'] as List).first['status'], 'stopping');

      final (_, refresh) = await _call(
        adapter,
        'POST',
        '/servers/refresh',
        data: {'server_id': 9206568},
      );
      expect(refresh['status'], 'stopping');
    });

    test('unknown action → 400 INVALID_ACTION', () async {
      final (status, body) = await _call(
        _adapter(),
        'POST',
        '/servers/power',
        data: {'server_id': 9206568, 'action': 'explode'},
      );

      expect(status, 400);
      expect(body['code'], 'INVALID_ACTION');
      expect(body['error'], contains('stop, start, reboot'));
    });

    test('unknown endpoint → 404 NOT_FOUND naming the route', () async {
      final (status, body) =
          await _call(_adapter(), 'GET', '/no/such/endpoint');

      expect(status, 404);
      expect(body['code'], 'NOT_FOUND');
      expect(body['error'], contains('/no/such/endpoint'));
    });

    test('register answers the neutral 202', () async {
      final (status, body) = await _call(
        _adapter(),
        'POST',
        '/auth/register',
        data: const {},
      );

      expect(status, 202);
      expect(body['message'], isNotEmpty);
    });

    test('plans/list carries both plans and the fx rate', () async {
      final (status, body) = await _call(_adapter(), 'GET', '/plans/list');

      expect(status, 200);
      expect((body['items'] as List), hasLength(2));
      expect(body['usd_pkr_rate'], 282.5);
    });
  });
}
