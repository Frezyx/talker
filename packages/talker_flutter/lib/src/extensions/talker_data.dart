import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerDataFlutterExt on TalkerData {
  Color getFlutterColor(TalkerScreenTheme theme) {
    final key = this.key;

    if (key == null) return Colors.grey;
    final type = TalkerLogType.fromKey(key);
    return theme.logColors[type] ?? Colors.grey;
  }
}
