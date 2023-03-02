import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Controller to work with [TalkerScreen]
class TalkerScreenController extends ChangeNotifier {
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

  Future<String> saveLogsInFile(String logs) async {
    final dir = await getTemporaryDirectory();
    final dirPath = dir.path;
    final fmtDate = DateTime.now().toString().replaceAll(":", " ");
    final file =
        await File('$dirPath/talker_logs_$fmtDate.txt').create(recursive: true);
    await file.writeAsString(logs);
    return file.path;
  }

  /// Redefinition [notifyListeners]
  void update() => notifyListeners();
}
