import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenController extends ChangeNotifier {
  TalkerFilter _filter = TalkerFilter(
    titles: [],
  );
  TalkerFilter get filter => _filter;
  set filter(TalkerFilter val) {
    _filter = val;
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
