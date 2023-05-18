import 'package:talker/talker.dart';

Future<void> main() async {
  final talker = Talker(
    settings: TalkerSettings(),
  );

  try {
    throw Exception('Test service exception');
  } catch (e, st) {
    talker.handle(e, st, 'Working with string error');
  }

  talker.log(
    'Server error',
    logLevel: LogLevel.critical,
  );

  talker.error('Log error');
  talker.good('Log good');
  talker.verbose('Log verbose');
  talker.warning('Log warning');
  talker.critical('Log critical');

  final httpLog = HttpExampleTalkerLog('Http good');
  talker.logTyped(httpLog);
  talker.logTyped(AnalyticsExampleTalkerLog(talker));
}

class HttpExampleTalkerLog extends TalkerLog {
  HttpExampleTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return pen.write(message);
  }
}

class AnalyticsExampleTalkerLog extends TalkerLog {
  AnalyticsExampleTalkerLog(this.talker) : super('Report');

  final Talker talker;

  @override
  String get title => 'ANALYTICS';

  @override
  AnsiPen get pen => AnsiPen()..xterm(121);

  @override
  String generateTextMessage() {
    final msg = '''
$displayTitleWithTime$message
Registred logs: ${talker.history.length}
Registred symbols: ${talker.history.join().split('').length}''';
    return msg;
  }
}
