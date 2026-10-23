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
import 'package:scoreboard/widgets/interactive_card.dart';

class ConsoleView extends BaseStatefulWidget {
  ConsoleView({super.key}) : super(_ConsoleViewState());
}

class _ConsoleViewState
    extends BaseState<ConsoleView, ConsoleViewModelContract, ConsoleState>
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

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ConsoleViewModelContract, ConsoleState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
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
                        title: l10n.navConsole,
                        subtitle: l10n.consoleSubtitle(vmState.company!.name),
                        trailing: SegmentedButton<ConsoleTab>(
                          showSelectedIcon: false,
                          segments: [
                            ButtonSegment(
                                value: ConsoleTab.catalog,
                                icon: const Icon(
                                    Icons.collections_bookmark_outlined),
                                label: Text(l10n.consoleCatalog)),
                            ButtonSegment(
                                value: ConsoleTab.assign,
                                icon: const Icon(Icons.how_to_reg_outlined),
                                label: Text(l10n.consoleAssign)),
                            ButtonSegment(
                                value: ConsoleTab.requests,
                                icon: const Icon(Icons.inbox_outlined),
                                label: Text(l10n.consoleRequests(
                                    vmState.pendingRequests.length))),
                          ],
                          selected: {vmState.tab},
                          onSelectionChanged: (value) =>
                              viewModel.onChangeTab(value.first),
                        ),
                      ),
                      const SizedBox(height: 24),
                      switch (vmState.tab) {
                        ConsoleTab.catalog => _buildCatalog(),
                        ConsoleTab.assign => _buildAssign(),
                        ConsoleTab.requests => _buildRequests(),
                      },
                    ],
                  );
                },
              ),
            ));
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
            Switch(
                value: vmState.showArchived,
                onChanged: viewModel.onToggleShowArchived),
            const SizedBox(width: 8),
            Text(l10n.showArchived),
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
