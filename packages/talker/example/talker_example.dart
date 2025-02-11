import 'package:talker/talker.dart';

Future<void> main() async {
  final talker = Talker(
    settings: TalkerSettings(
      colors: {
        TalkerLogType.info.key: AnsiPen()..magenta(),
        YourCustomLog.logKey: AnsiPen()..green(),
      },
      titles: {
        TalkerLogType.exception.key: 'Whatever you want',
        TalkerLogType.error.key: 'E',
        TalkerLogType.info.key: 'i',
        YourCustomLog.logKey: 'Custom',
      },
    ),
  );

  /// Logs with LogLevel
  // talker.warning('The pizza is over 😥');
  // talker.debug('Thinking about order new one 🤔');
  talker.error('The restaurant is closed ❌');
  talker.info('Ordering from other restaurant...');
  // talker.verbose('Payment started...');
  // talker.info('Payment completed! Waiting for pizza 🍕');

  /// [Exception]'s and [Error]'s handling
  try {
    throw Exception('Something went wrong');
  } catch (e, st) {
    talker.handle(e, st, 'Exception with');
  }

  /// Custom logs
  talker.logCustom(YourCustomLog('Something like your own service message'));
}

class YourCustomLog extends TalkerLog {
  YourCustomLog(String super.message);

  /// Your own log key (for color customization in settings)
  static const logKey = 'custom_log_key';

  @override
  String? get key => logKey;
}
