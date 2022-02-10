import 'package:talker/talker.dart';

class TalkerErrorHandler implements TalkerErrorHandlerInterface {
  TalkerErrorHandler(this.settings);

  final TalkerSettings settings;

  @override
  TalkerDataInterface handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
  ]) {
    if (exception is Error) {
      return TalkerError(
        exception,
        stackTrace: stackTrace,
        message: msg,
        logLevel: LogLevel.error,
      );
    } else if (exception is Exception) {
      return TalkerException(
        exception,
        stackTrace: stackTrace,
        message: msg,
        logLevel: LogLevel.error,
      );
    }
    return TalkerLog(
      exception.toString(),
      logLevel: LogLevel.error,
      stackTrace: stackTrace,
    );
  }
}
