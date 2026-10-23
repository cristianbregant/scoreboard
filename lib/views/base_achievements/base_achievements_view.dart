import 'package:flutter/material.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/model/achievement_template.dart';
import 'package:scoreboard/model/send_achievement.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/_shared/send_achievement_flow.dart';
import 'package:scoreboard/views/base_achievements/base_achievements_contract.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/leaderboard_tile.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:scoreboard/widgets/dialogs/create_template_dialog.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

class BaseAchievementsView extends BaseStatefulWidget {
  BaseAchievementsView({super.key}) : super(_BaseAchievementsViewState());
}

class _BaseAchievementsViewState extends BaseState<BaseAchievementsView,
        BaseAchievementsViewModelContract, BaseAchievementsState>
    with SendAchievementDialogs
    implements BaseAchievementsViewContract {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<BaseAchievementsViewModelContract, BaseAchievementsState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
                body: ContentStateView(
              state: vmState,
              onRetry: viewModel.loadTemplates,
              builder: (context) => ListView(
                padding: pagePadding,
                children: [
                  PageHeader(
                    title: "Base achievements",
                    subtitle: "Create achievements and send them to your "
                        "colleagues",
                    trailing: FilledButton.icon(
                      onPressed: viewModel.onTapCreateTemplate,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text("New base achievement"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildExplanation(context),
                  SectionTitle("Library · ${vmState.templates.length}"),
                  if (vmState.templates.isEmpty)
                    const Text("No base achievements yet. Create the first!")
                  else
                    Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: vmState.templates.map(_buildTemplate).toList(),
                    ),
                  SectionTitle("Sent by you · ${vmState.sent.length}"),
                  if (vmState.sent.isEmpty)
                    Text(
                        "You haven't sent any achievement yet. Pick one from "
                        "the library and make a colleague's day.",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant))
                  else
                    ...vmState.sent.map((a) => _buildSent(context, a)),
                ],
              ),
            )));
  }

  Widget _buildExplanation(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final peerColor = AchievementTier.peer.color;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: peerColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: peerColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.handshake_rounded, color: peerColor),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              "Base achievements are sent between colleagues and are worth "
              "up to 50 XP. Verified achievements are issued only by your "
              "company. You can send each base achievement to the same "
              "colleague once.",
              style: TextStyle(fontSize: 13, color: colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplate(AchievementTemplate template) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: InteractiveCard.baseWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InteractiveCard(
            achievement: template.preview(),
            heroTag: 'template_${template.id}',
            onPressed: () =>
                viewModel.onTapSendAchievement(templateId: template.id),
          ),
          const SizedBox(height: 10),
          Text(
              vmState.isOwn(template)
                  ? "Created by you"
                  : "By ${template.createdByName}",
              style:
                  TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonalIcon(
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12)),
                  onPressed: () =>
                      viewModel.onTapSendAchievement(templateId: template.id),
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text("Send"),
                ),
              ),
              if (vmState.isOwn(template)) ...[
                const SizedBox(width: 8),
                IconButton.outlined(
                  tooltip: "Delete",
                  onPressed: () => viewModel.onTapDeleteTemplate(template),
                  icon: const Icon(Icons.delete_outline_rounded, size: 20),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSent(BuildContext context, Achievement achievement) {
    final colorScheme = Theme.of(context).colorScheme;
    final recipient = vmState.colleagues[achievement.userId];
    final note = achievement.note;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: [
            UserAvatar(
                initials: recipient?.initials ?? '?',
                imagePath: recipient?.avatarPath),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: achievement.name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: "  to  ",
                        style: TextStyle(color: colorScheme.onSurfaceVariant)),
                    TextSpan(
                        text: recipient?.name ?? '-',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ])),
                  const SizedBox(height: 2),
                  Text(
                      [
                        formatDate(achievement.date),
                        if (note != null) "“$note”",
                      ].join(" · "),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.5, color: colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            PointsBadge(points: achievement.points ?? 0),
          ],
        ),
      ),
    );
  }

  @override
  Future<AchievementTemplateDraft?> askNewTemplate() =>
      showCreateTemplateDialog(context);

  @override
  Future<bool> confirmDeleteTemplate(AchievementTemplate template) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete \"${template.name}\"?"),
        content: const Text(
            "It will be removed from the library. Colleagues who already "
            "received it keep their achievement."),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancel")),
          FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Delete")),
        ],
      ),
    );
    return confirmed ?? false;
  }
}
