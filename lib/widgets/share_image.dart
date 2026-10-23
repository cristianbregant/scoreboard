import 'package:flutter/material.dart';
import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/profile_banner.dart';
import 'package:scoreboard/widgets/common/stat_tile.dart';
import 'package:scoreboard/widgets/interactive_card.dart';

/// Image attached to a LinkedIn post, laid out at LinkedIn's recommended
/// 1200x627 and always in the dark theme so it looks the same for everyone.
class ShareImage extends StatelessWidget {
  static const Size size = Size(1200, 627);

  final Achievement achievement;

  const ShareImage({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.themeDataDark;
    // Keep the app's font family (the text theme may be overridden).
    final fontFamily = Theme.of(context).textTheme.bodyMedium?.fontFamily;
    return Theme(
      data: theme.copyWith(
          textTheme: theme.textTheme.apply(fontFamily: fontFamily)),
      child: Builder(builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final tier = achievement.tier;
    final verified = achievement.verified == true;

    return SizedBox.fromSize(
      size: size,
      child: Material(
        color: colorScheme.surface,
        child: Stack(
          children: [
            Positioned.fill(
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (rect) => const LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  stops: [0, 0.6],
                ).createShader(rect),
                child: Opacity(
                  opacity: 0.5,
                  child: BannerPatternView(
                      preset: bannerPresetOf('gold_topography')),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 64, 72, 56),
              child: Row(
                children: [
                  InteractiveCard(
                    achievement: achievement,
                    heroTag: 'share_${achievement.id}',
                    width: 320,
                    flipOnTap: true,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 72),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(l10n.shareImageHeadline,
                            style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary)),
                        const SizedBox(height: 16),
                        Text(achievement.name ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 54,
                                height: 1.05,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -1.4)),
                        const SizedBox(height: 16),
                        Text(achievement.description ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 22,
                                height: 1.4,
                                color: colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 28),
                        Row(
                          children: [
                            if (verified)
                              CompanyLogo(
                                  name: achievement.company ?? '',
                                  brand: achievement.companyBrand,
                                  size: 40)
                            else
                              Icon(Icons.handshake_rounded,
                                  size: 32, color: tier.color),
                            const SizedBox(width: 14),
                            Flexible(
                              child: Text(
                                  verified
                                      ? l10n.shareImageIssuedBy(
                                          achievement.company ?? '')
                                      : l10n.cardFrom(
                                          achievement.awardedByName ?? ''),
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // The app's chips are sized for the UI; scale them
                        // up to match the rest of the image.
                        Transform.scale(
                          scale: 1.4,
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10,
                            children: [
                              TagChip(
                                  label: tier.localized(l10n),
                                  icon: Icons.workspace_premium_rounded,
                                  color: tier.color),
                              TagChip(
                                  label: l10n.xpValue(achievement.points ?? 0),
                                  icon: Icons.bolt_rounded,
                                  color: colorScheme.primary),
                              if (verified)
                                TagChip(
                                    label: l10n.labelVerified,
                                    icon: Icons.verified_rounded,
                                    color: AppColors.verified),
                              TagChip(
                                  label: formatDate(achievement.date),
                                  icon: Icons.event_rounded),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.emoji_events_rounded,
                                  color: colorScheme.onPrimary, size: 18),
                            ),
                            const SizedBox(width: 10),
                            const Text('Scoreboard',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.4)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
