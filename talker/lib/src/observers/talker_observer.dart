import 'package:talker/src/models/talker_data/talker_data.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

/// Base observer class for
/// to create your own observers
class TalkerObserver {
  const TalkerObserver({
    this.onError,
    this.onLog,
  });

  /// Called when [Talker] handle an error / exception
  final Function(ErrorDetails err)? onError;

  /// Called when [Talker] handle an log
  final Function(TalkerDataInterface data)? onLog;
}
