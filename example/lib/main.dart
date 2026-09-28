import 'package:flutter/material.dart';
import 'package:story_avatar_ring/story_avatar_ring.dart';

void main() {
  runApp(const StoryAvatarDemoApp());
}

class StoryAvatarDemoApp extends StatelessWidget {
  const StoryAvatarDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Story Avatar Ring Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD91A46),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const StoryDemoHome(),
    );
  }
}

class StoryDemoHome extends StatefulWidget {
  const StoryDemoHome({super.key});

  @override
  State<StoryDemoHome> createState() => _StoryDemoHomeState();
}

class _StoryDemoHomeState extends State<StoryDemoHome> {
  int _interactiveStoryCount = 5;
  int _interactiveSeenCount = 2;
  bool _isInteractiveLive = false;
  String _lastAction = 'Tap any avatar to interact';

  Widget _buildAvatarPlaceholder(String initials, List<Color> bgGradient) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: bgGradient,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Instagram / WhatsApp Stories',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal Story Tray
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Your Story / Add Badge
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 0,
                        avatar: _buildAvatarPlaceholder('You', [Colors.blueGrey, Colors.black87]),
                        badge: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0095F6),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 14),
                        ),
                        onTap: () => setState(() => _lastAction = 'Add story tapped!'),
                      ),
                      label: 'Your story',
                    ),
                    const SizedBox(width: 14),

                    // Live Stream with Radar Pulse and Badge
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 1,
                        isLive: true,
                        avatar: _buildAvatarPlaceholder('LIVE', [Colors.deepOrange, Colors.redAccent]),
                        badge: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFE11D48), Color(0xFFBE123C)],
                            ),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        badgeAlignment: Alignment.bottomCenter,
                        badgeOffset: const Offset(0, 4),
                        onTap: () => setState(() => _lastAction = 'Entered live stream!'),
                      ),
                      label: 'creator.live',
                    ),
                    const SizedBox(width: 14),

                    // Multi-Segment (3 stories, 0 seen)
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 3,
                        seenCount: 0,
                        avatar: _buildAvatarPlaceholder('SB', [Colors.purple, Colors.pink]),
                        onTap: () => setState(() => _lastAction = 'Viewing Shahzain Baloch (3 stories)'),
                      ),
                      label: 'shahzain',
                    ),
                    const SizedBox(width: 14),

                    // Close Friends Green Ring
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 4,
                        seenCount: 1,
                        unseenGradient: StoryRingGradients.closeFriends,
                        avatar: _buildAvatarPlaceholder('CF', [Colors.teal, Colors.green]),
                        onTap: () => setState(() => _lastAction = 'Viewing Close Friends story!'),
                      ),
                      label: 'besties',
                    ),
                    const SizedBox(width: 14),

                    // WhatsApp Status Style (6 segments)
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 6,
                        seenCount: 4,
                        unseenGradient: StoryRingGradients.whatsApp,
                        avatar: _buildAvatarPlaceholder('WA', [Colors.teal.shade700, Colors.green.shade800]),
                        onTap: () => setState(() => _lastAction = 'Viewing WhatsApp status update'),
                      ),
                      label: 'colleague',
                    ),
                    const SizedBox(width: 14),

                    // All Seen Stories (Muted Grey)
                    _buildTrayItem(
                      avatar: StoryAvatarRing(
                        storyCount: 5,
                        seenCount: 5,
                        avatar: _buildAvatarPlaceholder('AL', [Colors.blueGrey, Colors.grey]),
                        onTap: () => setState(() => _lastAction = 'Replaying completed stories'),
                      ),
                      label: 'alex_dev',
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1),

            // Interactive Playground
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Interactive Ring Playground',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _lastAction,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Center Preview
                  Center(
                    child: StoryAvatarRing(
                      avatarRadius: 48,
                      ringWidth: 4.0,
                      ringPadding: 4.5,
                      gapDegrees: 6.0,
                      storyCount: _interactiveStoryCount,
                      seenCount: _interactiveSeenCount,
                      isLive: _isInteractiveLive,
                      avatar: _buildAvatarPlaceholder('PRO', [Colors.indigo, Colors.purpleAccent]),
                      onTap: () {
                        setState(() {
                          if (_interactiveSeenCount < _interactiveStoryCount) {
                            _interactiveSeenCount++;
                            _lastAction = 'Marked story $_interactiveSeenCount as seen!';
                          } else {
                            _interactiveSeenCount = 0;
                            _lastAction = 'Reset stories to unseen!';
                          }
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Stories: $_interactiveStoryCount'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: _interactiveStoryCount > 1
                                ? () => setState(() {
                                      _interactiveStoryCount--;
                                      if (_interactiveSeenCount > _interactiveStoryCount) {
                                        _interactiveSeenCount = _interactiveStoryCount;
                                      }
                                    })
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: _interactiveStoryCount < 12
                                ? () => setState(() => _interactiveStoryCount++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Seen Stories: $_interactiveSeenCount'),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _interactiveSeenCount > 0
                                ? () => setState(() => _interactiveSeenCount--)
                                : null,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _interactiveSeenCount < _interactiveStoryCount
                                ? () => setState(() => _interactiveSeenCount++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SwitchListTile(
                    title: const Text('Live Broadcast Pulse Mode'),
                    value: _isInteractiveLive,
                    onChanged: (val) => setState(() => _isInteractiveLive = val),
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrayItem({required Widget avatar, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(height: 6),
        SizedBox(
          width: 72,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Color(0xFF262626)),
          ),
        ),
      ],
    );
  }
}
