import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';

void main(List<String> args) async {
  final InterceptedClient client = InterceptedClient.build(
    interceptors: [
      TalkerHttpLogger(
        settings: TalkerHttpLoggerSettings(
          hiddenHeaders: {'Authorization'},
        ),
      ),
    ],
  );

  await client.get(
    Uri.https("google.com"),
    headers: {
      "firstHeader": "firstHeaderValue",
      "authorization": "bearer super_secret_token",
      "lastHeader": "lastHeaderValue",
    },
  );
}
