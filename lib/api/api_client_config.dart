import 'package:scoreboard/api/error/api_error_manager.dart';
import 'package:dio/dio.dart';

class ApiClientConfig {
  static Future<Response> sendRequest(Future<Response> request) async {
    Response? response;
    try {
      response = await request;
      return response;
    } catch (e) {
      dynamic errorToParse;
      if (e is DioException) {
        errorToParse = e;
      }
      throw ApiErrorManager.parseErrorMessage(errorToParse);
    }
  }
}
