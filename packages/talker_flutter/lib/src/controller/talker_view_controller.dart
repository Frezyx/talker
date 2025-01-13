import 'package:flutter/material.dart';
import 'package:talker_flutter/src/utils/download_logs/donwload_logs.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerViewController extends ChangeNotifier {
  TalkerViewController({bool expandedLogs = true, isLogOrderReversed = true}) {
    _expandedLogs = expandedLogs;
    _isLogOrderReversed = isLogOrderReversed;
  }

  BaseTalkerFilter _filter = BaseTalkerFilter();

  late bool _expandedLogs;
  late bool _isLogOrderReversed;

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
