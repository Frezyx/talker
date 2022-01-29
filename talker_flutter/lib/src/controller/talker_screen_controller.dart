import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenController extends ChangeNotifier {
  TalkerFilter _filter = TalkerFilter(
    titles: [],
    types: [],
  );
  TalkerFilter get filter => _filter;
  set filter(TalkerFilter val) {
    _filter = val;
    notifyListeners();
  }

  void updateFilterSearchQuery(String query) {
    _filter = _filter.copyWith(searchQuery: query);
    notifyListeners();
  }

  void addFilterType(Type type) {
    _filter = _filter.copyWith(types: _filter.types..add(type));
    notifyListeners();
  }

  void removeFilterType(Type type) {
    _filter = _filter.copyWith(types: _filter.types..remove(type));
    notifyListeners();
  }

  void addFilterTitle(String title) {
    _filter = _filter.copyWith(titles: _filter.titles..add(title));
    notifyListeners();
  }

  void removeFilterTitle(String title) {
    _filter = _filter.copyWith(titles: _filter.titles..remove(title));
    notifyListeners();
  }

  void update() => notifyListeners();
}
