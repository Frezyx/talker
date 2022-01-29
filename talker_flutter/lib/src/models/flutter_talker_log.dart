import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FlutterTalkerLog extends TalkerLog implements HaveFlutterColorInterface {
  FlutterTalkerLog(String message, {this.color}) : super(message);

  @override
  final Color? color;
}
