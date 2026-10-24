import 'package:scoreboard/api/error/api_error.dart';
import 'package:dio/dio.dart';

class ApiErrorManager {
  /// Builds an [ApiError] from a failed request. The Scoreboard backend
  /// answers `{"error": {"type": …, "code": …}}`; that object becomes
  /// [ApiError.details] and its code the message.
  static ApiError parseErrorMessage(dynamic source) {
    String? errorMessage;
    int statusCode = -1;
    Map<String, dynamic>? details;

    if (source is DioException) {
      final response = source.response;
      statusCode = response?.statusCode ?? -1;
      final body = response?.data;
      if (body is Map<String, dynamic>) {
        final error = body['error'];
        if (error is Map<String, dynamic>) {
          details = error;
          if (error['code'] is String) errorMessage = error['code'];
        }
      }
      errorMessage ??= source.message;
    }

    return ApiError(
      code: 0,
      message: errorMessage ?? 'An unknown error occurred.',
      statusCode: statusCode,
      details: details,
    );
  }
}
