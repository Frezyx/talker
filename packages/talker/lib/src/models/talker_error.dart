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
  }) : super(message, error: error) {
    _key = key ?? TalkerLogType.error.key;
    _logLevel = logLevel ?? LogLevel.error;
  }

  late String _key;
  late LogLevel _logLevel;

  @override
  String get key => _key;

  @override
  LogLevel? get logLevel => _logLevel;

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$displayMessage$displayError$displayStackTrace';
  }
}
