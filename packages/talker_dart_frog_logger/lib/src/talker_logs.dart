import 'package:dart_frog/dart_frog.dart';
import 'package:talker/talker.dart';

import 'settings.dart';

class RequestLog extends TalkerLog {
  RequestLog(this.request, {required this.settings}) : super('req');

  final Request request;
  final TalkerDartFrogLoggerSettings settings;

  @override
  String? get title => 'req';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();
    sb.write(' ${displayTitleWithTime(timeFormat: timeFormat)}');
    sb.write('[${request.method.value}]');
    sb.write(' ${request.uri.path}');
    if (request.uri.query.isNotEmpty) {
      sb.write('?${request.uri.query}');
    }
    if (settings.printRequestHeaders && request.headers.isNotEmpty) {
      sb.write('\n');
      for (final entry in request.headers.entries) {
        sb.write('${entry.key}: ${entry.value}\n');
      }
    }
    return sb.toString();
  }
}

class ResponseLog extends TalkerLog {
  ResponseLog({
    required this.response,
    required this.request,
    required this.settings,
    required this.resTime,
  }) : super('res');

  final Request request;
  final Response response;
  final TalkerDartFrogLoggerSettings settings;
  final int resTime;

  @override
  String? get title => 'res';

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final sb = StringBuffer();

    sb.write(' ${displayTitleWithTime(timeFormat: timeFormat)}');
    sb.write('[${request.method.value}]');
    sb.write(' ${request.uri.path}');
    if (request.uri.query.isNotEmpty) {
      sb.write('?${request.uri.query}');
    }
    sb.write(' | ${response.statusCode}');
    sb.write(' | $resTime ms');

    if (settings.printResponseHeaders && response.headers.isNotEmpty) {
      sb.write('\n');
      for (final entry in response.headers.entries) {
        sb.write('${entry.key}: ${entry.value}\n');
      }
    }

    if (settings.printResponseBody) {
      sb.write('\n');
      sb.write(response.body);
    }
    return sb.toString();
  }
}
