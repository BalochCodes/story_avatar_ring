# story_avatar_ring

[![pub package](https://img.shields.io/pub/v/story_avatar_ring.svg?logo=dart&logoColor=white&style=flat-square)](https://pub.dev/packages/story_avatar_ring)
[![Pub Points](https://img.shields.io/badge/pub%20points-160%2F160-blue?style=flat-square)](https://pub.dev/packages/story_avatar_ring/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![Likes](https://img.shields.io/pub/likes/story_avatar_ring?logo=dart&logoColor=white&style=flat-square)](https://pub.dev/packages/story_avatar_ring)

A pixel-perfect, multi-segment animated status and story ring widget for Flutter, inspired by Instagram, WhatsApp, and live streaming platforms.

---

## 🌟 Overview & Hook

Implementing Instagram or WhatsApp style status rings from scratch requires tedious `CustomPainter` arc trigonometry, shader transformations, gap calculations, and nested gesture sync.

**story_avatar_ring** replaces manual custom paint hacks with a polished, plug-and-play widget:
- Slices automatically into $N$ equal arcs based on `storyCount`.
- Differentiates seen vs. unseen stories with vibrant gradients or muted colors.
- Features an active "LIVE" breathing radar pulse animation.
- Includes built-in tap bounce physics and corner badge pinning (e.g. `+` story add icon or `LIVE` pill tag).

---

## ✨ Features

- 🍩 **Dynamic Arc Segmentation:** Automatically divides the ring into $N$ equal arcs separated by configurable gap angles.
- 🎨 **Per-Segment State Tracking:** Seamlessly paints unseen stories with vibrant gradients and viewed stories with muted tones.
- 🌈 **Curated Gradient Palettes:** Comes pre-loaded with Instagram Sunset, WhatsApp Teal, and Close Friends Green gradients.
- 📡 **Live Stream Pulse Mode:** Continuous breathing radar wave animation around the ring for active broadcasts.
- 🎯 **Pinned Corner Badges:** Easily attach `+` add story icons or "LIVE" tags aligned anywhere on the avatar circumference.
- 💫 **Interactive Touch Feedback:** Smooth scale-down bounce animation on touch down and release.
- 🖼️ **Flexible Avatar Center:** Wrap network images, asset photos, initials fallbacks, or any custom Flutter widget.

---

## 🚀 Installation

Add the dependency to your `pubspec.yaml`:

```bash
flutter pub add story_avatar_ring
```

Or manually:

```yaml
dependencies:
  story_avatar_ring: ^0.0.1
```

Then import:

```dart
import 'package:story_avatar_ring/story_avatar_ring.dart';
```

---

## ⚡ Quick Start

Render a multi-segment story avatar in under 15 lines of code:

```dart
StoryAvatarRing(
  storyCount: 5,
  seenCount: 2,
  avatar: CircleAvatar(
    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
  ),
  onTap: () {
    print('Open story player!');
  },
)
```

---

## 📖 Advanced Usage & Examples

### 1. Instagram Close Friends Green Ring

```dart
StoryAvatarRing(
  storyCount: 3,
  seenCount: 1,
  unseenGradient: StoryRingGradients.closeFriends,
  avatar: CircleAvatar(
    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
  ),
  onTap: () => print('Viewing close friends story'),
)
```

### 2. Live Broadcast with Pulsing Radar and Badge

```dart
StoryAvatarRing(
  storyCount: 1,
  isLive: true,
  avatar: CircleAvatar(
    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
  ),
  badge: Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.redAccent,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.white, width: 1.5),
    ),
    child: const Text(
      'LIVE',
      style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
    ),
  ),
  badgeAlignment: Alignment.bottomCenter,
  badgeOffset: const Offset(0, 4),
  onTap: () => print('Joined live stream'),
)
```

### 3. WhatsApp Status Style with Custom Gap

```dart
StoryAvatarRing(
  storyCount: 8,
  seenCount: 6,
  ringWidth: 3.5,
  gapDegrees: 6.0,
  unseenGradient: StoryRingGradients.whatsApp,
  avatar: CircleAvatar(
    backgroundColor: Colors.teal.shade800,
    child: const Text('WA', style: TextStyle(color: Colors.white)),
  ),
  onTap: () => print('Open WhatsApp status'),
)
```

---

## 🛠️ Properties Table

| Property | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `avatar` | `Widget` | *Required* | Central child widget (image, initials, or custom icon). |
| `storyCount` | `int` | `1` | Total story segments. `0` draws no ring, `1` draws a solid continuous ring. |
| `seenCount` | `int` | `0` | Number of segments marked as already seen (index 0 to `seenCount - 1`). |
| `avatarRadius` | `double` | `32.0` | Radius of the inner circular avatar. |
| `ringWidth` | `double` | `3.0` | Stroke thickness of the story ring. |
| `ringPadding` | `double` | `3.5` | Spacing between the avatar edge and the inner edge of the ring. |
| `gapDegrees` | `double` | `5.0` | Angular gap spacing between segments in degrees. |
| `unseenGradient` | `Gradient` | `StoryRingGradients.instagram` | Gradient applied to unread story segments. |
| `seenColor` | `Color` | `Color(0xFFCBD5E1)` | Color applied to read story segments. |
| `customSegmentColors` | `List<Color>?` | `null` | Optional list of explicit colors for each individual segment. |
| `strokeCap` | `StrokeCap` | `StrokeCap.round` | Arc endpoint stroke styling (`round` or `butt`). |
| `isLive` | `bool` | `false` | Enables continuous radar pulse wave animation. |
| `liveColor` | `Color` | `Color(0xFFE11D48)` | Color of the pulsating radar ripple. |
| `badge` | `Widget?` | `null` | Pinned corner widget (e.g. `+` icon or `LIVE` pill). |
| `badgeAlignment` | `AlignmentGeometry` | `Alignment.bottomRight` | Position alignment of the badge relative to the avatar. |
| `badgeOffset` | `Offset` | `Offset.zero` | Pixel translation offset for fine-tuning badge position. |
| `enableBounceAnimation` | `bool` | `true` | Whether to bounce/scale-down on tap. |
| `onTap` | `VoidCallback?` | `null` | Tap callback. |
| `onLongPress` | `VoidCallback?` | `null` | Long press callback. |

---

## 🎬 Preview & Demo

```
+-------------------------------------------------------------+
|                      [ story_avatar_ring ]                  |
|                                                             |
|   1 Unseen Story          4 Stories (2 Seen)      LIVE Mode |
|      (Sunset)             (Segments + Gaps)     (Radar Pulse)|
|       .---.                    . - - .              . - - .  |
|      /     \                  '   |   '           ( (  O  ) )|
|     |   SB  |                (    SB   )             \___/   |
|      \     /                  .   |   .             [LIVE]   |
|       '---'                    ' - - '                       |
+-------------------------------------------------------------+
```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to open an issue or pull request on [GitHub](https://github.com/BalochCodes/story_avatar_ring).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

Developed with ❤️ by **Shahzain Baloch** ([BalochCodes](https://github.com/BalochCodes)).
