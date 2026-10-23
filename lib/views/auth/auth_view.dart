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
import 'package:scoreboard/widgets/common/company_logo.dart';
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
  String? _companyId;
  bool _obscurePassword = true;

  @override
  void dispose() {
    for (final controller in [
      _emailController,
      _passwordController,
      _nameController,
      _roleController,
      _confirmController,
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
      viewModel.register(RegistrationDraft(
        name: _nameController.text,
        role: _roleController.text,
        companyId: _companyId!,
        email: _emailController.text,
        password: _passwordController.text,
      ));
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
        Text(signIn ? "Welcome back" : "Create your account",
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.6)),
        const SizedBox(height: 6),
        Text(
            signIn
                ? "Sign in to see your achievements."
                : "Join your company's scoreboard.",
            style: TextStyle(color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 24),
        SegmentedButton<AuthMode>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: AuthMode.signIn, label: Text("Sign in")),
            ButtonSegment(
                value: AuthMode.register, label: Text("Create account")),
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
              : Text(signIn ? "Sign in" : "Create account"),
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
          tooltip: _obscurePassword ? "Show password" : "Hide password",
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          icon: Icon(_obscurePassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined),
        ),
      ),
      validator: validator,
    );
  }

  Widget _emailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: "Work email",
          prefixIcon: Icon(Icons.mail_outline_rounded)),
      validator: (value) =>
          RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value?.trim() ?? '')
              ? null
              : "Enter a valid email address",
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
            label: "Password",
            validator: (value) =>
                (value == null || value.isEmpty) ? "Enter your password" : null,
          ),
        ],
      ),
    );
  }

  Widget _buildRegister() {
    String? required(String? value, String message) =>
        (value == null || value.trim().isEmpty) ? message : null;

    return Form(
      key: _registerKey,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Full name"),
                  validator: (value) => required(value, "Enter your name"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(labelText: "Role"),
                  validator: (value) => required(value, "Enter your role"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _companyId,
            decoration: const InputDecoration(labelText: "Company"),
            borderRadius: BorderRadius.circular(12),
            items: [
              for (final Company company in vmState.companies)
                DropdownMenuItem(
                  value: company.id,
                  child: Row(
                    children: [
                      CompanyLogo(
                          name: company.name, brand: company.brand, size: 22),
                      const SizedBox(width: 10),
                      Text(company.name),
                    ],
                  ),
                ),
            ],
            onChanged: (value) => setState(() => _companyId = value),
            validator: (value) => value == null ? "Choose your company" : null,
          ),
          const SizedBox(height: 12),
          _emailField(),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _passwordField(
                  controller: _passwordController,
                  label: "Password",
                  validator: (value) =>
                      (value ?? '').length < 8 ? "At least 8 characters" : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _passwordField(
                  controller: _confirmController,
                  label: "Confirm",
                  validator: (value) => value != _passwordController.text
                      ? "Passwords don't match"
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
                "Demo account: ${MockScoreboardRepository.demoEmail} / "
                "${MockScoreboardRepository.demoPassword}",
                style: TextStyle(
                    fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () => setState(() {
              _emailController.text = MockScoreboardRepository.demoEmail;
              _passwordController.text = MockScoreboardRepository.demoPassword;
            }),
            child: const Text("Use it"),
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

    return WindowDragArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          border: Border(right: BorderSide(color: colorScheme.outlineVariant)),
        ),
        padding: EdgeInsets.fromLTRB(40, 20 + WindowChrome.topInset, 40, 40),
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
                          offset: Offset((i - 1) * 82.0, (i - 1).abs() * 14.0),
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
            const Text("Every win,\non the record.",
                style: TextStyle(
                    fontSize: 30,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.8)),
            const SizedBox(height: 10),
            Text(
                "Collect the achievements your company issues, and recognize "
                "the colleagues who make a difference.",
                style: TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}
