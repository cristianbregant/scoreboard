import 'package:scoreboard/api/api_client_config.dart';
import 'package:dio/dio.dart';

/// HTTP client of the Scoreboard backend. Sends the session token returned
/// by [token], if any, and sends and receives JSON. Failed requests throw an
/// `ApiError` (see `ApiErrorManager`).
class ApiClient {
  final Dio _dio;

  HttpClientAdapter get clientAdapter {
    return _dio.httpClientAdapter;
  }

  set clientAdapter(HttpClientAdapter adapter) =>
      _dio.httpClientAdapter = adapter;

  ApiClient({required String baseUrl, required String? Function() token})
      : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      final value = token();
      if (value != null) options.headers['Authorization'] = 'Bearer $value';
      handler.next(options);
    }));
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) =>
      ApiClientConfig.sendRequest(_dio.get(path, queryParameters: query));

  Future<Response> post(String path,
          {Object? data, Map<String, dynamic>? query}) =>
      ApiClientConfig.sendRequest(
          _dio.post(path, data: data, queryParameters: query));

  Future<Response> put(String path, {Object? data}) =>
      ApiClientConfig.sendRequest(_dio.put(path, data: data));

  Future<Response> patch(String path, {Object? data}) =>
      ApiClientConfig.sendRequest(_dio.patch(path, data: data));

  Future<Response> delete(String path) =>
      ApiClientConfig.sendRequest(_dio.delete(path));
}
