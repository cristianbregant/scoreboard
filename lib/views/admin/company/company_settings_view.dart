import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons_500.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/interactors/company_settings_interactor.dart';
import 'package:scoreboard/model/company_settings.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/company/company_settings_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';

class CompanySettingsView extends BaseStatefulWidget {
  CompanySettingsView({super.key}) : super(_CompanySettingsViewState());
}

class _CompanySettingsViewState extends BaseState<CompanySettingsView,
        CompanySettingsViewModelContract, CompanySettingsState>
    with AdminScreenMessages
    implements CompanySettingsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<CompanySettingsViewModelContract, CompanySettingsState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            final settings = vmState.settings;
            final company = vmState.company;
            if (settings == null || company == null) {
              return const SizedBox.shrink();
            }
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                    title: l10n.consoleCompany,
                    subtitle: l10n.consoleSubtitle(company.name)),
                SectionTitle(l10n.brandTitle),
                _buildBrand(settings, company.name),
                SectionTitle(l10n.anniversariesTitle),
                _buildAnniversaries(settings),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBrand(CompanySettings settings, String companyName) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.brandBody(companyName),
                      style: TextStyle(color: colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 18),
                  Text(l10n.brandColor,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _Swatch(
                        color: AppColors.accentDark,
                        tooltip: l10n.brandDefault,
                        selected: settings.accentColor == null,
                        onTap: () => viewModel.onSelectAccent(null),
                      ),
                      for (final color
                          in CompanySettingsInteractor.accentPresets)
                        _Swatch(
                          color: Color(color),
                          tooltip:
                              '#${(color & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}',
                          selected: settings.accentColor == color,
                          onTap: () => viewModel.onSelectAccent(color),
                        ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Text(l10n.brandLogo,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      OutlinedButton.icon(
                        onPressed: viewModel.onTapUploadLogo,
                        icon: const Icon(Icons.upload_rounded),
                        label: Text(l10n.uploadLogo),
                      ),
                      if (settings.logoPath != null)
                        TextButton(
                          onPressed: viewModel.onTapRemoveLogo,
                          child: Text(l10n.commonRemove),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            _BrandPreview(settings: settings, companyName: companyName),
          ],
        ),
      ),
    );
  }

  Widget _buildAnniversaries(CompanySettings settings) {
    final l10n = context.l10n;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.anniversariesEnabled),
              subtitle: Text(l10n.anniversariesBody),
              value: settings.anniversariesEnabled,
              onChanged: viewModel.onToggleAnniversaries,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final years in CompanySettings.availableAnniversaryYears)
                  FilterChip(
                    label: Text(
                        '${l10n.anniversaryYears(years)} · ${l10n.xpValue(CompanySettings.anniversaryPoints(years))}'),
                    selected: settings.anniversaryYears.contains(years),
                    onSelected: settings.anniversariesEnabled
                        ? (_) => viewModel.onToggleAnniversaryYear(years)
                        : null,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  final Color color;
  final String tooltip;
  final bool selected;
  final VoidCallback onTap;

  const _Swatch(
      {required this.color,
      required this.tooltip,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Container(
            width: 34,
            height: 34,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: selected ? colorScheme.onSurface : Colors.transparent,
                  width: 2),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: selected
                  ? const Icon(Icons.check_rounded,
                      size: 16, color: Colors.white)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

/// The sidebar header and a button as the company's people will see them,
/// in the theme the accent produces.
class _BrandPreview extends StatelessWidget {
  final CompanySettings settings;
  final String companyName;

  const _BrandPreview({required this.settings, required this.companyName});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final accent = settings.accentColor;
    final theme = accent == null
        ? (dark ? AppTheme.themeDataDark : AppTheme.themeDataLight)
        : (dark
            ? AppTheme.branded(Color(accent)).$2
            : AppTheme.branded(Color(accent)).$1);
    final logo = settings.logoPath;

    return Theme(
      data: theme,
      child: Builder(builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          width: 240,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.brandPreview.toUpperCase(),
                  style: TextStyle(
                      fontSize: 10.5,
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurfaceVariant)),
              const SizedBox(height: 12),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: logo != null
                        ? Image.file(File(logo),
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => _trophy(colorScheme))
                        : _trophy(colorScheme),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(companyName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 15,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(LucideIcons500.trophy,
                        size: 16, color: colorScheme.primary),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(l10n.navAchievements,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Geist',
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.send_rounded, size: 16),
                label: Text(l10n.sendAchievement),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _trophy(ColorScheme colorScheme) => Container(
        width: 30,
        height: 30,
        color: colorScheme.primary,
        child:
            Icon(LucideIcons500.trophy, color: colorScheme.onPrimary, size: 17),
      );
}
