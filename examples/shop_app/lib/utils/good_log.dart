import 'package:talker_flutter/talker_flutter.dart';

/// `GoodLog` - This class contains the basic structure of the log.
class GoodLog extends TalkerLog {
  GoodLog(String super.message);

  /// Log title
  @override
  String get title => 'good';

  /// Log key
  @override
  String get key => getKey;

  /// Log color
  @override
  AnsiPen get pen => getPen;

  static get getPen => AnsiPen()..xterm(121);

  static get getKey => 'good';
}
