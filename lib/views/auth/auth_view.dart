import 'package:scoreboard/interactors/auth_interactor.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/routing/route_names.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/auth.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/services/mock_scoreboard_repository.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/auth/auth_contract.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:scoreboard/core/window_chrome.dart';

class AuthView extends BaseStatefulWidget {
  AuthView({super.key}) : super(_AuthViewState());
}

class _AuthViewState
    extends BaseState<AuthView, AuthViewModelContract, AuthState>
    implements AuthViewContract {
  final _signInKey = GlobalKey<FormState>();
  final _registerKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _confirmController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _industryController = TextEditingController();
  final _locationController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    for (final controller in [
      _emailController,
      _passwordController,
      _nameController,
      _roleController,
      _confirmController,
      _inviteCodeController,
      _companyNameController,
      _industryController,
      _locationController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void openApp() {
    Navigator.of(context).pushReplacementNamed(RouteNames.baseWindow);
  }

  void _onSubmit() {
    if (vmState.mode == AuthMode.signIn) {
      if (!_signInKey.currentState!.validate()) return;
      viewModel.signIn(_emailController.text, _passwordController.text);
    } else {
      if (!_registerKey.currentState!.validate()) return;
      viewModel.register(switch (vmState.registerMode) {
        RegisterMode.join => RegistrationDraft.join(
            name: _nameController.text,
            role: _roleController.text,
            email: _emailController.text,
            password: _passwordController.text,
            inviteCode: _inviteCodeController.text,
          ),
        RegisterMode.createCompany => RegistrationDraft.createCompany(
            name: _nameController.text,
            role: _roleController.text,
            email: _emailController.text,
            password: _passwordController.text,
            newCompany: CompanyDraft(
              name: _companyNameController.text,
              industry: _industryController.text,
              location: _locationController.text,
            ),
          ),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthViewModelContract, AuthState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
              body: Row(
                children: [
                  const Expanded(flex: 5, child: _Showcase()),
                  Expanded(
                    flex: 6,
                    child: Stack(
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(40),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: _buildForm(context),
                            ),
                          ),
                        ),
                        if (WindowChrome.hasHiddenTitleBar)
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: WindowChrome.topInset,
                            child:
                                const WindowDragArea(child: SizedBox.expand()),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  Widget _buildForm(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final signIn = vmState.mode == AuthMode.signIn;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
            signIn
                ? context.l10n.authWelcomeBack
                : context.l10n.authCreateTitle,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6)),
        const SizedBox(height: 6),
        Text(
            signIn
                ? context.l10n.authSignInSubtitle
                : switch (vmState.registerMode) {
                    RegisterMode.join => context.l10n.authJoinSubtitle,
                    RegisterMode.createCompany =>
                      context.l10n.authCreateCompanySubtitle,
                  },
            style: TextStyle(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 24),
        SegmentedButton<AuthMode>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
                value: AuthMode.signIn, label: Text(context.l10n.signIn)),
            ButtonSegment(
                value: AuthMode.register,
                label: Text(context.l10n.createAccount)),
          ],
          selected: {vmState.mode},
          onSelectionChanged: (value) => viewModel.onChangeMode(value.first),
        ),
        const SizedBox(height: 24),
        signIn ? _buildSignIn() : _buildRegister(),
        if (vmState.errorMessage != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline_rounded,
                    size: 18, color: colorScheme.error),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(vmState.errorMessage!,
                        style: TextStyle(color: colorScheme.error))),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        FilledButton(
          onPressed: vmState.isSubmitting ? null : _onSubmit,
          child: vmState.isSubmitting
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : Text(signIn ? context.l10n.signIn : context.l10n.createAccount),
        ),
        if (signIn) ...[
          const SizedBox(height: 20),
          _buildDemoHint(colorScheme),
        ],
      ],
    );
  }

  Widget _passwordField(
      {required TextEditingController controller,
      required String label,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: _obscurePassword,
      onFieldSubmitted: (_) => _onSubmit(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline_rounded),
        suffixIcon: IconButton(
          tooltip: _obscurePassword
              ? context.l10n.showPassword
              : context.l10n.hidePassword,
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          icon: Icon(_obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
        ),
      ),
      validator: validator,
    );
  }

  Widget _emailField({String? helperText}) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: context.l10n.workEmail,
          helperText: helperText,
          prefixIcon: const Icon(Icons.mail_outline_rounded)),
      validator: (value) =>
          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value?.trim() ?? '')
              ? null
              : context.l10n.invalidEmail,
    );
  }

  Widget _buildSignIn() {
    return Form(
      key: _signInKey,
      child: Column(
        children: [
          _emailField(),
          const SizedBox(height: 12),
          _passwordField(
            controller: _passwordController,
            label: context.l10n.passwordLabel,
            validator: (value) => (value == null || value.isEmpty)
                ? context.l10n.passwordRequired
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    String? required(String? value, String message) =>
        (value == null || value.trim().isEmpty) ? message : null;

    final join = vmState.registerMode == RegisterMode.join;

    return Form(
      key: _registerKey,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<RegisterMode>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(
                    value: RegisterMode.join,
                    icon: const Icon(Icons.mail_outline_rounded, size: 18),
                    label: Text(context.l10n.registerJoin)),
                ButtonSegment(
                    value: RegisterMode.createCompany,
                    icon: const Icon(Icons.add_business_outlined, size: 18),
                    label: Text(context.l10n.registerCreateCompany)),
              ],
              selected: {vmState.registerMode},
              onSelectionChanged: (value) =>
                  viewModel.onChangeRegisterMode(value.first),
            ),
          ),
          const SizedBox(height: 16),
          if (!join) ...[
            TextFormField(
              controller: _companyNameController,
              decoration: InputDecoration(
                  labelText: context.l10n.companyNameLabel,
                  prefixIcon: const Icon(Icons.business_outlined)),
              validator: (value) =>
                  required(value, context.l10n.companyNameRequired),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _industryController,
                    decoration: InputDecoration(
                        labelText: context.l10n.companyIndustryLabel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _locationController,
                    decoration: InputDecoration(
                        labelText: context.l10n.companyLocationLabel),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  decoration:
                      InputDecoration(labelText: context.l10n.fieldFullName),
                  validator: (value) =>
                      required(value, context.l10n.nameRequired),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _roleController,
                  decoration:
                      InputDecoration(labelText: context.l10n.fieldRole),
                  validator: (value) =>
                      required(value, context.l10n.roleRequired),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (join) ...[
            _emailField(helperText: context.l10n.inviteEmailHint),
            const SizedBox(height: 12),
            TextFormField(
              controller: _inviteCodeController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                  labelText: context.l10n.inviteCodeLabel,
                  hintText: 'ABCD-EFGH',
                  prefixIcon: const Icon(Icons.key_rounded)),
              validator: (value) =>
                  required(value, context.l10n.inviteCodeRequired),
            ),
          ] else
            _emailField(),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _passwordField(
                  controller: _passwordController,
                  label: context.l10n.passwordLabel,
                  validator: (value) => (value ?? '').length <
                          AuthInteractor.minPasswordLength
                      ? context.l10n
                          .passwordMinLength(AuthInteractor.minPasswordLength)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _passwordField(
                  controller: _confirmController,
                  label: context.l10n.confirmLabel,
                  validator: (value) => value != _passwordController.text
                      ? context.l10n.passwordsDontMatch
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDemoHint(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded,
              size: 18, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
                context.l10n.demoAccount(MockScoreboardRepository.demoEmail,
                    MockScoreboardRepository.demoPassword),
                style: TextStyle(
                    fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () => setState(() {
              _emailController.text = MockScoreboardRepository.demoEmail;
              _passwordController.text = MockScoreboardRepository.demoPassword;
            }),
            child: Text(context.l10n.useDemo),
          ),
        ],
      ),
    );
  }
}

/// Left panel: brand, a fan of sample cards and the pitch.
class _Showcase extends StatelessWidget {
  const _Showcase();

  static final List<Achievement> _samples = [
    Achievement(
      id: 'sample_1',
      name: 'Sharp Reviewer',
      description: 'Left thoughtful and helpful code reviews.',
      icon: 'review_icon.png',
      points: 25,
      verified: false,
      awardedByName: 'Giulia Bianchi',
      note: 'Your reviews make the whole team better.',
      date: DateTime(2026, 9, 12),
    ),
    Achievement(
      id: 'sample_2',
      name: 'Cloud Computing Expert',
      icon: 'cloud_icon.png',
      points: 140,
      verified: true,
      company: 'Northwind Labs',
      companyBrand: const CompanyBrand(symbol: 'air', color: 0xFF0EA5E9),
      date: DateTime(2026, 8, 22),
    ),
    Achievement(
      id: 'sample_3',
      name: 'Cybersecurity Defender',
      icon: 'cybersecurity_icon.png',
      points: 130,
      verified: true,
      company: 'Northwind Labs',
      companyBrand: const CompanyBrand(symbol: 'air', color: 0xFF0EA5E9),
      date: DateTime(2026, 7, 19),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // The background stays outside the drag area: being opaque to clicks,
    // inside it would cover the drag surface.
    return DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          border: Border(right: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: WindowDragArea(
          child: Container(
            padding:
                EdgeInsets.fromLTRB(40, 20 + WindowChrome.topInset, 40, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Icon(Icons.emoji_events_rounded,
                          color: colorScheme.onPrimary, size: 19),
                    ),
                    const SizedBox(width: 12),
                    const Text("Scoreboard",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4)),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 320,
                      height: 240,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          for (var i = 0; i < _samples.length; i++)
                            Transform.translate(
                              offset:
                                  Offset((i - 1) * 82.0, (i - 1).abs() * 14.0),
                              child: Transform.rotate(
                                angle: (i - 1) * 0.14,
                                child: InteractiveCard(
                                  achievement: _samples[i],
                                  heroTag: 'showcase_$i',
                                  width: 150,
                                  flipOnTap: true,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(context.l10n.authTagline,
                    style: const TextStyle(
                        fontSize: 30,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.8)),
                const SizedBox(height: 10),
                Text(context.l10n.authPitch,
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ));
  }
}
