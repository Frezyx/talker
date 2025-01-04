import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      talker.handle(details.exception, details.stack);
    };
  }
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };

  Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
    final isolateError = pair as List<dynamic>;
    final error = isolateError.first.toString();
    talker.handle(error);
  }).sendPort);
}
