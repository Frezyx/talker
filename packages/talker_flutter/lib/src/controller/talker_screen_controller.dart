import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerScreenController extends ChangeNotifier {
  TalkerFilter _filter = TalkerFilter(
    titles: [],
    types: [],
  );

  var _expandedLogs = true;
  bool _isLogOrderReversed = false;

  /// Filter for selecting specific logs and errors
  TalkerFilter get filter => _filter;
  set filter(TalkerFilter val) {
    _filter = val;
    notifyListeners();
  }

  bool get expandedLogs => _expandedLogs;
  set expandedLogs(bool val) {
    if (val != _expandedLogs) {
      _expandedLogs = val;
      notifyListeners();
    }
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
    _filter = _filter.copyWith(types: _filter.types..add(type));
    notifyListeners();
  }

  /// Method removes an type from the filter
  void removeFilterType(Type type) {
    _filter = _filter.copyWith(types: _filter.types..remove(type));
    notifyListeners();
  }

  /// Method adds an title to the filter
  void addFilterTitle(String title) {
    _filter = _filter.copyWith(titles: _filter.titles..add(title));
    notifyListeners();
  }

  /// Method removes an title from the filter
  void removeFilterTitle(String title) {
    _filter = _filter.copyWith(titles: _filter.titles..remove(title));
    notifyListeners();
  }

  /// Redefinition [notifyListeners]
  void update() => notifyListeners();
}
