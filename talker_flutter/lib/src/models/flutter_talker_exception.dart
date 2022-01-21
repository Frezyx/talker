import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FlutterTalkerException extends TalkerException
    implements HaveFlutterColorInterface {
  FlutterTalkerException(Exception exception, {this.color}) : super(exception);

  @override
  final Color? color;
}
