import 'package:talker/src/models/talker_data/talker_data.dart';
import 'package:talker/src/observers/talker_observer.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

/// Manager to wrap all observers
class TalkerObserversManager {
  TalkerObserversManager(this.observers);
  final List<TalkerObserver> observers;

  /// Called when [Talker] handle an error / exception
  void onError(ErrorDetails container) {
    for (final o in observers) {
      o.onError?.call(container);
    }
  }

  /// Called when [Talker] handle an log
  void onLog(TalkerDataInterface data) {
    for (final o in observers) {
      o.onLog?.call(data);
    }
  }
}
