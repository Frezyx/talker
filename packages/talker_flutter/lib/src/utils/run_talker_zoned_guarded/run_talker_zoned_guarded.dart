import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<R?> runTalkerZonedGuarded<R>(Talker talker, R Function() body,
    void Function(Object error, StackTrace stack) onError,
    {Map<Object?, Object?>? zoneValues,
    ZoneSpecification? zoneSpecification,
    bool catchFlutterErrors = true}) async {
  _setupErrorHooks(talker, catchFlutterErrors: catchFlutterErrors);
  return runZonedGuarded<R>(body, (dynamic error, StackTrace stackTrace) {
    onError(error, stackTrace);
    _reportError(error, stackTrace, talker);
  }, zoneValues: zoneValues, zoneSpecification: zoneSpecification);
}

void _reportError(
  dynamic error,
  dynamic stackTrace,
  Talker talker, {
  FlutterErrorDetails? errorDetails,
}) async {
  talker.error("Unhandled Exception", error, stackTrace);
}

Future _setupErrorHooks(Talker talker, {bool catchFlutterErrors = true}) async {
  if (catchFlutterErrors) {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _reportError(details.exception, details.stack, talker,
          errorDetails: details);
    };
  }
  PlatformDispatcher.instance.onError = (error, stack) {
    _reportError(error, stack, talker);
    return true;
  };

  ///Web doesn't have Isolate error listener support
  if (!kIsWeb) {
    Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
      final isolateError = pair as List<dynamic>;
      _reportError(
          isolateError.first.toString(), isolateError.last.toString(), talker);
    }).sendPort);
  }
}
