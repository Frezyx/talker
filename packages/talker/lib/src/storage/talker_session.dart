import 'package:talker/talker.dart';

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
