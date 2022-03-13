import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension ToColor on LogLevel? {
  Color get color {
    switch (this) {
      case LogLevel.critical:
      case LogLevel.error:
        return Colors.red;
      case LogLevel.fine:
        return Colors.teal;
      case LogLevel.warning:
        return Colors.orange;
      case LogLevel.verbose:
        return Colors.grey;
      case LogLevel.info:
        return Colors.blue;
      case LogLevel.good:
        return Colors.green;
      case LogLevel.debug:
      default:
        return Colors.grey;
    }
  }
}
