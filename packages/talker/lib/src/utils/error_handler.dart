import 'package:talker/talker.dart';

class TalkerErrorHandler {
  TalkerErrorHandler(this.settings);

  final TalkerSettings settings;

  TalkerData handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
  ]) {
    if (exception is TalkerError) {
      return exception;
    }
    if (exception is TalkerException) {
      return exception;
    }
    if (exception is Error) {
      final errType = TalkerLogType.error;
      return TalkerError(
        exception,
        key: errType.key,
        title: settings.getTitleByLogType(errType),
        message: msg,
        stackTrace: stackTrace,
      );
    }
    if (exception is Exception) {
      final exceptionType = TalkerLogType.exception;
      return TalkerException(
        exception,
        key: exceptionType.key,
        title: settings.getTitleByLogType(exceptionType),
        message: msg,
        stackTrace: stackTrace,
      );
    }
    final errType = TalkerLogType.error;
    return TalkerLog(
      exception.toString(),
      key: errType.key,
      title: settings.getTitleByLogType(errType),
      logLevel: LogLevel.error,
      stackTrace: stackTrace,
    );
  }
}
