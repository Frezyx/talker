import 'package:talker_flutter/talker_flutter.dart';

/// Example custom log that overrides generateTextMessage()
/// This demonstrates the fix for empty logs issue
class CustomFormattedLog extends TalkerLog {
  CustomFormattedLog(String message, {this.extraData}) : super(message);

  final String? extraData;

  static const logKey = 'custom_formatted_log';

  @override
  String? get key => logKey;

  @override
  AnsiPen get pen => AnsiPen()..xterm(121); // Bright green

  @override
  String generateTextMessage({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    var msg = '[$title] $message';
    if (extraData != null) {
      msg += '\nExtra Data: $extraData';
    }
    return msg;
  }
}

/// Example custom log that only overrides pen and key
/// This demonstrates the fix for color issue
class CustomColorLog extends TalkerLog {
  CustomColorLog(String message) : super(message);

  static const logKey = 'custom_color_log';

  @override
  String? get key => logKey;

  @override
  AnsiPen get pen => AnsiPen()..magenta(); // Magenta color

  @override
  String get title => 'custom';
}
