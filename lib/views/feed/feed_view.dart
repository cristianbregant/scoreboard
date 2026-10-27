import 'package:scoreboard/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/model/feed.dart';
import 'package:scoreboard/views/_base/base_state.dart';
import 'package:scoreboard/views/_base/base_stateful_widget.dart';
import 'package:scoreboard/views/_base/base_widget.dart';
import 'package:scoreboard/views/feed/feed_contract.dart';
import 'package:scoreboard/widgets/achievement_badge.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';
import 'package:scoreboard/widgets/common/page_header.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FeedView extends BaseStatefulWidget {
  FeedView({super.key}) : super(_FeedViewState());
}

class _FeedViewState
    extends BaseState<FeedView, FeedViewModelContract, FeedState>
    implements FeedViewContract {
  final Map<String, TextEditingController> _commentControllers = {};

  TextEditingController _controllerFor(String achievementId) =>
      _commentControllers.putIfAbsent(
          achievementId, () => TextEditingController());

  @override
  void dispose() {
    for (final controller in _commentControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void clearCommentField(String achievementId) =>
      _commentControllers[achievementId]?.clear();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FeedViewModelContract, FeedState>(
        model: viewModel,
        builder: (context, viewModel, child) => Scaffold(
              body: ContentStateView(
                state: vmState,
                onRetry: viewModel.loadFeed,
                builder: (context) => ListView(
                  padding: pagePadding,
                  children: [
                    PageHeader(
                        title: context.l10n.feedTitle,
                        subtitle: context.l10n.feedSubtitle),
                    const SizedBox(height: 24),
                    if (vmState.posts.isEmpty)
                      EmptyNote(
                          icon: LucideIcons.newspaper,
                          message: context.l10n.feedEmpty)
                    else
                      for (final post in vmState.posts) _buildPost(post),
                  ],
                ),
              ),
            ));
  }

  Widget _buildPost(FeedPost post) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final achievement = post.achievement;
    final verified = achievement.verified == true;
    final mutedStyle =
        TextStyle(fontSize: 12.5, color: colorScheme.onSurfaceVariant);
    final expanded = vmState.expandedComments.contains(achievement.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(
                      initials: post.recipient.initials,
                      imagePath: post.recipient.avatarPath),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: post.recipient.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                          TextSpan(text: ' ${l10n.feedEarned} '),
                          TextSpan(
                              text: achievement.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700)),
                        ])),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            if (verified)
                              CompanyLogo(
                                  name: achievement.company ?? '',
                                  brand: achievement.companyBrand,
                                  size: 14)
                            else
                              Icon(LucideIcons.user,
                                  size: 14,
                                  color: colorScheme.onSurfaceVariant),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                  '${verified ? l10n.shareImageIssuedBy(achievement.company ?? '') : l10n.cardFrom(achievement.awardedByName ?? '')} · ${timeAgo(l10n, achievement.date!)}',
                                  overflow: TextOverflow.ellipsis,
                                  style: mutedStyle),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (achievement.note != null) ...[
                const SizedBox(height: 12),
                Text('“${achievement.note}”',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, height: 1.4)),
              ],
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    AchievementBadge(achievement: achievement, size: 48),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(achievement.name ?? '',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 2),
                          Text(achievement.description ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: mutedStyle),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    TagChip(
                        label: achievement.tier.localized(l10n),
                        color: achievement.tier.color),
                    const SizedBox(width: 6),
                    TagChip(
                        label: l10n.xpValue(achievement.points ?? 0),
                        color: colorScheme.primary),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  for (final type in ReactionType.values)
                    _ReactionButton(
                      type: type,
                      count: post.reactionCounts[type] ?? 0,
                      selected: post.myReaction == type,
                      onTap: () => viewModel.onToggleReaction(post, type),
                    ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () =>
                        viewModel.onToggleComments(achievement.id!),
                    icon: Icon(
                        expanded
                            ? LucideIcons.chevronUp
                            : LucideIcons.messageCircle,
                        size: 18),
                    label: Text(l10n.commentsCount(post.comments.length)),
                  ),
                ],
              ),
              if (expanded) _buildComments(post),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComments(FeedPost post) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final controller = _controllerFor(post.achievement.id!);

    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Column(
        children: [
          for (final (comment, author) in post.comments)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAvatar(
                      initials: author.initials,
                      imagePath: author.avatarPath,
                      radius: 14),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(author.name,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(width: 8),
                              Text(timeAgo(l10n, comment.createdAt),
                                  style: TextStyle(
                                      fontSize: 11.5,
                                      color: colorScheme.onSurfaceVariant)),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(comment.text,
                              style: const TextStyle(fontSize: 13.5)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLength: 500,
                  decoration: InputDecoration(
                      hintText: l10n.commentHint, counterText: ''),
                  onSubmitted: (text) =>
                      viewModel.onSubmitComment(post.achievement.id!, text),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: l10n.commonSend,
                onPressed: () => viewModel.onSubmitComment(
                    post.achievement.id!, controller.text),
                icon: const Icon(LucideIcons.send, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  final ReactionType type;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  const _ReactionButton(
      {required this.type,
      required this.count,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.legible(type.color, tint: 0.16);
    return Padding(
        padding: const EdgeInsets.only(right: 6),
        // Announced as "Like, 3, selected" rather than just "3".
        child: Semantics(
          button: true,
          selected: selected,
          child: Tooltip(
            message: type.localized(context.l10n),
            child: Material(
              color: selected
                  ? type.color.withValues(alpha: 0.16)
                  : Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(
                      color: selected ? color : colorScheme.outlineVariant)),
              child: InkWell(
                customBorder: const StadiumBorder(),
                onTap: onTap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(type.icon,
                          size: 16,
                          color: selected || count > 0
                              ? color
                              : colorScheme.onSurfaceVariant),
                      if (count > 0) ...[
                        const SizedBox(width: 5),
                        Text('$count',
                            style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color:
                                    selected ? color : colorScheme.onSurface)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
