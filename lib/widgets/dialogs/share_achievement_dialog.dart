import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/share_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Preview of the image and text to share, with the LinkedIn actions.
/// [onAddToProfile] is null for achievements that can't go on a profile.
Future<void> showShareAchievementDialog(BuildContext context,
    {required Achievement achievement,
    required String postText,
    required void Function(String text) onPost,
    required void Function(String text) onCopy,
    required void Function(Uint8List png) onSaveImage,
    VoidCallback? onAddToProfile}) {
  return showDialog<void>(
    context: context,
    builder: (_) => _ShareAchievementDialog(
      achievement: achievement,
      postText: postText,
      onPost: onPost,
      onCopy: onCopy,
      onSaveImage: onSaveImage,
      onAddToProfile: onAddToProfile,
    ),
  );
}

class _ShareAchievementDialog extends StatefulWidget {
  final Achievement achievement;
  final String postText;
  final void Function(String text) onPost;
  final void Function(String text) onCopy;
  final void Function(Uint8List png) onSaveImage;
  final VoidCallback? onAddToProfile;

  const _ShareAchievementDialog(
      {required this.achievement,
      required this.postText,
      required this.onPost,
      required this.onCopy,
      required this.onSaveImage,
      required this.onAddToProfile});

  @override
  State<_ShareAchievementDialog> createState() =>
      _ShareAchievementDialogState();
}

class _ShareAchievementDialogState extends State<_ShareAchievementDialog> {
  final _imageKey = GlobalKey();
  late final _textController = TextEditingController(text: widget.postText);

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Renders the preview at twice LinkedIn's size, for sharp text.
  Future<void> _saveImage() async {
    final boundary =
        _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    if (bytes != null) widget.onSaveImage(bytes.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final mutedStyle =
        TextStyle(fontSize: 12.5, color: colorScheme.onSurfaceVariant);

    return Dialog(
      backgroundColor: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius * 1.25),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 940, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.shareOnLinkedIn, style: AppText.title),
              const SizedBox(height: 4),
              Text(l10n.shareDialogSubtitle,
                  style: TextStyle(color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 20),
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 480,
                      // Scrolls only if the window is shorter than expected.
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: AspectRatio(
                                aspectRatio: ShareImage.size.aspectRatio,
                                child: FittedBox(
                                  child: RepaintBoundary(
                                    key: _imageKey,
                                    child: ShareImage(
                                        achievement: widget.achievement),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(l10n.flipHint, style: mutedStyle),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                OutlinedButton.icon(
                                  onPressed: _saveImage,
                                  icon: const Icon(LucideIcons.download,
                                      size: 18),
                                  label: Text(l10n.shareSaveImage),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: Text(l10n.shareImageHint,
                                        style: mutedStyle)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FieldLabel(l10n.sharePostLabel),
                          Expanded(
                            child: TextField(
                              controller: _textController,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () =>
                                    widget.onCopy(_textController.text),
                                icon: const Icon(LucideIcons.copy, size: 18),
                                label: Text(l10n.shareCopyText),
                              ),
                              const Spacer(),
                              FilledButton.icon(
                                onPressed: () =>
                                    widget.onPost(_textController.text),
                                icon: const Icon(LucideIcons.externalLink,
                                    size: 18),
                                label: Text(l10n.shareOpenLinkedIn),
                              ),
                            ],
                          ),
                          if (widget.onAddToProfile != null) ...[
                            const Divider(height: 28),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      l10n.shareAddToProfileHint(
                                          widget.achievement.company ?? ''),
                                      style: mutedStyle),
                                ),
                                const SizedBox(width: 12),
                                OutlinedButton.icon(
                                  onPressed: widget.onAddToProfile,
                                  icon: const Icon(LucideIcons.award, size: 18),
                                  label: Text(l10n.shareAddToProfile),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.commonClose)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
