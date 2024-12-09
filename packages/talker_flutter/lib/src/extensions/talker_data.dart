import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerDataFlutterExt on TalkerData {
  /// If [Talker Data][key] field is not provided trying to use color by [LogLevel]
  Color getFlutterColor(TalkerScreenTheme theme) {
    Color? color;
    if (key != null) {
      color = theme.logColors[key];
    }
    color ??= _getColorByLogLevel(theme);
    return color ?? Colors.grey;
  }

  Color? _getColorByLogLevel(TalkerScreenTheme theme) {
    final logLevel = this.logLevel;
    if (logLevel != null) {
      final type = TalkerLogType.fromLogLevel(logLevel);
      return theme.logColors[type.key] ?? Colors.grey;
    }
    return null;
  }
}
