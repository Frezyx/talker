import 'dart:developer' show log;

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerFlutter on Talker {
  static Talker init({
    TalkerLogger? logger,
    TalkerObserver? observer,
    TalkerSettings? settings,
    TalkerFilter? filter,
  }) =>
      Talker(
        logger: logger ?? _defaultFlutterLogger(),
        observer: observer,
        settings: settings,
        filter: filter,
      );

  /// Default logger for Flutter:
  /// - On web, disables ANSI colors to avoid UTF-8 encoding issues.
  /// - On other platforms, enables colors by default.
  static TalkerLogger _defaultFlutterLogger() => TalkerLogger(
        output: _defaultFlutterOutput,
        settings: TalkerLoggerSettings(
          // Disable colors on web to prevent UTF-8 encoding issues
          // with ANSI escape codes in the browser console
          enableColors: !kIsWeb,
        ),
      );

  /// Default output function for Flutter:
  /// - On web, prints to console.
  /// - On iOS/macOS, uses `dart:developer.log`.
  /// - On other platforms, uses `debugPrint`.
  static void _defaultFlutterOutput(String message) {
    if (kIsWeb) {
      // ignore: avoid_print
      print(message);
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        log(message, name: 'Talker');
        break;
      default:
        debugPrint(message);
    }
  }
}
