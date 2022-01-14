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
    'Big app crashing exception in Some service',
    logLevel: LogLevel.critical,
    additional: {
      "timestamp": 1510417124782,
      "status": 500,
      "error": "Internal Server Error",
      "exception": "com.netflix.hystrix.exception.HystrixRuntimeException",
      "message":
          "ApplicationRepository#save(Application) failed and no fallback available.",
      "path": "/application"
    },
  );

  Talker.instance.fine('Log fine');
  Talker.instance.error('Log error');
  Talker.instance.good('Log good');
  Talker.instance.verbose('Log verbose');
  Talker.instance.warning('Log warning');

  final httpLog = HttpTalkerLog('Http good');
  Talker.instance.logTyped(httpLog);
}
