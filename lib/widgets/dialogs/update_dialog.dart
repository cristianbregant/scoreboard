import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/release.dart';

Future<void> showUpdateDialog(BuildContext context, ReleaseInfo release,
    {required void Function(String url) onDownload}) {
  final l10n = context.l10n;
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(Icons.system_update_alt_rounded),
      title: Text(l10n.updateAvailableTitle(release.version)),
      content: Text(l10n.updateAvailableBody),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.updateLater)),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onDownload(release.url.toString());
          },
          child: Text(l10n.updateDownload),
        ),
      ],
    ),
  );
}
