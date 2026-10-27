import 'package:flutter/material.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/interactors/report_interactor.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/admin_screen.dart';
import 'package:scoreboard/views/admin/reports/reports_contract.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ReportsView extends BaseStatefulWidget {
  ReportsView({super.key}) : super(_ReportsViewState());
}

class _ReportsViewState
    extends BaseState<ReportsView, ReportsViewModelContract, ReportsState>
    with AdminScreenMessages
    implements ReportsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ReportsViewModelContract, ReportsState>(
      model: viewModel,
      builder: (context, viewModel, child) => Scaffold(
        body: ContentStateView(
          state: vmState,
          onRetry: viewModel.load,
          builder: (context) {
            final l10n = context.l10n;
            final busy = vmState.isExporting;
            return ListView(
              padding: pagePadding,
              children: [
                PageHeader(
                    title: l10n.consoleReports, subtitle: l10n.reportsHint),
                SectionTitle(l10n.reportPeriod),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SegmentedButton<ReportPeriod>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment(
                          value: ReportPeriod.last30Days,
                          label: Text(l10n.periodLast30)),
                      ButtonSegment(
                          value: ReportPeriod.thisQuarter,
                          label: Text(l10n.periodQuarter)),
                      ButtonSegment(
                          value: ReportPeriod.thisYear,
                          label: Text(l10n.periodYear)),
                      ButtonSegment(
                          value: ReportPeriod.allTime,
                          label: Text(l10n.periodAll)),
                    ],
                    selected: {vmState.period},
                    onSelectionChanged: (s) =>
                        viewModel.onSelectPeriod(s.first),
                  ),
                ),
                const SizedBox(height: 20),
                _ExportCard(
                  icon: LucideIcons.trophy,
                  title: l10n.reportAchievementsTitle,
                  body: l10n.reportAchievementsBody,
                  action: FilledButton.icon(
                    onPressed: busy
                        ? null
                        : () => viewModel.onExport(ReportKind.achievements),
                    icon: const Icon(LucideIcons.download),
                    label: Text(l10n.exportCsv),
                  ),
                ),
                _ExportCard(
                  icon: LucideIcons.users,
                  title: l10n.reportPeopleTitle,
                  body: l10n.reportPeopleBody,
                  action: FilledButton.icon(
                    onPressed: busy
                        ? null
                        : () => viewModel.onExport(ReportKind.people),
                    icon: const Icon(LucideIcons.download),
                    label: Text(l10n.exportCsv),
                  ),
                ),
                _ExportCard(
                  icon: LucideIcons.shield,
                  title: l10n.personalDataTitle,
                  body: l10n.personalDataBody,
                  action: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 220,
                        child: DropdownButtonFormField<String?>(
                          initialValue: vmState.personId,
                          isExpanded: true,
                          decoration: InputDecoration(
                              labelText: l10n.personalDataPerson,
                              isDense: true),
                          items: [
                            for (final member in vmState.members)
                              DropdownMenuItem(
                                  value: member.id, child: Text(member.name)),
                          ],
                          onChanged: viewModel.onSelectPerson,
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        onPressed: busy || vmState.personId == null
                            ? null
                            : viewModel.onExportPersonalData,
                        icon: const Icon(LucideIcons.download),
                        label: Text(l10n.exportJson),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ExportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Widget action;

  const _ExportCard(
      {required this.icon,
      required this.title,
      required this.body,
      required this.action});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colorScheme.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(body,
                        style: TextStyle(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              action,
            ],
          ),
        ),
      ),
    );
  }
}
