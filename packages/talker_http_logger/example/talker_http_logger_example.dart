import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';

void main(List<String> args) async {
  final client = InterceptedClient.build(interceptors: [
    TalkerHttpLogger(),
  ]);

  await client.get("https://google.com".toUri());
}
