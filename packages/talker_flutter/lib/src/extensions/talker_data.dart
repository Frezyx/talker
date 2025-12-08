import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_flutter/src/utils/ansi_color_converter.dart';

extension TalkerDataFlutterExt on TalkerData {
  /// If [Talker Data][key] field is not provided trying to use color by [LogLevel]
  /// If neither key nor logLevel is available, tries to convert the pen color
  Color getFlutterColor(TalkerScreenTheme theme) {
    Color? color;
    if (key != null) {
      color = theme.logColors[key];
    }
    color ??= _getColorByLogLevel(theme);
    color ??= _getColorFromPen();
    return color ?? Colors.grey;
  }

  Color? _getColorByLogLevel(TalkerScreenTheme theme) {
    final logLevel = this.logLevel;
    if (logLevel != null) {
      final key = TalkerKey.fromLogLevel(logLevel);
      return theme.logColors[key] ?? Colors.grey;
    }
    return null;
  }

  /// Tries to convert the pen (AnsiPen) to a Flutter Color
  Color? _getColorFromPen() {
    return AnsiColorConverter.tryConvertAnsiPenToColor(pen);
  }
}
