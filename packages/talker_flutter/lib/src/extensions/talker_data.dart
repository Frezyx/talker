import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerDataFlutterExt on TalkerData {
  Color getFlutterColor(TalkerScreenTheme theme) {
    // final colorFromAnsi = _getColorFromAnsi();
    // if (colorFromAnsi != null) return logsColors.colorFromAnsi;

    final key = this.key;

    if (key == null) return Colors.grey;
    final type = TalkerLogType.fromKey(key);
    return theme.logColors[type] ?? Colors.grey;
  }
}

  // Color? _getColorFromAnsi() {
  //   final logData = data;
  //   if (logData is TalkerLog) {
  //     final hexColor = logData.pen?.toHexColor();
  //     if (hexColor != null) {
  //       return ColorExt.fromHEX(hexColor);
  //     }
  //   }
  //   return null;
  // }