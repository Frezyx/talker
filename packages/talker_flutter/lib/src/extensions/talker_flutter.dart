import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

extension TalkerFlutter on Talker {
  static Talker init({
    TalkerLogger? logger,
    TalkerSettings? settings,
    TalkerFilter? filter,
  }) =>
      Talker(
        logger: logger?.copyWith(output: _defaultFlutterOutput),
        settings: settings,
        filter: filter,
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
