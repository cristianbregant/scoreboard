import 'package:file_selector/file_selector.dart';

class FilePickerService {
  static const XTypeGroup _images = XTypeGroup(
    label: 'Images',
    extensions: ['jpg', 'jpeg', 'png', 'heic', 'webp'],
    uniformTypeIdentifiers: ['public.image'],
  );

  /// Path of the image the user picked, or null if cancelled.
  Future<String?> pickImage() async {
    final file = await openFile(acceptedTypeGroups: [_images]);
    return file?.path;
  }
}
