import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primaryColor,
  scaffoldBackgroundColor: Colors.white,
);

MaterialColor get primaryColor => MaterialColor(
      _primaryColor.value,
      _primaryColorCodes,
    );

Color get _primaryColor => Colors.black;
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
