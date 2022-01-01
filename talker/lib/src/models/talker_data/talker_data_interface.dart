import 'package:talker/talker.dart';

abstract class TalkerDataInterface {
  String? get message;
  LogLevel? get logLevel;
  Exception? get exception;
  Error? get error;
  StackTrace? get stackTrace;
  Map<String, dynamic>? get additional;
}
