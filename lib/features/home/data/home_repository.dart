import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_error.dart';
import 'models/home_summary.dart';

/// Dashboard summary (§6.10).
class HomeRepository {
  HomeRepository(this._client);

  final ApiClient _client;

  Future<HomeSummary> summary() async {
    try {
      final response = await _client.dio.get<Map<String, dynamic>>('home');
      return HomeSummary.fromJson(response.data!);
    } on DioException catch (e) {
      throw ApiError.fromDio(e);
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepository(ref.watch(apiClientProvider)),
);
