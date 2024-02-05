import 'package:talker/talker.dart';

/// Base implementation of [TalkerHistory]
/// to save the history locally
class DefaultTalkerHistory implements TalkerHistory {
  /// Take [TalkerSettings] as required parameter
  DefaultTalkerHistory(this.settings, {List<TalkerData>? history}) {
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
    if (settings.useHistory && settings.enabled) {
      /// Check if you have reached the max number of history and delete them.
      if (settings.maxHistoryItems <= _history.length) {
        _history.removeAt(0);
      }
      _history.add(data);
    }
  }
}

/// Base class for create your own implementation of history
///
/// The history stores all information about all events like
/// occurred errors [TalkerError]s, exceptions [TalkerException]s
/// and logs [TalkerLog]s that have been sent
abstract class TalkerHistory {
  /// Return List of [TalkerDataInterface]
  List<TalkerData> get history;

  /// Called when [Talker] handle [cleanHistory].
  /// For example, [TalkerView] handle the [Talker.cleanHistory]
  void clean();

  /// Called when [Talker] handle an [TalkerDataInterface] log
  void write(TalkerData data);
}
