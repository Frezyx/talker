import 'package:flutter/material.dart';

/// Configuring the UI of [TalkerScreen]
class TalkerScreenTheme {
  const TalkerScreenTheme({
    this.backgroudColor = const Color(0xFF212121),
    this.textColor = Colors.white,
  });

  /// Background screen color
  final Color backgroudColor;

  /// Color of text on screen
  final Color textColor;
}
