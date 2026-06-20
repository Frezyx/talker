import 'package:flutter/material.dart';
import 'package:talker_flutter/src/utils/download_logs/donwload_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerViewController extends ChangeNotifier {
  TalkerViewController({
    required Talker talker,
    bool expandedLogs = true,
    isLogOrderReversed = true,
  })  : _expandedLogs = expandedLogs,
        _isLogOrderReversed = isLogOrderReversed;

  /// Filter for selecting specific logs and errors on [TalkerScreen] and [TalkerView]
  /// by their keys [TalkerData.key] and by string query [TalkerFilter.searchQuery]
  /// Works only on screen (don't affect [Talker.filter])
  TalkerFilter _uiFilter = TalkerFilter();

  bool _expandedLogs;
  bool _isLogOrderReversed;
  String? _lastSavedLogsFileLocation;

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

  /// Method for updating a search query based on errors and logs
  void updateFilterSearchQuery(String query) {
    _uiFilter = _uiFilter.copyWith(searchQuery: query);
    notifyListeners();
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

  String? get lastSavedLogsFileLocation => _lastSavedLogsFileLocation;

  Future<void> downloadLogsFile(String logs) async {
    _lastSavedLogsFileLocation = await downloadFile(logs, DateTime.now());
  }

  /// Redefinition [notifyListeners]
  void update() => notifyListeners();
}
