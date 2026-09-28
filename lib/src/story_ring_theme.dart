import 'package:flutter/material.dart';

/// Predefined popular gradient palettes and color constants for [StoryAvatarRing].
class StoryRingGradients {
  /// Iconic Instagram sunset gradient (yellow, red, magenta, violet).
  static const SweepGradient instagram = SweepGradient(
    colors: [
      Color(0xFFFBAA47), // Yellow-orange
      Color(0xFFD91A46), // Crimson red
      Color(0xFFA60F93), // Deep magenta
      Color(0xFF6B1D9A), // Purple
      Color(0xFFFBAA47), // Loop back
    ],
  );

  /// WhatsApp status emerald/teal gradient.
  static const SweepGradient whatsApp = SweepGradient(
    colors: [
      Color(0xFF25D366),
      Color(0xFF128C7E),
      Color(0xFF075E54),
      Color(0xFF25D366),
    ],
  );

  /// Instagram Close Friends vibrant green gradient.
  static const SweepGradient closeFriends = SweepGradient(
    colors: [
      Color(0xFF10B981),
      Color(0xFF059669),
      Color(0xFF047857),
      Color(0xFF10B981),
    ],
  );

  /// Default muted grey color for already viewed story segments.
  static const Color defaultSeenColor = Color(0xFFCBD5E1);

  /// Default pulsating live stream color.
  static const Color defaultLiveColor = Color(0xFFE11D48);
}
