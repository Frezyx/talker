import 'package:talker/talker.dart';

const _customLogKey = 'your_cutom_log_key';

Future<void> main() async {
  final talker = Talker(
    settings: TalkerSettings(
      colors: {
        TalkerLogType.info.key: AnsiPen()..magenta(),
        _customLogKey: AnsiPen()..green(),
      },
      titles: {
        TalkerLogType.exception: 'Whatever you want',
        TalkerLogType.error: 'E',
        TalkerLogType.info: 'i',
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
  YourCustomLog(String message) : super(message);

  /// Your own log key (for color customization in settings)
  @override
  String? get key => _customLogKey;

  /// Your custom log title
  @override
  String get title => 'CUSTOM';

  // /// Your custom log color
  // @override
  // AnsiPen get pen => AnsiPen()..green();
}
