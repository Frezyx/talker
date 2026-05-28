import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:talker/talker.dart';

/// Registers [Talker] with Flutter DevTools so the DevTools extension
/// can request logs via VM Service Extension.
///
/// Only has effect in debug mode. Call [register] explicitly if you
/// create [Talker] without [TalkerFlutter.init].
class TalkerDevTools {
  TalkerDevTools._();

  static Talker? _devToolsTalker;
  static bool _extensionRegistered = false;

  /// Register [talker] for the DevTools extension. In [kDebugMode],
  /// [TalkerFlutter.init] does this automatically.
  static void register(Talker? talker) {
    if (!kDebugMode) return;
    _devToolsTalker = talker;
    _ensureExtensionRegistered();
  }

  static void _ensureExtensionRegistered() {
    if (_extensionRegistered) return;
    _extensionRegistered = true;
    developer.registerExtension(
      _extensionMethodName,
      _serviceExtensionHandler,
    );
  }

  static const String _extensionMethodName = 'ext.talker_flutter.getLogs';

  static Future<developer.ServiceExtensionResponse> _serviceExtensionHandler(
    String method,
    Map<String, String>? params,
  ) async {
    final talker = _devToolsTalker;
    if (talker == null) {
      return developer.ServiceExtensionResponse.result(
        jsonEncode({
          'logs': <Map<String, dynamic>>[],
          'total': 0,
        }),
      );
    }

    int sinceIndex = -1;
    if (params != null && params.containsKey('since')) {
      sinceIndex = int.tryParse(params['since']!) ?? -1;
    }

    final history = talker.history;
    final total = history.length;
    final logs = <Map<String, dynamic>>[];
    for (var i = 0; i < history.length; i++) {
      if (i > sinceIndex) {
        logs.add(_talkerDataToJson(history[i], i));
      }
    }

    return developer.ServiceExtensionResponse.result(
      jsonEncode({
        'logs': logs,
        'total': total,
      }),
    );
  }

  static Map<String, dynamic> _talkerDataToJson(TalkerData data, int index) {
    return {
      'index': index,
      'message': data.message,
      'key': data.key,
      'logLevel': data.logLevel?.name,
      'title': data.title,
      'time': data.time.toUtc().toIso8601String(),
      'stackTrace': data.stackTrace?.toString(),
      'exception': data.exception?.toString(),
      'error': data.error?.toString(),
    };
  }
}
