import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FlutterTalkerLog extends TalkerException
    implements HaveFlutterColorInterface {
  FlutterTalkerLog(Exception exception, {this.color}) : super(exception);

  @override
  final Color? color;
}
