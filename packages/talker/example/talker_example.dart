import 'package:talker/talker.dart';

Future<void> main() async {
  final talker = Talker();

  // Handle exceptions and errors
  try {
    throw Exception('Something went wrong');
  } catch (e, st) {
    talker.handle(e, st, 'Exception with');
  }

  // Log your app actions
  talker.info('App is started');
  talker.debug('All services enabled');
  talker.error('❌ Houston, we have a problem!');
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
