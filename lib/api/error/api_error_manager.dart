import 'package:scoreboard/api/error/api_error.dart';
import 'package:dio/dio.dart';

class ApiErrorManager {
  static ApiError parseErrorMessage(dynamic source) {
    int? errorCode;
    String? errorMessage;
    int statusCode = -1;
    Map<String, dynamic>? details;

    if (source is DioException) {
      final response = source.response;
      final Map<String, dynamic> responseBody = response?.data;
    }

    return ApiError(
      code: errorCode ?? 0,
      message: errorMessage ?? 'An unknown error occurred.',
      statusCode: statusCode,
      details: details,
    );
  }
}
