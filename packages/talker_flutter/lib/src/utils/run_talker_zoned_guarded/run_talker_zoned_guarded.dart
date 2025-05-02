import 'dart:async';

import 'package:talker_flutter/talker_flutter.dart';

export 'run_talker_zoned_guarded_native.dart'
    if (dart.library.js_interop) 'run_talker_zoned_guarded_web.dart';

Future<R?> runTalkerZonedGuarded<R>(Talker talker, R Function() body,
    void Function(Object error, StackTrace stack) onError,
    {Map<Object?, Object?>? zoneValues,
    ZoneSpecification? zoneSpecification,
    bool catchFlutterErrors = true}) async {
  setupErrorHooks(talker, catchFlutterErrors: catchFlutterErrors);
  return runZonedGuarded<R>(body, (dynamic error, StackTrace stackTrace) {
    onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }, zoneValues: zoneValues, zoneSpecification: zoneSpecification);
}
