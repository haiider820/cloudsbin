import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:cloudsbin/core/storage/secure_storage.dart';

/// One scripted HTTP answer for [ScriptedAdapter].
class ScriptedResponse {
  const ScriptedResponse(
    this.status,
    this.body, {
    this.headers = const {},
    this.gate,
  });

  final int status;
  final Map<String, dynamic> body;
  final Map<String, List<String>> headers;

  /// When set, the adapter parks on this future before answering — lets a
  /// widget test observe the in-flight (loading) state of a request.
  final Completer<void>? gate;
}

/// Dio adapter that replays a fixed script and records every request, so
/// tests can assert outgoing payloads exactly as production sends them.
class ScriptedAdapter implements HttpClientAdapter {
  ScriptedAdapter(Iterable<ScriptedResponse> script)
      : _script = Queue.of(script);

  final Queue<ScriptedResponse> _script;
  final List<RequestOptions> requests = [];

  int get calls => requests.length;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final next = _script.removeFirst();
    final gate = next.gate;
    if (gate != null) await gate.future;
    return ResponseBody.fromString(
      jsonEncode(next.body),
      next.status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        ...next.headers,
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// In-memory secure storage — never touches the platform channel.
class MemorySecureStorage extends SecureStorage {
  MemorySecureStorage() : super(const FlutterSecureStorage());

  final Map<String, String> values = {};

  @override
  Future<String?> readAccessToken(TokenKeys keys) async => values[keys.access];

  @override
  Future<String?> readRefreshToken(TokenKeys keys) async =>
      values[keys.refresh];

  @override
  Future<void> writeTokens(
    TokenKeys keys, {
    required String accessToken,
    required String refreshToken,
  }) async {
    values[keys.access] = accessToken;
    values[keys.refresh] = refreshToken;
  }

  @override
  Future<void> clearTokens(TokenKeys keys) async {
    values.remove(keys.access);
    values.remove(keys.refresh);
  }

  @override
  Future<String> getOrCreateDeviceId([TokenKeys keys = TokenKeys.user]) async {
    final existing = values[keys.device];
    if (existing != null && existing.isNotEmpty) return existing;
    const created = 'test-device-id';
    values[keys.device] = created;
    return created;
  }
}
