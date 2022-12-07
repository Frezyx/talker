import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'dart:developer';

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
        loggerOutput: loggerOutput ??
            (Platform.isIOS || Platform.isMacOS ? log : debugPrint),
      );
}
