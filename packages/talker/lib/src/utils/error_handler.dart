import 'package:talker/talker.dart';

class TalkerErrorHandler {
  TalkerErrorHandler(this.settings);

  final TalkerSettings settings;

  TalkerDataInterface handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
  ]) {
    if (exception is Error) {
      return TalkerError(
        exception,
        title: WellKnownTitles.exception.title,
        stackTrace: stackTrace,
        message: msg,
        logLevel: LogLevel.error,
      );
    }
    if (exception is Exception) {
      return TalkerException(
        exception,
        title: WellKnownTitles.error.title,
        stackTrace: stackTrace,
        message: msg,
        logLevel: LogLevel.error,
      );
    }
    return TalkerLog(
      exception.toString(),
      title: WellKnownTitles.exception.title,
      logLevel: LogLevel.error,
      stackTrace: stackTrace,
    );
  }
}
