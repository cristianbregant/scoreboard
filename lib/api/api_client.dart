import 'package:scoreboard/api/api_client_config.dart';
import 'package:dio/dio.dart';

/// HTTP client for a future REST implementation of `ScoreboardRepository`.
/// Failed requests throw an `ApiError` (see `ApiErrorManager`).
class ApiClient {
  final Dio _dio = Dio();

  HttpClientAdapter get clientAdapter {
    return _dio.httpClientAdapter;
  }

  ApiClient() {
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) =>
      ApiClientConfig.sendRequest(_dio.get(path, queryParameters: query));

  Future<Response> post(String path, {Object? data}) =>
      ApiClientConfig.sendRequest(_dio.post(path, data: data));
}
