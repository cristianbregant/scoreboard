import 'package:scoreboard/api/error/api_error.dart';
import 'package:dio/dio.dart';

class ApiErrorManager {
  /// Builds an [ApiError] from a failed request. A JSON error body with
  /// `code`, `message` and `details` fields is used when present.
  static ApiError parseErrorMessage(dynamic source) {
    int? errorCode;
    String? errorMessage;
    int statusCode = -1;
    Map<String, dynamic>? details;

    if (source is DioException) {
      final response = source.response;
      statusCode = response?.statusCode ?? -1;
      final body = response?.data;
      if (body is Map<String, dynamic>) {
        final code = body['code'];
        final message = body['message'];
        final extra = body['details'];
        if (code is int) errorCode = code;
        if (message is String) errorMessage = message;
        if (extra is Map<String, dynamic>) details = extra;
      }
      errorMessage ??= source.message;
    }

    return ApiError(
      code: errorCode ?? 0,
      message: errorMessage ?? 'An unknown error occurred.',
      statusCode: statusCode,
      details: details,
    );
  }
}
