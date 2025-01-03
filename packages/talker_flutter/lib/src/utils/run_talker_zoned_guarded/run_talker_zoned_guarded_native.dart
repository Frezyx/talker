import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      reportError(details.exception, details.stack, talker,
          errorDetails: details);
    };
  }
  PlatformDispatcher.instance.onError = (error, stack) {
    reportError(error, stack, talker);
    return true;
  };

  Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
    final isolateError = pair as List<dynamic>;
    reportError(
        isolateError.first.toString(), isolateError.last.toString(), talker);
  }).sendPort);
}
