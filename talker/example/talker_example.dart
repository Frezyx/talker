import 'package:talker/talker.dart';

Future<void> main() async {
  await Talker.instance.configure();

  try {
    throw Exception('Test service exception');
  } catch (e, st) {
    Talker.instance.handle('Working with string error', e, st);
  }

  try {
    throw Exception('Service can`t get test data');
  } on Exception catch (e, st) {
    Talker.instance.handleException('Working with strings exception', e, st);
  }

  Talker.instance.log(
    'Big app crashing exception in Some service',
    LogLevel.critical,
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
}
