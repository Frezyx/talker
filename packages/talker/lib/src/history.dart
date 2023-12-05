import 'package:talker/talker.dart';

class DefaultTalkerHistory implements TalkerHistory {
  DefaultTalkerHistory(this.settings);

  final TalkerSettings settings;

  final _history = <TalkerDataInterface>[];

  @override
  List<TalkerDataInterface> get history => _history;

  @override
  void clean() {
    if (settings.useHistory) {
      _history.clear();
    }
  }

  @override
  void write(TalkerDataInterface data) {
    if (settings.useHistory && settings.enabled) {
      if (settings.maxHistoryItems <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }
}

abstract class TalkerHistory {
  List<TalkerDataInterface> get history;
  void clean();
  void write(TalkerDataInterface data);
}
