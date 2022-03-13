import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerException]
/// with Flutter [Color] adding from [HaveFlutterColorInterface]
class FlutterTalkerLog extends TalkerLog implements HaveFlutterColorInterface {
  FlutterTalkerLog(String message, {this.color}) : super(message);

  @override
  final Color? color;
}
