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

    final errKey = TalkerKey.error;
    final exceptionKey = TalkerKey.exception;

    if (exception is Error) {
      return TalkerError(
        exception,
        key: errKey,
        title: settings.getTitleByKey(errKey),
        message: msg,
        stackTrace: stackTrace,
      );
    }

    if (exception is Exception) {
      return TalkerException(
        exception,
        key: exceptionKey,
        title: settings.getTitleByKey(exceptionKey),
        message: msg,
        stackTrace: stackTrace,
      );
    }

    return TalkerLog(
      exception.toString(),
      key: errKey,
      title: settings.getTitleByKey(errKey),
      logLevel: LogLevel.error,
      stackTrace: stackTrace,
    );
  }
}
