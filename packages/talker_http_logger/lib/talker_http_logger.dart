library talker_http_logger;

import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker/talker.dart';

class TalkerHttpLogger extends InterceptorContract {
  TalkerHttpLogger({Talker? talker}) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {
    final message = '${request.url}';
    _talker.logTyped(HttpRequestLog(message, request: request));
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    final message = '${response.request?.url}';
    _talker.logTyped(HttpResponseLog(message, response: response));
    return response;
  }
}

const encoder = JsonEncoder.withIndent('  ');

class HttpRequestLog extends TalkerLog {
  HttpRequestLog(
    String title, {
    required this.request,
  }) : super(title);

  final BaseRequest request;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(219));

  @override
  String get title => WellKnownTitles.httpRequest.title;

  @override
  String generateTextMessage() {
    var msg = '[$title] [${request.method}] $message';

    final headers = request.headers;

    try {
      if (headers.isNotEmpty) {
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
  }) : super(title);

  final BaseResponse response;

  @override
  AnsiPen get pen => (AnsiPen()..xterm(46));

  @override
  String get title => WellKnownTitles.httpResponse.title;

  @override
  String generateTextMessage() {
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
