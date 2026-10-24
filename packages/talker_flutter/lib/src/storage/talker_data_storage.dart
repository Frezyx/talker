import 'package:talker_flutter/talker_flutter.dart';

class TalkerSession {
  TalkerSession({
    required this.id,
    required this.date,
    required this.logs,
  });

  final String id;
  final DateTime date;
  final List<TalkerData> logs;
}

abstract class TalkerDataStorage {
  Future<List<TalkerSession>> getSessionsList();
  Future<void> saveToSession({
    required String sessionId,
    required TalkerData data,
  });
  Future<void> deleteSession();
}
