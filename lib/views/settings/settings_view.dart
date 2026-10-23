import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoreboard/core/providers.dart';
import 'package:scoreboard/core/routing/route_names.dart';
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

class SettingsView extends BaseStatefulWidget {
  SettingsView({Key? key}) : super(_SettingsViewState(), key: key);
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(12, 0, 12, 16),
                          child: Text("Settings",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.4)),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 0,
                          icon: Icons.palette_outlined,
                          selectedIcon: Icons.palette_rounded,
                          label: "Appearance",
                          onTap: () => viewModel.onTapChangePage(0),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 1,
                          icon: Icons.manage_accounts_outlined,
                          selectedIcon: Icons.manage_accounts_rounded,
                          label: "Account",
                          onTap: () => viewModel.onTapChangePage(1),
                        ),
                        NavButton(
                          selected: vmState.currentPage == 2,
                          icon: Icons.info_outline_rounded,
                          selectedIcon: Icons.info_rounded,
                          label: "About",
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

  Widget _buildGeneral() {
    final themeProvider = context.watch<DarkThemeProvider>();
    return ListView(
      padding: pagePadding,
      children: [
        const PageHeader(
            title: "Appearance", subtitle: "Choose how Scoreboard looks"),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _ThemePreview(
                label: "Light",
                dark: false,
                selected: !themeProvider.darkTheme,
                onTap: () => themeProvider.darkTheme = false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _ThemePreview(
                label: "Dark",
                dark: true,
                selected: themeProvider.darkTheme,
                onTap: () => themeProvider.darkTheme = true,
              ),
            ),
          ],
        ),
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
          const PageHeader(
              title: "Account",
              subtitle: "Sign-in details. Your name, photo and cover are in "
                  "Profile."),
          const SizedBox(height: 24),
          _section(
            title: "Email",
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
                          prefixIcon: Icon(Icons.mail_outline_rounded)),
                      validator: (value) =>
                          AuthInteractor.isValidEmail(value ?? '')
                              ? null
                              : "Enter a valid email address",
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
                    child: const Text("Save"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _section(
            title: "Password",
            child: Form(
              key: _passwordFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _currentPasswordController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: "Current password"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Enter your current password"
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
                          decoration:
                              const InputDecoration(labelText: "New password"),
                          validator: (value) => (value ?? '').length <
                                  AuthInteractor.minPasswordLength
                              ? "At least ${AuthInteractor.minPasswordLength} characters"
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              labelText: "Confirm new password"),
                          validator: (value) =>
                              value != _newPasswordController.text
                                  ? "Passwords don't match"
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
                      child: const Text("Change password"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _section(
            title: "Session",
            child: Row(
              children: [
                Expanded(
                  child: Text("Sign out of Scoreboard on this Mac.",
                      style: TextStyle(color: colorScheme.onSurfaceVariant)),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.error,
                    side: BorderSide(
                        color: colorScheme.error.withValues(alpha: 0.5)),
                  ),
                  onPressed: viewModel.signOut,
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text("Sign out"),
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
        const PageHeader(title: "About"),
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
                  child: Icon(Icons.emoji_events_rounded,
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
                      Text("Version ${vmState.appVersion}",
                          style:
                              TextStyle(color: colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
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
                  Icon(
                      selected
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
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
