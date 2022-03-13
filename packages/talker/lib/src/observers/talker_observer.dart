import 'package:talker/src/models/talker_data/talker_data.dart';

/// Base observer class for
/// to create your own observers
class TalkerObserver {
  const TalkerObserver({
    this.onError,
    this.onLog,
    this.onException,
  });

  /// Called when [Talker] handle an [TalkerError]
  final Function(TalkerError err)? onError;

  /// Called when [Talker] handle an [TalkerException]
  final Function(TalkerException err)? onException;

  /// Called when [Talker] handle an [TalkerDataInterface] log
  final Function(TalkerDataInterface log)? onLog;
}
