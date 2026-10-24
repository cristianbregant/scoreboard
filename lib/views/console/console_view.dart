import 'package:scoreboard/core/locator/locator.dart';
import 'package:scoreboard/views/views.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/catalog_achievement.dart';
import 'package:scoreboard/model/verification_request.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/console/console_contract.dart';
import 'package:scoreboard/widgets/achievement_badge.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/request_status_chip.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/catalog_achievement_dialog.dart';
import 'package:scoreboard/widgets/dialogs/dialog_scaffold.dart';
import 'package:scoreboard/widgets/charts/monthly_achievements_chart.dart';
import 'package:scoreboard/widgets/interactive_card.dart';
import 'package:scoreboard/model/user_profile.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';

class ConsoleView extends BaseStatefulWidget {
  ConsoleView({super.key}) : super(_ConsoleViewState());
}

class _ConsoleViewState
    extends BaseState<ConsoleView, ConsoleViewModelContract, ConsoleState>
    with SendAchievementDialogs
    implements ConsoleViewContract {
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Future<CatalogAchievementDraft?> askCatalogAchievement(
          {CatalogAchievement? existing}) =>
      showCatalogAchievementDialog(context,
          company: vmState.company!, existing: existing);

  @override
  Future<String?> askRejectionReason() {
    final controller = TextEditingController();
    final l10n = context.l10n;
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.rejectDialogTitle),
        content: SizedBox(
          width: 420,
          child: TextField(
            controller: controller,
            autofocus: true,
            maxLines: 3,
            maxLength: 200,
            decoration: InputDecoration(hintText: l10n.rejectReasonHint),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.commonCancel)),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(l10n.reject)),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  @override
  void clearAssignForm() => _noteController.clear();

  /// The sections with a screen of their own; the others are built here.
  static Widget? _sectionScreen(ConsoleSection section) => switch (section) {
        ConsoleSection.members => getIt<MembersAdminView>(),
        ConsoleSection.teams => getIt<TeamsAdminView>(),
        ConsoleSection.seasons => getIt<SeasonsAdminView>(),
        ConsoleSection.reports => getIt<ReportsView>(),
        ConsoleSection.activity => getIt<ActivityView>(),
        ConsoleSection.company => getIt<CompanySettingsView>(),
        ConsoleSection.catalog ||
        ConsoleSection.assign ||
        ConsoleSection.requests ||
        ConsoleSection.insights =>
          null,
      };

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ConsoleViewModelContract, ConsoleState>(
        model: viewModel,
        builder: (context, viewModel, child) {
          final screen = _sectionScreen(vmState.section);
          if (screen != null) {
            return KeyedSubtree(key: ValueKey(vmState.section), child: screen);
          }
          return Scaffold(
            body: ContentStateView(
              state: vmState,
              onRetry: viewModel.loadConsole,
              builder: (context) {
                final l10n = context.l10n;
                if (vmState.company == null) {
                  return Center(child: Text(l10n.errorNotAdmin));
                }
                return ListView(
                  padding: pagePadding,
                  children: [
                    PageHeader(
                      title: switch (vmState.section) {
                        ConsoleSection.assign => l10n.consoleAssign,
                        ConsoleSection.requests => l10n.navRequests,
                        ConsoleSection.insights => l10n.consoleStats,
                        _ => l10n.consoleCatalog,
                      },
                      subtitle: l10n.consoleSubtitle(vmState.company!.name),
                    ),
                    const SizedBox(height: 24),
                    switch (vmState.section) {
                      ConsoleSection.assign => _buildAssign(),
                      ConsoleSection.requests => _buildRequests(),
                      ConsoleSection.insights => _buildInsights(),
                      _ => _buildCatalog(),
                    },
                  ],
                );
              },
            ),
          );
        });
  }

  Widget _buildCatalog() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final company = vmState.company!;
    final items = vmState.visibleCatalog;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // One control for screen readers: the switch, named by its label.
            MergeSemantics(
              child: Row(
                children: [
                  Switch(
                      value: vmState.showArchived,
                      onChanged: viewModel.onToggleShowArchived),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () =>
                        viewModel.onToggleShowArchived(!vmState.showArchived),
                    child: Text(l10n.showArchived),
                  ),
                ],
              ),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: viewModel.onTapNewCatalogAchievement,
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.newCatalogAchievement),
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (items.isEmpty)
          Text(l10n.catalogEmpty)
        else
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              for (final item in items)
                SizedBox(
                  width: 170,
                  child: Opacity(
                    opacity: item.archived ? 0.5 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InteractiveCard(
                          achievement: item.preview(company),
                          heroTag: 'console_${item.id}',
                          width: 170,
                          onPressed: () =>
                              viewModel.onTapEditCatalogAchievement(item),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (item.archived)
                              TagChip(
                                  label: l10n.archivedLabel,
                                  icon: Icons.archive_outlined)
                            else
                              Expanded(
                                child: Text(item.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colorScheme.onSurfaceVariant)),
                              ),
                            if (item.archived) const Spacer(),
                            IconButton(
                              tooltip: l10n.commonEdit,
                              visualDensity: VisualDensity.compact,
                              onPressed: () =>
                                  viewModel.onTapEditCatalogAchievement(item),
                              icon: const Icon(Icons.edit_outlined, size: 18),
                            ),
                            IconButton(
                              tooltip:
                                  item.archived ? l10n.restore : l10n.archive,
                              visualDensity: VisualDensity.compact,
                              onPressed: () => viewModel.onToggleArchived(item),
                              icon: Icon(
                                  item.archived
                                      ? Icons.unarchive_outlined
                                      : Icons.archive_outlined,
                                  size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildAssign() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final selected = vmState.assignAchievement;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FieldLabel(l10n.fieldAchievement),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final item in vmState.activeCatalog)
                    ChoiceChip(
                      avatar: Icon(
                          achievementIcons[item.icon] ??
                              Icons.emoji_events_rounded,
                          size: 16,
                          color: AchievementTier.fromPoints(item.points).color),
                      label: Text(item.name),
                      selected: item.id == vmState.assignCatalogId,
                      onSelected: (_) =>
                          viewModel.onSelectAssignAchievement(item.id),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  FieldLabel(l10n.communityPeople),
                  const Spacer(),
                  TextButton(
                      onPressed: selected == null
                          ? null
                          : viewModel.onSelectAllAssignees,
                      child: Text(l10n.selectAll)),
                ],
              ),
              Card(
                child: Column(
                  children: [
                    for (final member in vmState.members)
                      CheckboxListTile(
                        enabled: selected != null &&
                            !vmState.owners.contains(member.id),
                        value: vmState.owners.contains(member.id) ||
                            vmState.assignees.contains(member.id),
                        onChanged: (_) => viewModel.onToggleAssignee(member.id),
                        secondary: UserAvatar(
                            initials: member.initials,
                            imagePath: member.avatarPath,
                            radius: 16),
                        title: Text(member.name),
                        subtitle: Text(
                            selected != null &&
                                    vmState.owners.contains(member.id)
                                ? l10n.alreadyHasIt
                                : member.role,
                            style: TextStyle(
                                fontSize: 12.5,
                                color: colorScheme.onSurfaceVariant)),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FieldLabel(l10n.assignNoteLabel),
              TextField(
                controller: _noteController,
                maxLength: 140,
                decoration: InputDecoration(hintText: l10n.assignNoteHint),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: selected == null ||
                          vmState.assignees.isEmpty ||
                          vmState.isAssigning
                      ? null
                      : () => viewModel.onAssign(_noteController.text),
                  icon: const Icon(Icons.verified_rounded, size: 18),
                  label: Text(l10n.assignButton(vmState.assignees.length)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        SizedBox(
          width: 230,
          child: selected == null
              ? Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(l10n.pickAchievementHint,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.onSurfaceVariant)),
                )
              : Center(
                  child: InteractiveCard(
                    achievement: selected.preview(vmState.company!,
                        date: DateTime.now()),
                    heroTag: 'assign_preview',
                    width: 210,
                    onPressed: () {},
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildInsights() {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final insights = vmState.insights;
    if (insights == null) return Text(l10n.statsNoData);
    final mutedStyle =
        TextStyle(fontSize: 12.5, color: colorScheme.onSurfaceVariant);

    Widget panel(String title, String? hint, List<Widget> rows) => Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                  if (hint != null) ...[
                    const SizedBox(height: 2),
                    Text(hint, style: mutedStyle),
                  ],
                  const SizedBox(height: 12),
                  if (rows.isEmpty) Text(l10n.statsNoData, style: mutedStyle),
                  ...rows,
                ],
              ),
            ),
          ),
        );

    Widget personRow(UserProfile person, String value, {Widget? action}) =>
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              UserAvatar(
                  initials: person.initials,
                  imagePath: person.avatarPath,
                  radius: 14),
              const SizedBox(width: 10),
              Expanded(
                child: Text(person.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
              ),
              Text(value, style: mutedStyle),
              if (action != null) action,
            ],
          ),
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StatRow(tiles: [
          StatTile(
              label: l10n.statsIssuedThisMonth,
              value: '${insights.verifiedThisMonth}',
              icon: Icons.verified_rounded,
              color: AppColors.verified),
          StatTile(
              label: l10n.statsPeerThisMonth,
              value: '${insights.peerThisMonth}',
              icon: Icons.handshake_rounded,
              color: AchievementTier.peer.color),
          StatTile(
              label: l10n.statsActiveSenders,
              value: '${insights.activeSenders}',
              icon: Icons.volunteer_activism_rounded),
          StatTile(
              label: l10n.statsCoverage,
              value: l10n.percentValue(insights.coveragePercent),
              icon: Icons.groups_rounded,
              color: AppColors.success),
        ]),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.statsMonthlyChart,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                MonthlyAchievementsChart(months: insights.monthly),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            panel(l10n.statsUnderRecognized, l10n.statsUnderRecognizedHint, [
              for (final (person, count) in insights.leastRecognized)
                personRow(person, l10n.achievementsCount(count),
                    action: person.id == vmState.currentUserId
                        ? null
                        : IconButton(
                            tooltip: l10n.sendAnAchievement,
                            visualDensity: VisualDensity.compact,
                            onPressed: () => viewModel.onTapSendAchievement(
                                colleagueId: person.id),
                            icon: const Icon(Icons.volunteer_activism_rounded,
                                size: 18),
                          )),
            ]),
            const SizedBox(width: 12),
            panel(l10n.statsTopSenders, l10n.statsTopSendersHint, [
              for (final (person, count) in insights.topSenders)
                personRow(person, l10n.sentCount(count)),
            ]),
            const SizedBox(width: 12),
            panel(l10n.statsTopCatalog, null, [
              for (final (item, count) in insights.topCatalog)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      AchievementBadge(
                          achievement: item.preview(vmState.company!),
                          size: 28),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(item.name,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                      Text(l10n.issuedTimes(count), style: mutedStyle),
                    ],
                  ),
                ),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildRequests() {
    final l10n = context.l10n;
    if (vmState.requests.isEmpty) return Text(l10n.requestsEmpty);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (vmState.pendingRequests.isNotEmpty) ...[
          SectionTitle(l10n.pendingSection),
          for (final request in vmState.pendingRequests) _buildRequest(request),
        ],
        if (vmState.decidedRequests.isNotEmpty) ...[
          SectionTitle(l10n.decidedSection),
          for (final request in vmState.decidedRequests) _buildRequest(request),
        ],
      ],
    );
  }

  Widget _buildRequest(VerificationRequest request) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final member = vmState.member(request.userId);
    final item = vmState.catalogItem(request.catalogId);
    final mutedStyle =
        TextStyle(fontSize: 12.5, color: colorScheme.onSurfaceVariant);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                  initials: member?.initials ?? '?',
                  imagePath: member?.avatarPath),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: member?.name ?? '-',
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: '  ·  ${timeAgo(l10n, request.createdAt)}',
                          style: mutedStyle),
                    ])),
                    if (request.nominatedById != null) ...[
                      const SizedBox(height: 6),
                      TagChip(
                          icon: Icons.how_to_reg_rounded,
                          color: colorScheme.primary,
                          label: l10n.requestNominatedBy(
                              vmState.member(request.nominatedById!)?.name ??
                                  '-')),
                    ],
                    const SizedBox(height: 6),
                    if (item != null)
                      Row(
                        children: [
                          AchievementBadge(
                              achievement: item.preview(vmState.company!),
                              size: 24),
                          const SizedBox(width: 8),
                          Text(item.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text(l10n.xpValue(item.points), style: mutedStyle),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Text('“${request.message}”',
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                    if (request.evidenceUrl != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact),
                          onPressed: () =>
                              openExternalLink(request.evidenceUrl!),
                          icon: const Icon(Icons.link_rounded, size: 16),
                          label: Text(l10n.evidenceLink),
                        ),
                      ),
                    if (request.rejectionReason != null) ...[
                      const SizedBox(height: 6),
                      Text(l10n.rejectionReason(request.rejectionReason!),
                          style: mutedStyle),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (request.status == RequestStatus.pending) ...[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error),
                  onPressed: () => viewModel.onReject(request),
                  child: Text(l10n.reject),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => viewModel.onApprove(request),
                  child: Text(l10n.approve),
                ),
              ] else
                RequestStatusChip(status: request.status),
            ],
          ),
        ),
      ),
    );
  }
}
