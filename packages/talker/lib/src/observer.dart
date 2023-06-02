import 'package:talker/src/models/models.dart';

/// Base observer class for
/// to create your own observers
abstract class TalkerObserver {
  const TalkerObserver();

  /// Called when [Talker] handle an [TalkerError]
  void onError(TalkerError err) {}

  /// Called when [Talker] handle an [TalkerException]
  void onException(TalkerException err) {}

  /// Called when [Talker] handle an [TalkerDataInterface] log
  void onLog(TalkerDataInterface log) {}
}
