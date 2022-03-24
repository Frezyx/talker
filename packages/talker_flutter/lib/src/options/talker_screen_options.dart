import 'package:flutter/material.dart';

/// Configuring the UI of [TalkerScreen]
class TalkerScreenOptions {
  const TalkerScreenOptions({
    this.appBarTitle = 'Flutter talker',
    this.backgroudColor = const Color(0xFF212121),
    this.textColor = Colors.white,
  });

  /// Background screen color
  final String appBarTitle;

  /// Background screen color
  final Color backgroudColor;

  /// Color of text on screen
  final Color textColor;
}
