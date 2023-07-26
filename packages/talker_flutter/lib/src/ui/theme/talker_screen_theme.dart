import 'package:flutter/material.dart';

/// Configuring the UI of [TalkerScreen]
class TalkerScreenTheme {
  const TalkerScreenTheme({
    this.backgroundColor = const Color(0xFF212121),
    this.textColor = Colors.white,
  });

  /// Background screen color
  final Color backgroundColor;

  /// Color of text on screen
  final Color textColor;
}
