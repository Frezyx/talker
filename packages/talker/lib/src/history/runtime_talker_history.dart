import 'package:talker/talker.dart';

//TODO: provide storage to write data
/// Base implementation of [TalkerHistory]
/// to save the history locally
class RuntimeTalkerHistory implements TalkerHistory {
  /// Take [TalkerSettings] as required parameter
  RuntimeTalkerHistory(this.settings, {List<TalkerData>? history}) {
    if (history != null) {
      _history.addAll(history);
    }
  }

  /// Bring [TalkerSettings] to manage some configuration.
  final TalkerSettings settings;

  /// Save locally
  final _history = <TalkerData>[];

  /// Return list of history
  @override
  List<TalkerData> get history => _history;

  @override
  void clean() {
    /// Check if you can clear the history.
    if (settings.useHistory) {
      _history.clear();
    }
  }

  @override
  void write(TalkerData data) {
    /// Check if you are authorized to write.
    if (settings.useHistory) {
      /// Check if you have reached the max number of history and delete them.
      final maxHistoryItems = settings.maxHistoryItems;
      if (maxHistoryItems != null && maxHistoryItems <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }
}
