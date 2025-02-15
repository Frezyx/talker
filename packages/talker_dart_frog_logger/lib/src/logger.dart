import 'package:dart_frog/dart_frog.dart';
import 'package:talker/talker.dart';

import 'settings.dart';
import 'talker_logs.dart';

Handler loggerMiddleware({
  required Handler handler,
  TalkerDartFrogLoggerSettings settings = const TalkerDartFrogLoggerSettings(),
}) {
  return (context) async {
    final talker = context.read<Talker>();

    if (settings.logRequest) {
      final requestLog = RequestLog(context.request, settings: settings);
      talker.logCustom(requestLog);
    }

    final stopwatch = Stopwatch()..start();
    final response = await handler(context);
    stopwatch.stop();

    final time = stopwatch.elapsedMilliseconds;

    if (settings.logResponse) {
      final responseLog = ResponseLog(
        request: context.request,
        response: response,
        settings: settings,
        resTime: time,
      );
      talker.logCustom(responseLog);
    }
    return response;
  };
}
