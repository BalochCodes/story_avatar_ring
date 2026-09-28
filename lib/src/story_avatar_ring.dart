import 'package:flutter/material.dart';
import 'live_pulse_ring.dart';
import 'story_ring_painter.dart';
import 'story_ring_theme.dart';

/// A multi-segment animated status/story ring wrapping user avatars,
/// inspired by Instagram, WhatsApp, and live streaming platforms.
class StoryAvatarRing extends StatefulWidget {
  /// The central avatar widget (e.g., [CircleAvatar], [Image], or custom widget).
  final Widget avatar;

  /// Total number of story segments to divide the ring into.
  /// If 0, no ring is drawn. If 1, a continuous ring is drawn without gaps.
  final int storyCount;

  /// The count of already viewed/seen stories (from index 0 to seenCount - 1).
  /// Defaults to 0 (all stories unseen).
  final int seenCount;

  /// Radius of the inner circular avatar. Defaults to 32.0 (diameter: 64.0).
  final double avatarRadius;

  /// Stroke width / thickness of the story ring. Defaults to 3.0.
  final double ringWidth;

  /// Spacing between the avatar edge and the inner edge of the story ring.
  /// Defaults to 3.5.
  final double ringPadding;

  /// Angular gap between individual segments in degrees. Defaults to 5.0.
  final double gapDegrees;

  /// Gradient applied to unseen story segments. Defaults to [StoryRingGradients.instagram].
  final Gradient unseenGradient;

  /// Solid color applied to seen story segments. Defaults to [StoryRingGradients.defaultSeenColor].
  final Color seenColor;

  /// Optional per-segment custom color overrides.
  final List<Color>? customSegmentColors;

  /// Stroke cap styling for arc segment ends. Defaults to [StrokeCap.round].
  final StrokeCap strokeCap;

  /// Whether the user is actively broadcasting a live stream.
  /// When true, enables a continuous breathing radar pulse animation.
  final bool isLive;

  /// Primary color for the live pulse wave. Defaults to [StoryRingGradients.defaultLiveColor].
  final Color liveColor;

  /// Optional badge pinned to a corner of the avatar (e.g., "+" add icon or "LIVE" pill).
  final Widget? badge;

  /// Alignment of the [badge] widget relative to the avatar container.
  /// Defaults to [Alignment.bottomRight].
  final AlignmentGeometry badgeAlignment;

  /// Fine-tuning pixel offset applied to the [badge].
  final Offset badgeOffset;

  /// Callback triggered when the avatar ring is tapped.
  final VoidCallback? onTap;

  /// Callback triggered when the avatar ring is long pressed.
  final VoidCallback? onLongPress;

  /// Whether to enable subtle scale-down bounce feedback on touch.
  /// Defaults to true.
  final bool enableBounceAnimation;

  /// Creates a [StoryAvatarRing].
  const StoryAvatarRing({
    super.key,
    required this.avatar,
    this.storyCount = 1,
    this.seenCount = 0,
    this.avatarRadius = 32.0,
    this.ringWidth = 3.0,
    this.ringPadding = 3.5,
    this.gapDegrees = 5.0,
    this.unseenGradient = StoryRingGradients.instagram,
    this.seenColor = StoryRingGradients.defaultSeenColor,
    this.customSegmentColors,
    this.strokeCap = StrokeCap.round,
    this.isLive = false,
    this.liveColor = StoryRingGradients.defaultLiveColor,
    this.badge,
    this.badgeAlignment = Alignment.bottomRight,
    this.badgeOffset = Offset.zero,
    this.onTap,
    this.onLongPress,
    this.enableBounceAnimation = true,
  }) : assert(storyCount >= 0, 'storyCount cannot be negative'),
       assert(seenCount >= 0, 'seenCount cannot be negative');

  @override
  State<StoryAvatarRing> createState() => _StoryAvatarRingState();
}

class _StoryAvatarRingState extends State<StoryAvatarRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 140),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableBounceAnimation && (widget.onTap != null || widget.onLongPress != null)) {
      _bounceController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableBounceAnimation) {
      _bounceController.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enableBounceAnimation) {
      _bounceController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Total diameter calculation
    final hasRing = widget.storyCount > 0 || widget.isLive;
    final totalRingThickness = hasRing ? (widget.ringPadding + widget.ringWidth) * 2 : 0.0;
    final totalDiameter = (widget.avatarRadius * 2) + totalRingThickness;

    Widget content = ScaleTransition(
      scale: _scaleAnimation,
      child: SizedBox(
        width: totalDiameter,
        height: totalDiameter,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Segmented story ring
            if (hasRing)
              CustomPaint(
                size: Size(totalDiameter, totalDiameter),
                painter: StoryRingPainter(
                  storyCount: widget.storyCount,
                  seenCount: widget.seenCount,
                  ringWidth: widget.ringWidth,
                  gapDegrees: widget.gapDegrees,
                  unseenGradient: widget.isLive
                      ? SweepGradient(colors: [widget.liveColor, widget.liveColor])
                      : widget.unseenGradient,
                  seenColor: widget.seenColor,
                  customSegmentColors: widget.customSegmentColors,
                  strokeCap: widget.strokeCap,
                ),
              ),

            // Center avatar child
            SizedBox(
              width: widget.avatarRadius * 2,
              height: widget.avatarRadius * 2,
              child: ClipOval(child: widget.avatar),
            ),

            // Optional pinned corner badge
            if (widget.badge != null)
              Align(
                alignment: widget.badgeAlignment,
                child: Transform.translate(
                  offset: widget.badgeOffset,
                  child: widget.badge!,
                ),
              ),
          ],
        ),
      ),
    );

    // Wrap in live pulsating ripple if live
    content = LivePulseRing(
      isLive: widget.isLive,
      size: totalDiameter,
      pulseColor: widget.liveColor,
      child: content,
    );

    // Gesture detector wrapper
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
