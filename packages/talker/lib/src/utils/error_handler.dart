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
      final errType = TalkerKey.error;
      return TalkerError(
        exception,
        key: errType.key,
        title: errType.getTitle(settings),
        message: msg,
        stackTrace: stackTrace,
      );
    }
    if (exception is Exception) {
      final exceptionType = TalkerKey.exception;
      return TalkerException(
        exception,
        key: exceptionType.key,
        title: exceptionType.getTitle(settings),
        message: msg,
        stackTrace: stackTrace,
      );
    }
    final errType = TalkerKey.error;
    return TalkerLog(
      exception.toString(),
      key: errType.key,
      title: errType.getTitle(settings),
      logLevel: LogLevel.error,
      stackTrace: stackTrace,
    );
  }
}
