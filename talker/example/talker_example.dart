import 'package:talker/talker.dart';

void main() {
  try {
    const searchedText = null;
    // throw Exception('Service can`t get test data');
    searchedText as String;
    searchedText.contains('n');
  } on Error catch (e, st) {
    Talker.instance.handleError('Working with string error', e, st);
  } on Exception catch (e, st) {
    Talker.instance.handleException('Working with strings exception', e, st);
  }

  // Talker.instance.log(
  //   'Big app crashing exception in Some service',
  //   LogLevel.critical,
  //   additional: {
  //     "timestamp": 1510417124782,
  //     "status": 500,
  //     "error": "Internal Server Error",
  //     "exception": "com.netflix.hystrix.exception.HystrixRuntimeException",
  //     "message":
  //         "ApplicationRepository#save(Application) failed and no fallback available.",
  //     "path": "/application"
  //   },
  // );
}
