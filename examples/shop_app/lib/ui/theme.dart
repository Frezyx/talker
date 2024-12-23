import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/utils/good_log.dart';

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  primarySwatch: primaryColor,
  scaffoldBackgroundColor: const Color(0xffF9F9F9),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(color: Colors.white),
);

const cardShadow = [
  BoxShadow(
    color: Color(0x11272749),
    blurRadius: 16,
    offset: Offset(0, 3),
    spreadRadius: 0,
  )
];

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

final talkerTheme = TalkerScreenTheme(logColors: {
  GoodLog.getKey: const Color(0xff4CAF50),
});
