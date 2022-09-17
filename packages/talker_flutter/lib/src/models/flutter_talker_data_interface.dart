import 'package:talker_flutter/talker_flutter.dart';

/// Add - on class to default [TalkerDataInterface]
/// with Flutter [Color] adding from [TalkerFlutterAdapterInterface]
abstract class FlutterTalkerDataInterface
    implements TalkerFlutterAdapterInterface, TalkerDataInterface {
  /// Used for [TalkerScreen] only
  String generateFlutterTextMessage() => generateTextMessage();
}
