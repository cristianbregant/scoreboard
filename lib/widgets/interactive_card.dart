import 'package:scoreboard/core/l10n_messages.dart';
import 'package:scoreboard/core/localization_manager.dart';
import 'package:scoreboard/generated/l10n.dart';
import 'dart:math' as math;

import 'package:scoreboard/core/formatters.dart';
import 'package:scoreboard/core/theme.dart';
import 'package:scoreboard/model/achievement.dart';
import 'package:scoreboard/widgets/achievement_style.dart';
import 'package:scoreboard/widgets/common/company_logo.dart';
import 'package:scoreboard/widgets/common/user_avatar.dart';
import 'package:flutter/material.dart';

class InteractiveCard extends StatefulWidget {
  final Achievement achievement;
  final VoidCallback onPressed;
  final Object? heroTag;
  final double width;

  /// When true a tap flips the card instead of calling [onPressed]; when
  /// false a flip button appears on hover.
  final bool flipOnTap;

  const InteractiveCard(
      {super.key,
      required this.achievement,
      required this.onPressed,
      this.heroTag,
      this.width = baseWidth,
      this.flipOnTap = false});

  /// The card is laid out at this size and scaled to [width].
  static const double baseWidth = 190;
  static const double baseHeight = 266;
  static const Size baseSize = Size(baseWidth, baseHeight);

  /// Only achievements someone actually received have a back: verified ones
  /// show the issuing company, the others the colleague who sent them.
  static bool canFlip(Achievement achievement) =>
      achievement.verified == true || achievement.awardedByName != null;

