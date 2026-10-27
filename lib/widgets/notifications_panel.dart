import 'package:flutter/material.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/app_notification.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:scoreboard/widgets/common/content_state_view.dart';

class NotificationsPanel extends StatelessWidget {
  final List<AppNotification> notifications;
  final void Function(AppNotification) onTap;
  final VoidCallback onMarkAllRead;

  const NotificationsPanel(
      {super.key,
      required this.notifications,
      required this.onTap,
      required this.onMarkAllRead});

  static IconData _icon(NotificationType type) => switch (type) {
        NotificationType.peerAchievementReceived => LucideIcons.handshake,
        NotificationType.verifiedAchievementReceived => LucideIcons.badgeCheck,
        NotificationType.levelUp => LucideIcons.medal,
        NotificationType.requestApproved => LucideIcons.circleCheck,
        NotificationType.requestRejected => LucideIcons.circleX,
        NotificationType.newRequest => LucideIcons.inbox,
        NotificationType.newNomination => LucideIcons.userCheck,
        NotificationType.feedReaction => LucideIcons.partyPopper,
        NotificationType.feedComment => LucideIcons.messageCircle,
        NotificationType.weeklyRecap => LucideIcons.trendingUp,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final hasUnread = notifications.any((n) => !n.read);

    return Material(
      color: colorScheme.surfaceContainer,
      // Enough lift to read as a popover; the border does the rest.
      elevation: 6,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 8, 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(l10n.notificationsTitle,
                        style: AppText.sectionTitle),
                  ),
                  TextButton(
                    onPressed: hasUnread ? onMarkAllRead : null,
                    child: Text(l10n.markAllRead),
                  ),
                ],
              ),
            ),
            const Divider(),
            if (notifications.isEmpty)
              EmptyNote(
                  compact: true,
                  icon: LucideIcons.bellOff,
                  message: l10n.notificationsEmpty)
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: notifications.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 2),
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return InkWell(
                      onTap: () => onTap(notification),
                      child: Container(
                        color: notification.read
                            ? null
                            : colorScheme.primary.withValues(alpha: 0.06),
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: colorScheme.surfaceContainerHighest,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(_icon(notification.type),
                                  size: 18, color: colorScheme.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notification.title(l10n),
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: notification.read
                                              ? FontWeight.w500
                                              : FontWeight.w700)),
                                  const SizedBox(height: 2),
                                  Text(notification.body(l10n),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          color: colorScheme.onSurfaceVariant)),
                                  const SizedBox(height: 4),
                                  Text(timeAgo(l10n, notification.createdAt),
                                      style: TextStyle(
                                          fontSize: 11.5,
                                          color: colorScheme.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            if (!notification.read)
                              Container(
                                margin: const EdgeInsets.only(top: 6, left: 8),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: colorScheme.primary,
                                    shape: BoxShape.circle),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
