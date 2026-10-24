import 'package:talker_flutter/src/storage/storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSessionObserver extends TalkerObserver {
  const TalkerSessionObserver({
    required this.sessionId,
    required this.storage,
  });
  final String sessionId;
  final TalkerDataStorage storage;

  @override
  void onLog(TalkerData log) {
    storage.saveToSession(sessionId: sessionId, data: log);
    super.onLog(log);
  }

  @override
  void onError(TalkerError err) {
    storage.saveToSession(sessionId: sessionId, data: err);
    super.onError(err);
  }

  @override
  void onException(TalkerException err) {
    storage.saveToSession(sessionId: sessionId, data: err);
    super.onException(err);
  }
}
