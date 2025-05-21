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
        logger: logger ?? TalkerLogger(output: _defaultFlutterOutput),
        observer: observer,
        settings: settings,
        filter: filter,
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
