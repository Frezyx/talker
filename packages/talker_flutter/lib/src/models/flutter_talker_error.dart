import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class FlutterTalkerError extends TalkerError
    implements HaveFlutterColorInterface {
  FlutterTalkerError(Error error, {this.color}) : super(error);

  @override
  final Color? color;
}
