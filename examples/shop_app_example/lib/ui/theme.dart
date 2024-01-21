import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primaryColor,
  scaffoldBackgroundColor: Colors.white,
);

MaterialColor get primaryColor => MaterialColor(
      _primaryColor.value,
      _primaryColorCodes,
    );

Color get _primaryColor => Colors.deepPurple;
final Map<int, Color> _primaryColorCodes = {
  50: _primaryColor.withOpacity(.1),
  100: _primaryColor.withOpacity(.2),
  200: _primaryColor.withOpacity(.3),
  300: _primaryColor.withOpacity(.4),
  400: _primaryColor.withOpacity(.5),
  500: _primaryColor.withOpacity(.6),
  600: _primaryColor.withOpacity(.7),
  700: _primaryColor.withOpacity(.8),
  800: _primaryColor.withOpacity(.9),
  900: _primaryColor,
};

const talkerTheme = TalkerScreenTheme(logColors: {
  TalkerLogType.error: Color.fromARGB(255, 250, 126, 123),
  TalkerLogType.critical: Color.fromARGB(255, 255, 95, 95),
  TalkerLogType.info: Color.fromARGB(255, 137, 197, 246),
  TalkerLogType.debug: Color.fromARGB(255, 180, 180, 180),
  TalkerLogType.verbose: Color.fromARGB(255, 189, 189, 189),
  TalkerLogType.warning: Color.fromARGB(255, 255, 158, 78),
  TalkerLogType.exception: Color.fromARGB(255, 234, 123, 121),

  /// Http section
  TalkerLogType.httpError: Color.fromARGB(255, 247, 119, 117),
  TalkerLogType.httpRequest: Color.fromARGB(255, 255, 116, 225),
  TalkerLogType.httpResponse: Color.fromARGB(255, 146, 255, 157),

  /// Bloc section
  TalkerLogType.blocEvent: Color.fromARGB(255, 175, 252, 255),
  TalkerLogType.blocTransition: Color.fromARGB(255, 146, 251, 197),
  TalkerLogType.blocClose: Color.fromARGB(255, 252, 124, 171),
  TalkerLogType.blocCreate: Color.fromARGB(255, 150, 247, 158),

  /// Flutter section
  TalkerLogType.route: Color.fromARGB(255, 208, 161, 255),
});
