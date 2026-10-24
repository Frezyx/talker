import 'package:talker/talker.dart';
import 'package:talker_flutter/src/storage/talker_data_storage.dart';

class SqliteTalkerDataStorage implements TalkerDataStorage {
  @override
  Future<void> deleteSession() {
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
}
