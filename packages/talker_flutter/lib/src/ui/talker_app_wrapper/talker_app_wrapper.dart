import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/snackbar.dart';
import 'package:talker_flutter/talker_flutter.dart';


/// class to wrap an the entire application
/// To listen to un handled exceptions

class TalkerAppWrapper {
  TalkerAppWrapper({
    required this.talker,
    required this.rootWidget,
    this.ensureInitialized = false,
  }) {
    _setupErrorHooks();
    runAppFromRootWidget();
  }
  void _reportError(
    dynamic error,
    dynamic stackTrace, {
    FlutterErrorDetails? errorDetails,
  }) async {
    talker.error("unhandled exception", error, stackTrace);
  }

  void _runZonedGuarded(void Function() callback) {
    runZonedGuarded<Future<void>>(() async {
      if (ensureInitialized) {
        WidgetsFlutterBinding.ensureInitialized();
      }
      callback();
    }, (dynamic error, StackTrace stackTrace) {
      _reportError(error, stackTrace);
    });
  }

  Future _setupErrorHooks() async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      _reportError(details.exception, details.stack, errorDetails: details);
    };

    ///Web doesn't have Isolate error listener support
    if (!kIsWeb) {
      Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
        final isolateError = pair as List<dynamic>;
        _reportError(
          isolateError.first.toString(),
          isolateError.last.toString(),
        );
      }).sendPort);
    }
  }

  void runAppFromRootWidget() {
    _runZonedGuarded(() {
      runApp(rootWidget);
    });
  }

  /// Root widget which will be ran
  final Widget rootWidget;

  /// Should talker run WidgetsFlutterBinding.ensureInitialized() during initialization.
  final bool ensureInitialized;

  final Talker talker;

}
