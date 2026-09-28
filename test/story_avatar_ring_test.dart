import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:story_avatar_ring/story_avatar_ring.dart';

void main() {
  group('StoryAvatarRing Widget Tests', () {
    testWidgets('renders avatar child and CustomPaint ring', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StoryAvatarRing(
                storyCount: 4,
                seenCount: 1,
                avatar: Text('JD'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('triggers onTap callback when tapped', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: StoryAvatarRing(
                storyCount: 2,
                avatar: const Icon(Icons.person),
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(StoryAvatarRing));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('triggers onLongPress callback when long pressed', (tester) async {
      bool longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: StoryAvatarRing(
                storyCount: 3,
                avatar: const Icon(Icons.person),
                onLongPress: () => longPressed = true,
              ),
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(StoryAvatarRing));
      await tester.pumpAndSettle();

      expect(longPressed, isTrue);
    });

    testWidgets('renders badge widget when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StoryAvatarRing(
                storyCount: 0,
                avatar: Icon(Icons.person),
                badge: Icon(Icons.add, key: ValueKey('add_badge')),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const ValueKey('add_badge')), findsOneWidget);
    });

    testWidgets('enables LivePulseRing when isLive is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: StoryAvatarRing(
                storyCount: 1,
                isLive: true,
                avatar: Icon(Icons.person),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(LivePulseRing), findsOneWidget);
      // Verify animation frames pump without errors
      await tester.pump(const Duration(milliseconds: 300));
    });
  });
}
