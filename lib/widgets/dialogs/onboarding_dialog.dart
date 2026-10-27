import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/shortcuts.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/company.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Four-step introduction shown on a user's first sign-in.
Future<void> showOnboardingDialog(BuildContext context) => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _OnboardingDialog(),
    );

class _OnboardingDialog extends StatefulWidget {
  const _OnboardingDialog();

  @override
  State<_OnboardingDialog> createState() => _OnboardingDialogState();
}

class _OnboardingDialogState extends State<_OnboardingDialog> {
  static const int _steps = 4;
  int _step = 0;

  static final Achievement _sample = Achievement(
    id: 'onboarding_sample',
    name: 'Cloud Computing Expert',
    icon: 'cloud_icon.png',
    points: 140,
    verified: true,
    company: 'Northwind Labs',
    companyBrand: const CompanyBrand(symbol: 'air', color: 0xFF0EA5E9),
    date: DateTime(2026, 8, 22),
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final (title, body, icon) = switch (_step) {
      0 => (l10n.onboardingWelcomeTitle, l10n.onboardingWelcomeBody, null),
      1 => (
          l10n.onboardingKindsTitle,
          l10n.onboardingKindsBody(SendAchievementOptions.monthlyBudget),
          LucideIcons.badgeCheck
        ),
      2 => (
          l10n.onboardingFeedTitle,
          l10n.onboardingFeedBody,
          LucideIcons.newspaper
        ),
      _ => (
          l10n.onboardingFastTitle,
          l10n.onboardingFastBody(AppShortcuts.quickSendLabel),
          LucideIcons.command
        ),
    };
    final last = _step == _steps - 1;

    return Dialog(
      backgroundColor: colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius * 1.25),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: SizedBox(
        width: 520,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(36, 32, 36, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: icon == null
                      ? InteractiveCard(
                          achievement: _sample,
                          heroTag: 'onboarding_card',
                          width: 130,
                          flipOnTap: true,
                          onPressed: () {})
                      : Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child:
                              Icon(icon, size: 56, color: colorScheme.primary),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Text(title, textAlign: TextAlign.center, style: AppText.title),
              const SizedBox(height: 10),
              Text(body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.5, color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < _steps; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _step ? 20 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: i == _step
                            ? colorScheme.primary
                            : colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  if (!last)
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.onboardingSkip)),
                  const Spacer(),
                  FilledButton(
                    onPressed: last
                        ? () => Navigator.of(context).pop()
                        : () => setState(() => _step++),
                    child:
                        Text(last ? l10n.onboardingDone : l10n.onboardingNext),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
