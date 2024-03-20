import 'package:scoreboard/api/api_client_config.dart';
import 'package:dio/dio.dart';

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

  Future<Response> _sendRequest(Future<Response> request) async {
    return ApiClientConfig.sendRequest(request);
  }
}
