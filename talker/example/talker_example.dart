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
  await Talker.instance.configure(
    settings: const TalkerSettings(
      registeredTypes: [HttpTalkerLog],
    ),
  );

  try {
    throw Exception('Test service exception');
  } catch (e, st) {
    Talker.instance.handle(e, 'Working with string error', st);
  }

  try {
    throw Exception('Service can`t get test data');
  } on Exception catch (e, st) {
    Talker.instance.handleException(e, 'Working with strings exception', st);
  }

  Talker.instance.log(
    'Server error',
    logLevel: LogLevel.critical,
    additional: {
      "status": 500,
      "error": "Internal Server Error",
    },
  );

  Talker.instance.fine('Log fine');
  Talker.instance.error('Log error');
  Talker.instance.good('Log good');
  Talker.instance.verbose('Log verbose');
  Talker.instance.warning('Log warning');
  Talker.instance.critical('Log critical');

  final httpLog = HttpTalkerLog('Http good');
  Talker.instance.logTyped(httpLog);
}
