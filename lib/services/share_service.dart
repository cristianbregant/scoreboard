import 'package:flutter/foundation.dart';
import 'dart:convert';
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
  jwt(XTypeGroup(
      label: 'Open Badges (JWT)',
      extensions: ['jwt'],
      uniformTypeIdentifiers: ['public.plain-text'])),
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
    // A browser downloads the file instead; it doesn't say where.
    if (kIsWeb) {
      await XFile.fromData(bytes, name: suggestedName).saveTo(suggestedName);
      return suggestedName;
    }
    final location = await getSaveLocation(
        suggestedName: suggestedName, acceptedTypeGroups: [type.group]);
    if (location == null) return null;
    await File(location.path).writeAsBytes(bytes);
    return location.path;
  }

  /// Asks for a file of [type] to open and returns its text, or null if
  /// cancelled. Files that aren't UTF-8 are read as Latin-1, as older
  /// spreadsheet exports on Windows are.
  Future<String?> openTextFile(ShareFileType type) async {
    final file = await openFile(acceptedTypeGroups: [type.group]);
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    try {
      return utf8.decode(bytes);
    } on FormatException {
      return latin1.decode(bytes);
    }
  }

  Future<String?> saveImage(Uint8List png, {required String suggestedName}) =>
      saveFile(png, suggestedName: suggestedName, type: ShareFileType.png);
}
