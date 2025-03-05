library talker_http_logger;

import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

class TalkerHttpLogger extends InterceptorContract {
  TalkerHttpLogger(
      {Talker? talker, this.settings = const TalkerHttpLoggerSettings()}) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;

  /// [TalkerHttpLogger] settings and customization
  TalkerHttpLoggerSettings settings;

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    final message = '${request.url}';
    _talker.logCustom(
        HttpRequestLog(message, request: request, settings: settings));
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    final message = '${response.request?.url}';

    if (response.statusCode >= 400 && response.statusCode < 600) {
      _talker.logCustom(HttpErrorLog(message, response: response));
    } else {
      _talker.logCustom(HttpResponseLog(message, response: response));
    }

    return response;
  }
}

const encoder = JsonEncoder.withIndent('  ');
const _hiddenValue = '*****';

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    String title, {
    required this.request,
    this.settings = const TalkerHttpLoggerSettings(),
  }) : super(title);

  final BaseRequest request;

  final TalkerHttpLoggerSettings settings;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get key => TalkerKey.httpRequest;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] [${request.method}] $message';

    final headers = Map.from(request.headers);

    try {
      if (headers.isNotEmpty) {
        if (settings.hiddenHeaders.isNotEmpty) {
          headers.updateAll((key, value) {
            return settings.hiddenHeaders
                    .map((v) => v.toLowerCase())
                    .contains(key.toLowerCase())
                ? _hiddenValue
                : value;
          });
        }
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class HttpResponseLog extends TalkerLog {
  HttpResponseLog(
    String title, {
    required this.response,
    this.settings = const TalkerHttpLoggerSettings(),
  }) : super(title);

  final BaseResponse response;

  final TalkerHttpLoggerSettings settings;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(46));

  @override
  String get key => TalkerKey.httpResponse;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] [${response.request?.method}] $message';

    final headers = response.request?.headers;

    msg += '\nStatus: ${response.statusCode}';

    try {
      if (headers?.isNotEmpty ?? false) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}

class HttpErrorLog extends TalkerLog {
  HttpErrorLog(
    String title, {
    required this.response,
    this.settings = const TalkerHttpLoggerSettings(),
  }) : super(title);

  final BaseResponse response;

  final TalkerHttpLoggerSettings settings;

  @override
  AnsiPen get pen => AnsiPen()..red();

  @override
  String get key => TalkerKey.httpError;

  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] [${response.request?.method}] $message';

    final headers = response.request?.headers;

    msg += '\nStatus: ${response.statusCode}';

    try {
      if (headers?.isNotEmpty ?? false) {
        final prettyHeaders = encoder.convert(headers);
        msg += '\nHeaders: $prettyHeaders';
      }
    } catch (_) {
      // TODO: add handling can`t convert
    }
    return msg;
  }
}
