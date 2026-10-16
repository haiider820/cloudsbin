import 'package:flutter_test/flutter_test.dart';

import 'package:cloudsbin/core/api/api_client.dart';

import '../helpers/fakes.dart';

/// Regression: Dio joins `baseUrl + path` literally. Without a trailing slash
/// on the base URL, `auth/login` became `/api/v1auth/login` and every request
/// 404'd on the live backend — masked in tests because mock adapters never
/// validate the URL.
void main() {
  ScriptedAdapter installAdapter(ApiClient client) {
    final adapter = ScriptedAdapter([
      const ScriptedResponse(200, {'ok': true}),
    ]);
    client.dio.httpClientAdapter = adapter;
    return adapter;
  }

  test('joins relative endpoint paths onto the base URL with a slash',
      () async {
    final client = ApiClient(
      storage: MemorySecureStorage(),
      appVersion: '1.0.0',
    );
    final adapter = installAdapter(client);

    await client.dio.post<dynamic>('auth/login', data: const {});

    expect(
      adapter.requests.single.uri.toString(),
      'https://cloudsbin.duckdns.org/api/v1/auth/login',
    );
  });

  test('does not double the slash when the base URL already ends with one',
      () async {
    final client = ApiClient(
      storage: MemorySecureStorage(),
      appVersion: '1.0.0',
      baseUrl: 'https://example.test/api/v1/',
    );
    final adapter = installAdapter(client);

    await client.dio.get<dynamic>('servers');

    expect(
      adapter.requests.single.uri.toString(),
      'https://example.test/api/v1/servers',
    );
  });
}
