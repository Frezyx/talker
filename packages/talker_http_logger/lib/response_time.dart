import 'package:talker/talker.dart';
import 'package:talker_http_logger/talker_http_logger_interceptor.dart';

mixin ResponseTime on TalkerLog {
  int? getResponseTime(Map<String, String> headers) {
    final int? triggerTime =
        int.tryParse(headers[TalkerHttpLogger.kLogsTimeStamp] ?? '');

    if (triggerTime != null && triggerTime > 0) {
      return DateTime.timestamp().millisecondsSinceEpoch - triggerTime;
    }

    return null;
  }
}
