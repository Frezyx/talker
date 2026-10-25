import 'package:talker_flutter/talker_flutter.dart';

class TalkerSessionObserver implements TalkerObserver {
  const TalkerSessionObserver({
    required this.sessionId,
    required this.storage,
  });
  final String sessionId;
  final TalkerStorage storage;

  @override
  void onLog(TalkerData log) {
    storage.saveToSession(sessionId: sessionId, data: log);
  }

  @override
  void onError(TalkerError err) {
    storage.saveToSession(sessionId: sessionId, data: err);
  }

  @override
  void onException(TalkerException err) {
    storage.saveToSession(sessionId: sessionId, data: err);
  }
}
