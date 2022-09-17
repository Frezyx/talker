import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerException]
/// with Flutter [Color] adding from [TalkerFlutterAdapterInterface]
class FlutterTalkerLog extends TalkerLog
    implements TalkerFlutterAdapterInterface {
  FlutterTalkerLog(String message, {this.color}) : super(message);

  @override
  final Color? color;

  /// Used for [TalkerScreen] only
  String generateFlutterTextMessage() => generateTextMessage();
}
