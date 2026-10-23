import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// Keeps copies of profile images inside the app's support directory, so
/// they survive the user moving or deleting the original file.
class ImageStorageService {
  Future<Directory> _directory() async {
    final support = await getApplicationSupportDirectory();
    final directory = Directory('${support.path}/profile_images');
    if (!await directory.exists()) await directory.create(recursive: true);
    return directory;
  }

  /// Copies [sourcePath] and returns the path of the copy.
  Future<String> store(String sourcePath, {required String name}) async {
    final directory = await _directory();
    // Look for the extension in the file name only: folders can contain
    // dots, and Windows paths use backslashes.
    final fileName = sourcePath.split(RegExp(r'[\\/]')).last;
    final dot = fileName.lastIndexOf('.');
    final extension = dot == -1 ? '' : fileName.substring(dot);
    final target =
        '${directory.path}/${name}_${DateTime.now().millisecondsSinceEpoch}$extension';
    await File(sourcePath).copy(target);
    return target;
  }

  /// Deletes a copy made by [store]; other paths are left alone.
  Future<void> delete(String? path) async {
    if (path == null) return;
    final directory = await _directory();
    final file = File(path);
    if (path.startsWith(directory.path) && await file.exists()) {
      await file.delete();
    }
  }
}
