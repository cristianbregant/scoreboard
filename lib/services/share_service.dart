import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';

enum ShareFileType {
  png(XTypeGroup(
      label: 'PNG',
      extensions: ['png'],
      uniformTypeIdentifiers: ['public.png'])),
  pdf(XTypeGroup(
      label: 'PDF',
      extensions: ['pdf'],
      uniformTypeIdentifiers: ['com.adobe.pdf'])),
  json(XTypeGroup(
      label: 'JSON',
      extensions: ['json'],
      uniformTypeIdentifiers: ['public.json'])),
  csv(XTypeGroup(
      label: 'CSV',
      extensions: ['csv'],
      uniformTypeIdentifiers: ['public.comma-separated-values-text']));

  final XTypeGroup group;

  const ShareFileType(this.group);
}

class ShareService {
  Future<void> copyText(String text) =>
      Clipboard.setData(ClipboardData(text: text));

  /// Asks where to save [bytes]; returns the path, or null if cancelled.
  Future<String?> saveFile(Uint8List bytes,
      {required String suggestedName, required ShareFileType type}) async {
    final location = await getSaveLocation(
        suggestedName: suggestedName, acceptedTypeGroups: [type.group]);
    if (location == null) return null;
    await File(location.path).writeAsBytes(bytes);
    return location.path;
  }

  Future<String?> saveImage(Uint8List png, {required String suggestedName}) =>
      saveFile(png, suggestedName: suggestedName, type: ShareFileType.png);
}
