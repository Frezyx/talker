import 'package:flutter/material.dart';
import 'package:talker_flutter/src/utils/download_logs/download_nonweb_logs.dart'
    if (dart.library.html) 'package:talker_flutter/src/utils/download_logs/download_web_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerViewController extends ChangeNotifier {
  BaseTalkerFilter _filter = BaseTalkerFilter();

  var _expandedLogs = true;
  bool _isLogOrderReversed = true;

  /// Filter for selecting specific logs and errors
  BaseTalkerFilter get filter => _filter;
  set filter(BaseTalkerFilter val) {
    _filter = val;
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
    _filter = _filter.copyWith(searchQuery: query);
    notifyListeners();
  }

  /// Method adds an type to the filter
  void addFilterType(Type type) {
    _filter = _filter.copyWith(types: [..._filter.types, type]);
    notifyListeners();
  }

  /// Method removes an type from the filter
  void removeFilterType(Type type) {
    _filter =
        _filter.copyWith(types: _filter.types.where((t) => t != type).toList());
    notifyListeners();
  }

  /// Method adds an title to the filter
  void addFilterTitle(String title) {
    _filter = _filter.copyWith(titles: [..._filter.titles, title]);
    notifyListeners();
  }

  /// Method removes an title from the filter
  void removeFilterTitle(String title) {
    _filter = _filter.copyWith(
        titles: _filter.titles.where((t) => t != title).toList());
    notifyListeners();
  }

  Future<void> downloadLogsFile(String logs) async => await downloadFile(logs);

  /// Redefinition [notifyListeners]
  void update() => notifyListeners();
}
