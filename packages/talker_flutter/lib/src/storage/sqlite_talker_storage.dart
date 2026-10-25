import 'package:talker/talker.dart';

class SqliteTalkerStorage implements TalkerStorage {
  @override
  Future<void> deleteSession(String sessionId) {
    // TODO: implement deleteSession
    throw UnimplementedError();
  }

  @override
  Future<List<TalkerSession>> getSessionsList() {
    // TODO: implement getSessionsList
    throw UnimplementedError();
  }

  @override
  Future<void> saveToSession(
      {required String sessionId, required TalkerData data}) {
    // TODO: implement saveToSession
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFirstInSession(String sessionId) {
    // TODO: implement deleteFirstInSession
    throw UnimplementedError();
  }
}
