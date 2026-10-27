import 'package:lucide_icons_flutter/lucide_icons_300.dart';
import 'package:lucide_icons_flutter/lucide_icons_500.dart';
import 'package:scoreboard/core/haptics.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/core/providers.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/core/shortcuts.dart';
import 'package:scoreboard/model/release.dart';
import 'package:scoreboard/widgets/dialogs/onboarding_dialog.dart';
import 'package:scoreboard/widgets/dialogs/update_dialog.dart';
import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/settings/settings_contract.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/nav_button.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsView extends BaseStatefulWidget {
  SettingsView({super.key}) : super(_SettingsViewState());
}

class _SettingsViewState
    extends BaseState<SettingsView, SettingsViewModelContract, SettingsState>
    implements SettingsViewContract {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void fillAccountForm(UserProfile user) {
    _emailController.text = user.email;
  }

  @override
  void clearPasswordForm() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showUpdateAvailable(ReleaseInfo release) =>
      showUpdateDialog(context, release, onDownload: openExternalLink);

  @override
  void openSignIn() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(RouteNames.auth, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BaseWidget<SettingsViewModelContract, SettingsState>(
        model: viewModel,
        builder: (context, viewModel, child) => Builder(builder: (context) {
              return Scaffold(
                  body: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 220,
                    padding: const EdgeInsets.fromLTRB(12, 40, 12, 12),
                    decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(color: colorScheme.outlineVariant)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
                          child: Text(context.l10n.navSettings,
                              style: AppText.title),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 0,
                          icon: LucideIcons300.palette,
                          selectedIcon: LucideIcons500.palette,
                          label: context.l10n.settingsAppearance,
                          onTap: () => viewModel.onTapChangePage(0),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 1,
                          icon: LucideIcons300.userRoundCog,
                          selectedIcon: LucideIcons500.userRoundCog,
                          label: context.l10n.settingsAccount,
                          onTap: () => viewModel.onTapChangePage(1),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 2,
                          icon: LucideIcons300.info,
                          selectedIcon: LucideIcons500.info,
                          label: context.l10n.settingsAbout,
                          onTap: () => viewModel.onTapChangePage(2),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: IndexedStack(
                    index: vmState.currentPage,
                    children: [
                      _buildGeneral(),
                      _buildAccount(),
                      _buildAbout(),
                    ],
                  ))
                ],
              ));
            }));
  }

  /// Language names are written in their own language, so anyone can find
  /// theirs whatever the current one is.
  /// Each language in its own name, so anyone can find theirs.
  static const Map<String, String> _languages = {
    'en': 'English',
    'it': 'Italiano',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
  };

  Widget _buildGeneral() {
    final themeProvider = context.watch<DarkThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    return ListView(
      padding: pagePadding,
      children: [
        PageHeader(
            title: context.l10n.settingsAppearance,
            subtitle: context.l10n.appearanceSubtitle),
        SectionTitle(context.l10n.themeTitle),
        Row(
          children: [
            Expanded(
              child: _ThemePreview(
                label: context.l10n.themeLight,
                dark: false,
                selected: !themeProvider.darkTheme,
                onTap: () => themeProvider.darkTheme = false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ThemePreview(
                label: context.l10n.themeDark,
                dark: true,
                selected: themeProvider.darkTheme,
                onTap: () => themeProvider.darkTheme = true,
              ),
            ),
          ],
        ),
        SectionTitle(context.l10n.languageTitle),
        Align(
          alignment: Alignment.centerLeft,
          // '' stands for "follow the system".
          child: DropdownMenu<String>(
            width: 260,
            leadingIcon: const Icon(LucideIcons.languages),
            initialSelection: localeProvider.locale?.languageCode ?? '',
            dropdownMenuEntries: [
              DropdownMenuEntry(
                  value: '',
                  label: context.l10n.languageSystem,
                  leadingIcon: const Icon(LucideIcons.monitor)),
              for (final entry in _languages.entries)
                DropdownMenuEntry(value: entry.key, label: entry.value),
            ],
            onSelected: (code) {
              if (code == null) return;
              localeProvider.locale = code.isEmpty ? null : Locale(code);
            },
          ),
        ),
        // Only where the hardware can play it (a Force Touch trackpad).
        if (Haptics.isSupported) ...[
          SectionTitle(context.l10n.hapticsTitle),
          Card(
            child: SwitchListTile(
              title: Text(context.l10n.hapticsTitle),
              subtitle: Text(context.l10n.hapticsSubtitle),
              value: vmState.hapticsEnabled,
              onChanged: viewModel.onToggleHaptics,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAccount() {
    final colorScheme = Theme.of(context).colorScheme;
    return ContentStateView(
      state: vmState,
      onRetry: viewModel.loadAccount,
      builder: (context) => ListView(
        padding: pagePadding,
        children: [
          PageHeader(
              title: context.l10n.settingsAccount,
              subtitle: context.l10n.accountSubtitle),
          const SizedBox(height: 24),
          _section(
            title: context.l10n.fieldEmail,
            child: Form(
              key: _emailFormKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(LucideIcons.mail)),
                      validator: (value) =>
                          AuthInteractor.isValidEmail(value ?? '')
                              ? null
                              : context.l10n.invalidEmail,
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: vmState.isSavingEmail
                        ? null
                        : () {
                            if (_emailFormKey.currentState!.validate()) {
                              viewModel.saveEmail(_emailController.text);
                            }
                          },
                    child: Text(context.l10n.commonSave),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _section(
            title: context.l10n.passwordSection,
            child: Form(
              key: _passwordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: context.l10n.currentPassword),
                    validator: (value) => (value == null || value.isEmpty)
                        ? context.l10n.currentPasswordRequired
                        : null,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _newPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: context.l10n.newPassword),
                          validator: (value) => (value ?? '').length <
                                  AuthInteractor.minPasswordLength
                              ? context.l10n.passwordMinLength(
                                  AuthInteractor.minPasswordLength)
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: context.l10n.confirmNewPassword),
                          validator: (value) =>
                              value != _newPasswordController.text
                                  ? context.l10n.passwordsDontMatch
                                  : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: vmState.isChangingPassword
                          ? null
                          : () {
                              if (_passwordFormKey.currentState!.validate()) {
                                viewModel.changePassword(
                                    _currentPasswordController.text,
                                    _newPasswordController.text);
                              }
                            },
                      child: Text(context.l10n.changePassword),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _section(
            title: context.l10n.privacySection,
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.l10n.privacyCommunityTitle),
              subtitle: Text(context.l10n.privacyCommunitySubtitle),
              value: !vmState.hiddenFromCommunity,
              onChanged: viewModel.onToggleCommunityVisibility,
            ),
          ),
          const SizedBox(height: 16),
          _section(
            title: context.l10n.sessionSection,
            child: Row(
              children: [
                Expanded(
                  child: Text(context.l10n.signOutDescription,
                      style: TextStyle(color: colorScheme.onSurfaceVariant)),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(
                        color: colorScheme.error.withValues(alpha: 0.5)),
                  ),
                  onPressed: viewModel.signOut,
                  icon: const Icon(LucideIcons.logOut, size: 18),
                  label: Text(context.l10n.signOut),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildAbout() {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView(
      padding: pagePadding,
      children: [
        PageHeader(title: context.l10n.settingsAbout),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(LucideIcons.trophy,
                      color: colorScheme.onPrimary, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(vmState.appName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Text(context.l10n.versionLabel(vmState.appVersion),
                          style:
                              TextStyle(color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: vmState.isCheckingUpdates
                      ? null
                      : viewModel.onCheckForUpdates,
                  icon: const Icon(LucideIcons.download, size: 18),
                  label: Text(context.l10n.checkForUpdates),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => showOnboardingDialog(context),
            icon: const Icon(LucideIcons.graduationCap, size: 18),
            label: Text(context.l10n.onboardingReplay),
          ),
        ),
        SectionTitle(context.l10n.shortcutsSection),
        Card(
          child: Column(
            children: [
              for (final (keys, action) in [
                (AppShortcuts.quickSendLabel, context.l10n.sendAnAchievement),
                (
                  AppShortcuts.notificationsLabel,
                  context.l10n.notificationsOpen
                ),
                (AppShortcuts.pagesLabel, context.l10n.shortcutGoToPage),
                (AppShortcuts.settingsLabel, context.l10n.navSettings),
                ('F', context.l10n.shortcutFlipCard),
              ])
                ListTile(
                  title: Text(action),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Text(keys,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFeatures: [FontFeature.tabularFigures()])),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Miniature mock-up of the app in light or dark colors.
class _ThemePreview extends StatelessWidget {
  final String label;
  final bool dark;
  final bool selected;
  final VoidCallback onTap;

  const _ThemePreview(
      {required this.label,
      required this.dark,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final background =
        dark ? AppColors.darkBackground : AppColors.lightBackground;
    final sidebar = dark ? AppColors.darkSidebar : AppColors.lightSidebar;
    final surface =
        dark ? AppColors.darkSurfaceHigh : AppColors.lightSurfaceHigh;

    Widget bar(double width, Color color) => Container(
          width: width,
          height: 8,
          margin: const EdgeInsets.only(bottom: 6),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
        );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppTheme.radius),
            border: Border.all(
                color:
                    selected ? colorScheme.primary : colorScheme.outlineVariant,
                width: selected ? 2 : 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 110,
                  color: background,
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        color: sidebar,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Container(
                              height: 14,
                              decoration: BoxDecoration(
                                  color: dark
                                      ? AppColors.accentDark
                                      : AppColors.accentLight,
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            const SizedBox(height: 10),
                            bar(32, surface),
                            bar(32, surface),
                            bar(32, surface),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bar(80, surface),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  for (final tier in [
                                    AchievementTier.platinum,
                                    AchievementTier.gold,
                                    AchievementTier.silver,
                                  ])
                                    Container(
                                      width: 30,
                                      height: 42,
                                      margin: const EdgeInsets.only(right: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: tier.gradient,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(selected ? LucideIcons.circleDot : LucideIcons.circle,
                      size: 18,
                      color: selected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Text(label,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
