import 'package:talker/talker.dart';

/// Base implementation of [TalkerData]
/// to handle ONLY [Exception]s
class TalkerException extends TalkerData {
  TalkerException(
    Exception exception, {
    String? message,
    super.stackTrace,
    String? key,
    super.title,
    LogLevel? logLevel,
  }) : super(
          message,
          logLevel: logLevel ?? LogLevel.error,
          exception: exception,
          key: key ?? TalkerKey.exception,
        );

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$displayMessage$displayException$displayStackTrace';
  }
}
