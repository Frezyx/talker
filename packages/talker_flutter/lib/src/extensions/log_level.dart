import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Extension to map [LogLevel] into Flutter [Color]
extension LogLevelExtensions on LogLevel? {
  Color get color {
    switch (this) {
      case LogLevel.critical:
        return Colors.red[800]!;
      case LogLevel.error:
        return Colors.red[400]!;
      case LogLevel.fine:
        return Colors.teal[400]!;
      case LogLevel.warning:
        return Colors.orange[800]!;
      case LogLevel.verbose:
        return Colors.grey[400]!;
      case LogLevel.info:
        return Colors.blue[400]!;
      case LogLevel.good:
        return Colors.green[400]!;
      case LogLevel.debug:
      default:
        return Colors.grey;
    }
  }
}
