import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef LogColors = Map<TalkerLogType, Color>;

/// Configuring the UI of [TalkerScreen]
class TalkerScreenTheme {
  const TalkerScreenTheme({
    this.backgroundColor = const Color(0xFF212121),
    this.textColor = Colors.white,
    this.cardColor = defaultCardBackgroundColor,
    LogColors? logColors,
  }) : _customColors = logColors;

  /// Background screen color
  final Color backgroundColor;

  /// Color of text on screen
  final Color textColor;

  /// Color of [Talker] data cards
  final Color cardColor;

  final Map<TalkerLogType, Color>? _customColors;

  Map<TalkerLogType, Color> get logColors {
    if (_customColors != null) {
      final customMap = Map<TalkerLogType, Color>.from(_defaultColors);
      customMap.addAll(_customColors!);
      return customMap;
    }
    return _defaultColors;
  }

  factory TalkerScreenTheme.fromTheme(ThemeData theme, [LogColors? logColors]) {
    return TalkerScreenTheme(
      backgroundColor: theme.colorScheme.background,
      textColor: theme.colorScheme.onBackground,
      cardColor: theme.colorScheme.surface,
      logColors: logColors,
    );
  }
}

extension MapTalkerFlutterColorsExt on LogColors {
  Color getByType(TalkerLogType type) {
    return this[type] ?? Colors.grey;
  }
}

// 💡 why not merge this into
const _defaultColors = {
  /// Base logs section
  TalkerLogType.error: Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.critical: Color.fromARGB(255, 198, 40, 40),
  TalkerLogType.info: Color.fromARGB(255, 66, 165, 245),
  TalkerLogType.debug: Color.fromARGB(255, 158, 158, 158),
  TalkerLogType.verbose: Color.fromARGB(255, 189, 189, 189),
  TalkerLogType.warning: Color.fromARGB(255, 239, 108, 0),
  TalkerLogType.exception: Color.fromARGB(255, 239, 83, 80),

  /// Http section
  TalkerLogType.httpError: Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.httpRequest: Color(0xFFF602C1),
  TalkerLogType.httpResponse: Color(0xFF26FF3C),

  /// Bloc section
  TalkerLogType.blocEvent: Color(0xFF63FAFE),
  TalkerLogType.blocTransition: Color(0xFF56FEA8),
  TalkerLogType.blocClose: Color(0xFFFF005F),
  TalkerLogType.blocCreate: Color.fromARGB(255, 120, 230, 129),

  /// Flutter section
  TalkerLogType.route: Color(0xFFAF5FFF),
};
