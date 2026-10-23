import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';

class ShareService {
  static const XTypeGroup _png = XTypeGroup(
    label: 'PNG',
    extensions: ['png'],
    uniformTypeIdentifiers: ['public.png'],
  );

  Future<void> copyText(String text) =>
      Clipboard.setData(ClipboardData(text: text));

  /// Asks where to save [png]; returns the path, or null if cancelled.
  Future<String?> saveImage(Uint8List png,
      {required String suggestedName}) async {
    final location = await getSaveLocation(
        suggestedName: suggestedName, acceptedTypeGroups: [_png]);
    if (location == null) return null;
    await File(location.path).writeAsBytes(png);
    return location.path;
  }
}
