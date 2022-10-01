import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerError]
/// with Flutter [Color] adding from [TalkerFlutterAdapterInterface]
class FlutterTalkerError extends TalkerError
    implements FlutterTalkerDataInterface {
  FlutterTalkerError(Error error, {this.color}) : super(error);

  @override
  final Color? color;

  /// Used for [TalkerScreen] only
  @override
  String generateFlutterTextMessage() => generateTextMessage();
}
