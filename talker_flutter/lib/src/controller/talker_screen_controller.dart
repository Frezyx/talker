import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenController extends ChangeNotifier {
  TalkerFilter _filter = TalkerFilter();
  TalkerFilter get filter => _filter;
  set filter(TalkerFilter val) {
    _filter = val;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }
}
