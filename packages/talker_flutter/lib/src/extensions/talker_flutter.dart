import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerFlutter on Talker {
  static Talker init({
    TalkerLogger? logger,
    TalkerSettings? settings,
    TalkerFilter? filter,
    TalkerLoggerSettings? loggerSettings,
    TalkerLoggerFilter? loggerFilter,
    LoggerFormatter? loggerFormater,
    List<TalkerObserver>? observers,
    Function(String message)? loggerOutput,
  }) =>
      Talker(
        logger: logger,
        settings: settings,
        filter: filter,
        loggerSettings: loggerSettings,
        loggerFilter: loggerFilter,
        loggerFormater: loggerFormater,
        observers: observers,
        loggerOutput: loggerOutput ?? _defaultFlutterOutput,
      );

  static dynamic _defaultFlutterOutput(String message) {
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
      return;
    }
    if ([TargetPlatform.iOS, TargetPlatform.macOS]
        .contains(defaultTargetPlatform)) {
      log(message, name: 'Talker');
      return;
    }
    debugPrint(message);
  }
}
