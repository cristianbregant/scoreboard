import 'package:dio/dio.dart';
import 'package:scoreboard/model/release.dart';

/// Reads the latest release published on GitHub.
class UpdateService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Accept': 'application/vnd.github+json'},
  ));

  /// Null when the repository has no release yet.
  Future<ReleaseInfo?> latestRelease(String repository) async {
    try {
      final response = await _dio
          .get('https://api.github.com/repos/$repository/releases/latest');
      final data = response.data as Map<String, dynamic>;
      return ReleaseInfo(
        version: (data['tag_name'] as String).replaceFirst(RegExp('^v'), ''),
        url: Uri.parse(data['html_url'] as String),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  }
}
