import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerError]
/// with Flutter [Color] adding from [HaveFlutterColorInterface]
class FlutterTalkerError extends TalkerError
    implements HaveFlutterColorInterface {
  FlutterTalkerError(Error error, {this.color}) : super(error);

  @override
  final Color? color;
}
