import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerException]
/// with Flutter [Color] adding from [TalkerFlutterAdapterInterface]
class FlutterTalkerException extends TalkerException
    implements FlutterTalkerDataInterface {
  FlutterTalkerException(Exception exception, {this.color}) : super(exception);

  @override
  final Color? color;

  /// Used for [TalkerScreen] only
  @override
  String generateFlutterTextMessage() => generateTextMessage();
}
