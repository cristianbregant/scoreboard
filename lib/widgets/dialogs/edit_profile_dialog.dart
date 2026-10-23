import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/widgets/common/profile_banner.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';

/// Returns the edited profile, or null if cancelled. [pickImage] opens the
/// system file picker and returns the chosen path.
Future<ProfileDraft?> showEditProfileDialog(BuildContext context,
    {required UserProfile user,
    required Future<String?> Function() pickImage}) {
  return showDialog<ProfileDraft>(
    context: context,
    builder: (_) => _EditProfileDialog(user: user, pickImage: pickImage),
  );
}

class _EditProfileDialog extends StatefulWidget {
  final UserProfile user;
  final Future<String?> Function() pickImage;

  const _EditProfileDialog({required this.user, required this.pickImage});

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.user.name);
  late final _roleController = TextEditingController(text: widget.user.role);
  late final _bioController = TextEditingController(text: widget.user.bio);
  late String _bannerPreset = widget.user.bannerPreset;

  String? _newAvatar;
  bool _removeAvatar = false;
  String? _newBanner;
  bool _removeBanner = false;

  String? get _avatarPath =>
      _newAvatar ?? (_removeAvatar ? null : widget.user.avatarPath);
  String? get _bannerPath =>
      _newBanner ?? (_removeBanner ? null : widget.user.bannerImagePath);

  String get _initials => UserProfile(
          id: '',
          name: _nameController.text,
          role: '',
          email: '',
          companyId: '',
          joinedAt: DateTime(0))
      .initials;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final path = await widget.pickImage();
    if (path != null) setState(() => _newAvatar = path);
  }

  Future<void> _pickBanner() async {
    final path = await widget.pickImage();
    if (path != null) setState(() => _newBanner = path);
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(ProfileDraft(
      name: _nameController.text,
      role: _roleController.text,
      bio: _bioController.text,
      bannerPreset: _bannerPreset,
      newAvatarSource: _newAvatar,
      removeAvatar: _removeAvatar && _newAvatar == null,
      newBannerSource: _newBanner,
      removeBanner: _removeBanner && _newBanner == null,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius * 1.25),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 640),
        child: Column(
          children: [
            _buildPreview(colorScheme),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(28, 8, 28, 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(context.l10n.fieldPhoto),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: _pickAvatar,
                            icon: const Icon(Icons.upload_rounded, size: 18),
                            label: Text(context.l10n.uploadPhoto),
                          ),
                          if (_avatarPath != null) ...[
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: () => setState(() {
                                _newAvatar = null;
                                _removeAvatar = true;
                              }),
                              child: Text(context.l10n.commonRemove),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 20),
                      FieldLabel(context.l10n.fieldCover),
                      _buildCoverOptions(colorScheme),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FieldLabel(context.l10n.fieldFullName),
                                TextFormField(
                                  controller: _nameController,
                                  validator: (value) =>
                                      (value == null || value.trim().isEmpty)
                                          ? context.l10n.nameRequired
                                          : null,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FieldLabel(context.l10n.fieldRole),
                                TextFormField(
                                  controller: _roleController,
                                  validator: (value) =>
                                      (value == null || value.trim().isEmpty)
                                          ? context.l10n.roleRequired
                                          : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      FieldLabel(context.l10n.fieldBio),
                      TextFormField(
                        controller: _bioController,
                        maxLength: 160,
                        maxLines: 3,
                        minLines: 2,
                        decoration:
                            InputDecoration(hintText: context.l10n.bioHint),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 8, 28, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(context.l10n.commonCancel)),
                  const SizedBox(width: 8),
                  FilledButton(
                      onPressed: _onSave,
                      child: Text(context.l10n.saveProfile)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview(ColorScheme colorScheme) {
    const bannerHeight = 120.0;
    const avatarRadius = 40.0;
    return SizedBox(
      height: bannerHeight + avatarRadius + 12,
      child: Stack(
        children: [
          ProfileBanner(
              preset: _bannerPreset,
              imagePath: _bannerPath,
              height: bannerHeight),
          Positioned(
            left: 28,
            top: bannerHeight - avatarRadius,
            child: GestureDetector(
              onTap: _pickAvatar,
              child: Stack(
                children: [
                  UserAvatar(
                      initials: _initials,
                      imagePath: _avatarPath,
                      radius: avatarRadius,
                      ringColor: colorScheme.surfaceContainer),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: colorScheme.surfaceContainer, width: 2),
                      ),
                      child: Icon(Icons.photo_camera_rounded,
                          size: 13, color: colorScheme.onPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 28 + avatarRadius * 2 + 16,
            top: bannerHeight + 10,
            right: 28,
            child: Text(context.l10n.editProfile,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface)),
          ),
        ],
      ),
    );
  }

  Widget _buildCoverOptions(ColorScheme colorScheme) {
    Widget option(
        {required bool selected,
        required VoidCallback onTap,
        required Widget child,
        String? tooltip}) {
      return Tooltip(
        message: tooltip ?? '',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 84,
            height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: selected
                      ? colorScheme.primary
                      : colorScheme.outlineVariant,
                  width: selected ? 2 : 1),
            ),
            child: child,
          ),
        ),
      );
    }

    final hasCustom = _bannerPath != null;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final preset in bannerPresets)
          option(
            tooltip: bannerPresetLabel(context.l10n, preset.key),
            selected: !hasCustom && preset.key == _bannerPreset,
            onTap: () => setState(() {
              _bannerPreset = preset.key;
              _newBanner = null;
              _removeBanner = true;
            }),
            child: BannerPatternView(preset: preset),
          ),
        option(
          tooltip:
              hasCustom ? context.l10n.replaceImage : context.l10n.uploadImage,
          selected: hasCustom,
          onTap: _pickBanner,
          child: hasCustom
              ? Image.file(File(_bannerPath!), fit: BoxFit.cover)
              : Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(Icons.add_photo_alternate_outlined,
                      size: 20, color: colorScheme.onSurfaceVariant),
                ),
        ),
      ],
    );
  }
}
