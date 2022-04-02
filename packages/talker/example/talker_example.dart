import 'package:talker/talker.dart';

class HttpTalkerLog extends TalkerLog {
  HttpTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return pen.write(message);
  }
}

Future<void> main() async {
  final talker = Talker(
    settings: TalkerSettings(
      registeredTypes: [HttpTalkerLog],
    ),
  );

  try {
    throw Exception('Test service exception');
  } catch (e, st) {
    talker.handle(e, st, 'Working with string error');
  }

  try {
    throw Exception('Service can`t get test data');
  } on Exception catch (e, st) {
    talker.handleException(e, st, 'Working with strings exception');
  }

  talker.log(
    'Server error',
    logLevel: LogLevel.critical,
  );

  talker.fine('Log fine');
  talker.error('Log error');
  talker.good('Log good');
  talker.verbose('Log verbose');
  talker.warning('Log warning');
  talker.critical('Log critical');

  final httpLog = HttpTalkerLog('Http good');
  talker.logTyped(httpLog);
}
