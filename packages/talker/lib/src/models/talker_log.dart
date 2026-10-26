import 'package:talker/talker.dart';

/// Base implementation of [TalkerData]
/// to create Logs
class TalkerLog extends TalkerData {
  TalkerLog(
    super.message, {
    super.key,
    super.title,
    super.exception,
    super.error,
    super.stackTrace,
    super.time,
    super.pen,
    super.logLevel,
  });

  /// {@macro talker_data_generateTextMessage}
  @override
  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$displayMessage$displayException$displayError$displayStackTrace';
  }
}
