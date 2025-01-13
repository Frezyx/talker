import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

void main(List<String> args) async {
  final client = InterceptedClient.build(interceptors: [
    TalkerHttpLogger(
        settings: TalkerHttpLoggerSettings(
            hideHeaderValuesForKeys: {'Authorization'})),
  ]);

  await client.get("https://google.com".toUri(), headers: {
    "firstHeader": "firstHeaderValue",
    "authorization": "bearer super_secret_token",
    "lastHeader": "lastHeaderValue",
  });
}
