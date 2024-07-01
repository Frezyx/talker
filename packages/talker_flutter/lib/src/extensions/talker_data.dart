import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerDataFlutterExt on TalkerData {
  Color getFlutterColor(LogColors colors) {
    // final colorFromAnsi = _getColorFromAnsi();
    // if (colorFromAnsi != null) return logsColors.colorFromAnsi;

    final key = this.key;

    if (key == null) return Colors.grey;
    final type = TalkerLogType.fromKey(key);
    return colors[type] ?? Colors.grey;
  }
}