  @override
  State<InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<InteractiveCard>
    with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 180);

  late final AnimationController _flip = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 550));

  /// Pointer position relative to the card center, in the range -1..1.
  Offset pointer = Offset.zero;
  bool isHovering = false;

  bool get canFlip => InteractiveCard.canFlip(widget.achievement);

  Size get cardSize => Size(widget.width,
      widget.width * InteractiveCard.baseHeight / InteractiveCard.baseWidth);

  void _toggleFlip() {
    final showingBack = _flip.status == AnimationStatus.forward ||
        _flip.status == AnimationStatus.completed;
    showingBack ? _flip.reverse() : _flip.forward();
  }

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag ?? ValueKey(widget.achievement.id),
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: widget.flipOnTap && canFlip ? _toggleFlip : widget.onPressed,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => isHovering = true),
            onExit: (_) => setState(() {
              isHovering = false;
              pointer = Offset.zero;
            }),
            onHover: (event) => setState(() {
              pointer = Offset(
                (event.localPosition.dx / cardSize.width) * 2 - 1,
                (event.localPosition.dy / cardSize.height) * 2 - 1,
              );
            }),
            // The shadow lives outside the 3D transform: blurs are not
            // rendered reliably under a perspective matrix.
            child: AnimatedContainer(
              duration: _animationDuration,
              curve: Curves.easeOut,
              width: cardSize.width,
              height: cardSize.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: isHovering ? 0.35 : 0.18),
                    blurRadius: isHovering ? 36 : 18,
                    spreadRadius: -6,
                    offset: Offset(0, isHovering ? 18 : 10),
                  ),
                ],
              ),
              child: AnimatedContainer(
                duration: _animationDuration,
                curve: Curves.easeOut,
                transformAlignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001) // perspective
                  ..scaleByDouble(
                      isHovering ? 1.06 : 1.0, isHovering ? 1.06 : 1.0, 1, 1)
                  ..rotateX(-pointer.dy * 0.18)
                  ..rotateY(pointer.dx * 0.18),
                child: FittedBox(
                  child: SizedBox.fromSize(
                    size: InteractiveCard.baseSize,
                    child: Stack(
                      children: [
                        Positioned.fill(child: _buildFlippingFaces()),
                        if (canFlip && !widget.flipOnTap)
                          Positioned(
                            right: 10,
                            top: 136,
                            child: IgnorePointer(
                              ignoring: !isHovering,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 150),
                                opacity: isHovering ? 1 : 0,
                                child: _FlipButton(onTap: _toggleFlip),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlippingFaces() {
    return AnimatedBuilder(
      animation: _flip,
      builder: (context, _) {
        final angle = Curves.easeInOutCubic.transform(_flip.value) * math.pi;
        final showBack = angle > math.pi / 2;
        final face = _CardFrame(
          achievement: widget.achievement,
          pointer: pointer,
          isHovering: isHovering,
          child: showBack
              ? _CardBack(achievement: widget.achievement)
              : _CardFront(achievement: widget.achievement),
        );

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(angle),
          // The back is drawn mirrored so it reads correctly once turned.
          child: showBack
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: face)
              : face,
        );
      },
    );
  }
}

/// Tier-colored border, rounded clip and the light that follows the pointer.
class _CardFrame extends StatelessWidget {
  final Achievement achievement;
  final Offset pointer;
  final bool isHovering;
  final Widget child;

  const _CardFrame(
      {required this.achievement,
      required this.pointer,
      required this.isHovering,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      // The tier gradient doubles as a thin glowing border.
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: achievement.tier.gradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.5),
        child: Stack(
          children: [
            Positioned.fill(child: child),
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isHovering ? 1 : 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(pointer.dx, pointer.dy),
                        radius: 0.9,
                        colors: [
                          Colors.white.withValues(alpha: 0.22),
                          Colors.white.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardFront extends StatelessWidget {
  final Achievement achievement;

  const _CardFront({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildArtwork(achievement.tier, context.l10n),
        Expanded(
            child: _buildInfo(Theme.of(context).colorScheme, context.l10n)),
      ],
    );
  }

  Widget _buildArtwork(AchievementTier tier, AppLocalization l10n) {
    return Container(
      height: 150,
      decoration: BoxDecoration(gradient: tier.gradient),
      child: Stack(
        children: [
          Positioned(
            right: -28,
            bottom: -34,
            child: Icon(achievement.iconData,
                size: 150, color: Colors.white.withValues(alpha: 0.12)),
          ),
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.45), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: Icon(achievement.iconData, size: 34, color: Colors.white),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: _Pill(
              text: l10n.xpValue(achievement.points ?? 0),
              background: Colors.black.withValues(alpha: 0.28),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: _Pill(
              text: tier.localized(l10n).toUpperCase(),
              background: Colors.white.withValues(alpha: 0.22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(ColorScheme colorScheme, AppLocalization l10n) {
    final mutedStyle =
        TextStyle(fontSize: 10.5, color: colorScheme.onSurfaceVariant);
    final Widget originIcon;
    final String originLabel;
    if (achievement.verified == true) {
      originIcon = CompanyLogo(
          name: achievement.company ?? '',
          brand: achievement.companyBrand,
          size: 14);
      originLabel = achievement.company ?? '';
    } else if (achievement.awardedByName != null) {
      originIcon = Icon(Icons.person_rounded,
          size: 12, color: colorScheme.onSurfaceVariant);
      originLabel = l10n.cardFrom(achievement.awardedByName!);
    } else {
      originIcon = Icon(Icons.handshake_rounded,
          size: 12, color: colorScheme.onSurfaceVariant);
      originLabel = l10n.cardBaseAchievement;
    }

    return Container(
      color: colorScheme.surfaceContainer,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            achievement.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface),
          ),
          const Spacer(),
          Row(
            children: [
              originIcon,
              const SizedBox(width: 5),
              Expanded(
                child: Text(originLabel,
                    overflow: TextOverflow.ellipsis, style: mutedStyle),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (achievement.date != null) ...[
                Icon(Icons.calendar_today_rounded,
                    size: 11, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(formatDate(achievement.date), style: mutedStyle),
              ],
              const Spacer(),
              if (achievement.verified == true)
                Tooltip(
                  message: l10n.labelVerified,
                  child: Icon(Icons.verified_rounded,
                      semanticLabel: l10n.labelVerified,
                      color: AppColors.verified,
                      size: 16),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Verified: the issuing company, like a certificate. Received from a
/// colleague: who sent it and their message.
class _CardBack extends StatelessWidget {
  final Achievement achievement;

  const _CardBack({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final verified = achievement.verified == true;
    final watermark = verified
        ? companySymbols[achievement.companyBrand?.symbol] ??
            Icons.business_rounded
        : Icons.handshake_rounded;

    return Container(
      color: colorScheme.surfaceContainer,
      child: Stack(
        children: [
          Positioned(
            left: -40,
            bottom: -50,
            child: Transform.rotate(
              angle: -0.35,
              child: Icon(watermark,
                  size: 220,
                  color: colorScheme.onSurface.withValues(alpha: 0.04)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 16, 14, 12),
            child: verified
                ? _buildCompany(colorScheme, context.l10n)
                : _buildColleague(colorScheme, context.l10n),
          ),
        ],
      ),
    );
  }

  Widget _label(ColorScheme colorScheme, String text) => Text(text,
      style: TextStyle(
          fontSize: 9,
          letterSpacing: 1.4,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurfaceVariant));

  Widget _buildCompany(ColorScheme colorScheme, AppLocalization l10n) {
    return Column(
      children: [
        _label(colorScheme, l10n.cardIssuedBy),
        const SizedBox(height: 12),
        CompanyLogo(
            name: achievement.company ?? '',
            brand: achievement.companyBrand,
            size: 64),
        const SizedBox(height: 10),
        Text(achievement.company ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.verified_rounded, size: 13, color: AppColors.verified),
            SizedBox(width: 4),
            Text(l10n.cardVerifiedAchievement,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.verified)),
          ],
        ),
        const Spacer(),
        Container(height: 1, color: colorScheme.outlineVariant),
        const SizedBox(height: 8),
        Text(achievement.name ?? '',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface)),
        const SizedBox(height: 2),
        Text(l10n.cardIssuedOn(formatDate(achievement.date)),
            style:
                TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 4),
        Text("#${achievement.id ?? ''}",
            style: TextStyle(
                fontSize: 8.5,
                letterSpacing: 0.8,
                fontFeatures: const [FontFeature.tabularFigures()],
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7))),
      ],
    );
  }

  Widget _buildColleague(ColorScheme colorScheme, AppLocalization l10n) {
    final sender = achievement.awardedByName ?? '';
    final message = achievement.note ?? achievement.description ?? '';

    return Column(
      children: [
        _label(colorScheme, l10n.cardSentBy),
        const SizedBox(height: 12),
        UserAvatar(initials: _initials(sender), radius: 28),
        const SizedBox(height: 8),
        Text(sender,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: colorScheme.onSurface)),
        const SizedBox(height: 12),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AchievementTier.peer.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("“$message”",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 11,
                    height: 1.35,
                    fontStyle: FontStyle.italic,
                    color: colorScheme.onSurface)),
          ),
        ),
        const SizedBox(height: 8),
        Text(l10n.cardReceivedOn(formatDate(achievement.date)),
            style:
                TextStyle(fontSize: 10, color: colorScheme.onSurfaceVariant)),
      ],
    );
  }

  static String _initials(String name) => name
      .split(' ')
      .where((part) => part.isNotEmpty)
      .take(2)
      .map((part) => part[0].toUpperCase())
      .join();
}

class _FlipButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FlipButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.cardFlip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.45),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: const Icon(Icons.flip_rounded, size: 15, color: Colors.white),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final Color background;

  const _Pill({required this.text, required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 9.5,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w700,
              color: Colors.white)),
    );
  }
}
