import 'package:flutter/material.dart';

/// A pulsating ripple animation widget overlaid around [StoryAvatarRing]
/// to denote an active live broadcast stream.
class LivePulseRing extends StatefulWidget {
  /// Whether the live pulse animation is active.
  final bool isLive;

  /// Diameter of the base avatar container.
  final double size;

  /// Primary color of the pulsating radar ripple.
  final Color pulseColor;

  /// Child widget enclosed within the pulse animation.
  final Widget child;

  /// Creates a [LivePulseRing].
  const LivePulseRing({
    super.key,
    required this.isLive,
    required this.size,
    required this.pulseColor,
    required this.child,
  });

  @override
  State<LivePulseRing> createState() => _LivePulseRingState();
}

class _LivePulseRingState extends State<LivePulseRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    if (widget.isLive) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant LivePulseRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLive && !oldWidget.isLive) {
      _controller.repeat();
    } else if (!widget.isLive && oldWidget.isLive) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLive) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = _controller.value;
        final rippleScale = 1.0 + (progress * 0.18);
        final opacity = (1.0 - progress).clamp(0.0, 0.7);

        return Stack(
          alignment: Alignment.center,
          children: [
            // Outward radar pulse wave
            Transform.scale(
              scale: rippleScale,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.pulseColor.withValues(alpha: opacity),
                    width: 2.5,
                  ),
                ),
              ),
            ),
            // Child avatar with ring
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}
