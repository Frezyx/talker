import 'package:talker/talker.dart';

abstract class TalkerStorage {
  Future<List<TalkerSession>> getSessionsList();
  Future<void> saveToSession({
    required String sessionId,
    required TalkerData data,
  });
  Future<void> deleteSession(String sessionId);
}
