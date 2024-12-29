import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef LogColors = Map<String, Color>;

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

  final Map<String, Color>? _customColors;

  Map<String, Color> get logColors {
    if (_customColors != null) {
      final customMap = Map<String, Color>.from(_defaultColors);
      //ignore: unnecessary_non_null_assertion
      customMap.addAll(_customColors!);
      return customMap;
    }
    return _defaultColors;
  }

  factory TalkerScreenTheme.fromTheme(ThemeData theme, [LogColors? logColors]) {
    return TalkerScreenTheme(
      backgroundColor: theme.colorScheme.surface,
      textColor: theme.colorScheme.onSurface,
      cardColor: theme.colorScheme.surface,
      logColors: logColors,
    );
  }
}

extension MapTalkerFlutterColorsExt on LogColors {
  Color getByType(TalkerLogType type) {
    return this[type.key] ?? Colors.grey;
  }
}

final _defaultColors = {
  /// Base logs section
  TalkerLogType.error.key: const Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.critical.key: const Color.fromARGB(255, 198, 40, 40),
  TalkerLogType.info.key: const Color.fromARGB(255, 66, 165, 245),
  TalkerLogType.debug.key: const Color.fromARGB(255, 158, 158, 158),
  TalkerLogType.verbose.key: const Color.fromARGB(255, 189, 189, 189),
  TalkerLogType.warning.key: const Color.fromARGB(255, 239, 108, 0),
  TalkerLogType.exception.key: const Color.fromARGB(255, 239, 83, 80),

  /// Http section
  TalkerLogType.httpError.key: const Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.httpRequest.key: const Color(0xFFF602C1),
  TalkerLogType.httpResponse.key: const Color(0xFF26FF3C),

  /// Bloc section
  TalkerLogType.blocEvent.key: const Color(0xFF63FAFE),
  TalkerLogType.blocTransition.key: const Color(0xFF56FEA8),
  TalkerLogType.blocClose.key: const Color(0xFFFF005F),
  TalkerLogType.blocCreate.key: const Color.fromARGB(255, 120, 230, 129),

  /// Flutter section
  TalkerLogType.route.key: const Color(0xFFAF5FFF),
};
