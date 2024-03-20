class ApiError {
  int code;
  String message;
  int statusCode;
  Map<String, dynamic>? details;

  ApiError(
      {required this.code,
      required this.message,
      required this.statusCode,
      this.details});
}
