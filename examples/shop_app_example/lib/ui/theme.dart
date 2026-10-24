import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/utils/good_log.dart';

final lightTheme = ThemeData(
  primaryColor: Colors.purple,
  primarySwatch: Colors.purple,
  scaffoldBackgroundColor: const Color(0xffF9F9F9),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
);

const cardShadow = [
  BoxShadow(
    color: Color(0x11272749),
    blurRadius: 16,
    offset: Offset(0, 3),
    spreadRadius: 0,
  )
];

final talkerTheme = TalkerScreenTheme(logColors: {
  GoodLog.getKey: const Color(0xff4CAF50),
});
