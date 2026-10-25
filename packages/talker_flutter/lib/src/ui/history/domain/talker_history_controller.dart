import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

class TalkerHistoryController extends ChangeNotifier {
  TalkerHistoryController({
    required TalkerStorage talkerDataStorage,
  }) : _talkerDataStorage = talkerDataStorage;

  final TalkerStorage _talkerDataStorage;

  List<TalkerSession>? get sessions => _sessions;
  List<TalkerSession>? _sessions;

  Future<void> loadSessions() async {
    _sessions = await _talkerDataStorage.getSessionsList();
    notifyListeners();
  }

  Future<void> deleteSession(String sessionId) async {
    await _talkerDataStorage.deleteSession(sessionId);
    unawaited(loadSessions());
  }
}
