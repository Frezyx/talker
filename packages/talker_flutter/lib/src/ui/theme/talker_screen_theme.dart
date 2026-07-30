import 'package:flutter/material.dart';
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
  Color getByKey(String key) {
    return this[key] ?? Colors.grey;
  }
}

final _defaultColors = {
  /// Base logs section
  TalkerKey.error: const Color.fromARGB(255, 239, 83, 80),
  TalkerKey.critical: const Color.fromARGB(255, 198, 40, 40),
  TalkerKey.info: const Color.fromARGB(255, 66, 165, 245),
  TalkerKey.debug: const Color.fromARGB(255, 158, 158, 158),
  TalkerKey.verbose: const Color.fromARGB(255, 189, 189, 189),
  TalkerKey.warning: const Color.fromARGB(255, 239, 108, 0),
  TalkerKey.exception: const Color.fromARGB(255, 239, 83, 80),

  /// Http section
  TalkerKey.httpError: const Color.fromARGB(255, 239, 83, 80),
  TalkerKey.httpRequest: const Color(0xFFF602C1),
  TalkerKey.httpResponse: const Color(0xFF26FF3C),

  /// Bloc section
  TalkerKey.blocEvent: const Color(0xFF63FAFE),
  TalkerKey.blocTransition: const Color(0xFF56FEA8),
  TalkerKey.blocClose: const Color(0xFFFF005F),
  TalkerKey.blocCreate: const Color.fromARGB(255, 120, 230, 129),

  /// Drift section
  TalkerKey.driftError: const Color.fromARGB(255, 239, 83, 80),
  TalkerKey.driftQuery: const Color(0xFFF602C1),
  TalkerKey.driftResult: const Color(0xFF26FF3C),
  TalkerKey.driftTransaction: const Color(0xFFAF5FFF),
  TalkerKey.driftBatch: const Color(0xFF56FEA8),

  /// Flutter section
  TalkerKey.route: const Color(0xFFAF5FFF),
};

const defaultCardBackgroundColor = Color.fromARGB(255, 49, 49, 49);
