import 'package:talker/src/models/talker_data/talker_data.dart';
import 'package:talker/src/observers/talker_observer.dart';
import 'package:talker_error_handler_core/talker_error_handler_core.dart';

class TalkerObserversManager {
  TalkerObserversManager(this.observers);
  final List<TalkerObserver> observers;

  void onError(ErrorContainer container) {
    for (final o in observers) {
      o.onError(container);
    }
  }

  void onLog(TalkerDataInterface data) {
    for (final o in observers) {
      o.onLog(data);
    }
  }
}
