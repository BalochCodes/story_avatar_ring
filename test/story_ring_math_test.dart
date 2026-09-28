import 'package:flutter_test/flutter_test.dart';
import 'package:story_avatar_ring/story_avatar_ring.dart';

void main() {
  group('StoryRingPainter Math & Geometry Tests', () {
    test('painter shouldRepaint returns true when storyCount changes', () {
      const painter1 = StoryRingPainter(
        storyCount: 3,
        seenCount: 1,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      const painter2 = StoryRingPainter(
        storyCount: 4,
        seenCount: 1,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });

    test('painter shouldRepaint returns false when properties are identical', () {
      const painter1 = StoryRingPainter(
        storyCount: 3,
        seenCount: 1,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      const painter2 = StoryRingPainter(
        storyCount: 3,
        seenCount: 1,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      expect(painter1.shouldRepaint(painter2), isFalse);
    });

    test('painter shouldRepaint returns true when seenCount changes', () {
      const painter1 = StoryRingPainter(
        storyCount: 5,
        seenCount: 2,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      const painter2 = StoryRingPainter(
        storyCount: 5,
        seenCount: 3,
        ringWidth: 3.0,
        gapDegrees: 5.0,
        unseenGradient: StoryRingGradients.instagram,
        seenColor: StoryRingGradients.defaultSeenColor,
      );

      expect(painter1.shouldRepaint(painter2), isTrue);
    });
  });
}
