import 'package:talker/talker.dart';

/// Base implementation of [TalkerData]
/// to handle ONLY [Error]s
class TalkerError extends TalkerData {
  TalkerError(
    Error error, {
    String? message,
    super.stackTrace,
    String? key,
    super.title,
    LogLevel? logLevel,
  }) : super(
    message,
    logLevel: logLevel ?? LogLevel.error,
    error: error,
    key: key ?? TalkerLogType.error.key,
  );

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$displayMessage$displayError$displayStackTrace';
  }
}
