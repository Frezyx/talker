import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';

/// Configuring the UI of [TalkerScreen]
class TalkerScreenTheme {
  const TalkerScreenTheme({
    this.backgroundColor = const Color(0xFF212121),
    this.textColor = Colors.white,
    this.cardColor = defaultCardBackgroundColor,
  });

  /// Background screen color
  final Color backgroundColor;

  /// Color of text on screen
  final Color textColor;

  /// Color of [Talker] data cards
  final Color cardColor;
}
