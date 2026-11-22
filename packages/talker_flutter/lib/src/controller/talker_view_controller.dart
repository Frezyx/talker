import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/src/utils/download_logs/donwload_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerViewController extends ChangeNotifier {
  TalkerViewController({
    required Talker talker,
    bool expandedLogs = true,
    isLogOrderReversed = true,
  })  : _talker = talker,
        _expandedLogs = expandedLogs,
        _isLogOrderReversed = isLogOrderReversed;

  final Talker _talker;

  /// Filter for selecting specific logs and errors on [TalkerScreen] and [TalkerView]
  /// by their keys [TalkerData.key] and by string query [TalkerFilter.searchQuery]
  /// Works only on screen (don't affect [Talker.filter])
  TalkerFilter _uiFilter = TalkerFilter();

  bool _expandedLogs;
  bool _isLogOrderReversed;

  /// Whether log streaming is paused.
  /// When paused, the view shows a frozen snapshot of logs.
  bool _isPaused = false;

  /// Frozen snapshot of logs taken when pause was activated.
  List<TalkerData> _frozenLogs = [];

  Timer? _searchDebounceTimer;

  /// Duration for debouncing search query updates.
  static const _searchDebounceDuration = Duration(milliseconds: 300);

  /// Filter for selecting specific logs and errors
  TalkerFilter get filter => _uiFilter;
  set filter(TalkerFilter val) {
    _uiFilter = val;
    notifyListeners();
  }

  bool get expandedLogs => _expandedLogs;

  void toggleExpandedLogs() {
    _expandedLogs = !_expandedLogs;
    notifyListeners();
  }

  bool get isLogOrderReversed => _isLogOrderReversed;

  /// Toggle log order (earliest or latest first)
  void toggleLogOrder() {
    _isLogOrderReversed = !_isLogOrderReversed;
    notifyListeners();
  }

  /// Whether log streaming is paused
  bool get isPaused => _isPaused;

  /// Frozen snapshot of logs (empty when not paused)
  List<TalkerData> get frozenLogs => _frozenLogs;

  /// Toggle pause/resume. When pausing, freezes the current log history.
  /// When resuming, clears the frozen snapshot and returns to live logs.
  void togglePause() {
    if (_isPaused) {
      _frozenLogs = [];
      _isPaused = false;
    } else {
      _frozenLogs = List.from(_talker.history);
      _isPaused = true;
    }
    notifyListeners();
  }

  /// Method for updating a search query based on errors and logs.
  /// Uses debouncing to avoid excessive rebuilds during rapid typing.
  void updateFilterSearchQuery(String query) {
    _searchDebounceTimer?.cancel();
    _searchDebounceTimer = Timer(_searchDebounceDuration, () {
      _uiFilter = _uiFilter.copyWith(searchQuery: query);
      notifyListeners();
    });
  }

  /// Method adds an key to the filter
  void addFilterKey(String key) {
    _uiFilter = _uiFilter.copyWith(
      enabledKeys: [..._uiFilter.enabledKeys, key],
    );
    notifyListeners();
  }

  /// Method removes an key from the filter
  void removeFilterKey(String key) {
    _uiFilter = _uiFilter.copyWith(
      enabledKeys: _uiFilter.enabledKeys.where((t) => t != key).toList(),
    );
    notifyListeners();
  }

  Future<void> downloadLogsFile(String logs) async => await downloadFile(logs);

  /// Redefinition [notifyListeners]
  void update() => notifyListeners();

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    super.dispose();
  }
}
