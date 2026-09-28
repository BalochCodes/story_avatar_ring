import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A custom painter that renders segmented story arcs with dynamic gap angles,
/// gradient shaders, and seen/unseen state styles.
class StoryRingPainter extends CustomPainter {
  /// Total number of story segments to render.
  final int storyCount;

  /// Number of segments that have already been viewed.
  final int seenCount;

  /// Width / thickness of the ring stroke.
  final double ringWidth;

  /// Angular gap between individual segments in degrees.
  final double gapDegrees;

  /// Gradient applied to unseen story segments.
  final Gradient unseenGradient;

  /// Solid color applied to seen story segments.
  final Color seenColor;

  /// Optional per-segment custom color overrides.
  final List<Color>? customSegmentColors;

  /// Shape of arc endpoints (e.g. [StrokeCap.round] or [StrokeCap.butt]).
  final StrokeCap strokeCap;

  /// Creates a [StoryRingPainter].
  const StoryRingPainter({
    required this.storyCount,
    required this.seenCount,
    required this.ringWidth,
    required this.gapDegrees,
    required this.unseenGradient,
    required this.seenColor,
    this.customSegmentColors,
    this.strokeCap = StrokeCap.round,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (storyCount <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - ringWidth) / 2;
    if (radius <= 0) return;

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Single story case: continuous smooth ring with no gaps
    if (storyCount == 1) {
      final isSeen = seenCount >= 1;
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringWidth
        ..strokeCap = strokeCap;

      if (customSegmentColors != null && customSegmentColors!.isNotEmpty) {
        paint.color = customSegmentColors![0];
      } else if (isSeen) {
        paint.color = seenColor;
      } else {
        paint.shader = unseenGradient.createShader(rect);
      }

      canvas.drawCircle(center, radius, paint);
      return;
    }

    // Multi-segment story calculation
    final gapRadians = (gapDegrees * math.pi) / 180.0;
    final totalGap = storyCount * gapRadians;

    // Guard against gaps exceeding 360 degrees
    final maxAllowedGap = 2 * math.pi * 0.7; // Reserve at least 30% for arcs
    final effectiveGap = totalGap > maxAllowedGap
        ? maxAllowedGap / storyCount
        : gapRadians;

    final sweepAngle = (2 * math.pi - (storyCount * effectiveGap)) / storyCount;

    for (int i = 0; i < storyCount; i++) {
      // Calculate start angle starting from 12 o'clock (-pi / 2)
      final startAngle = -math.pi / 2 + (i * (sweepAngle + effectiveGap)) + (effectiveGap / 2);
      final isSeen = i < seenCount;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringWidth
        ..strokeCap = strokeCap;

      if (customSegmentColors != null && i < customSegmentColors!.length) {
        paint.color = customSegmentColors![i];
      } else if (isSeen) {
        paint.color = seenColor;
      } else {
        paint.shader = unseenGradient.createShader(rect);
      }

      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StoryRingPainter oldDelegate) {
    return oldDelegate.storyCount != storyCount ||
        oldDelegate.seenCount != seenCount ||
        oldDelegate.ringWidth != ringWidth ||
        oldDelegate.gapDegrees != gapDegrees ||
        oldDelegate.unseenGradient != unseenGradient ||
        oldDelegate.seenColor != seenColor ||
        oldDelegate.customSegmentColors != customSegmentColors ||
        oldDelegate.strokeCap != strokeCap;
  }
}
