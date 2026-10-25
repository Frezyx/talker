import 'dart:async';

import 'package:talker/talker.dart';

/// Base implementation of [TalkerHistory]
/// to save the history locally
class StorageTalkerHistory implements TalkerHistory {
  /// Take [TalkerSettings] as required parameter
  StorageTalkerHistory({
    required String sessionId,
    required this.settings,
    required TalkerStorage storage,
  })  : _storage = storage,
        _sessionId = sessionId,
        _runtime = RuntimeTalkerHistory(settings);

  /// Bring [TalkerSettings] to manage some configuration.
  final TalkerSettings settings;

  final RuntimeTalkerHistory _runtime;
  final String _sessionId;
  final TalkerStorage _storage;

  /// Return list of history
  @override
  List<TalkerData> get history => _runtime.history;

  @override
  void clean() {
    _runtime.history.clear();

    /// Check if you are authorized to write.
    final storageEnabled = settings.history.storageEnabled;
    if (!storageEnabled) return;

    _deleteSession();
  }

  @override
  void write(TalkerData data) {
    _runtime.write(data);

    /// Check if you are authorized to write.
    final storageEnabled = settings.history.storageEnabled;
    if (!storageEnabled) return;

    /// Check if you have reached the max number of history and delete them.
    final maxItems = settings.history.maxStorageItems;
    if (maxItems != null && maxItems <= _runtime.history.length) {
      _storage.deleteFirstInSession(_sessionId).whenComplete(
            () => _saveToSection(data),
          );
      return;
    }

    _saveToSection(data);
  }

  void _saveToSection(TalkerData data) {
    try {
      unawaited(
        _storage.saveToSession(
          sessionId: _sessionId,
          data: data,
        ),
      );
    } catch (_) {}
  }

  void _deleteSession() {
    try {
      unawaited(_storage.deleteSession(_sessionId));
    } catch (_) {
      //TODO: handle errors
    }
  }
}
