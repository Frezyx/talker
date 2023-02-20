import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerDioLogger tests', () {
    late TalkerDioLogger logger;
    late Talker talker;

    setUp(() {
      talker = Talker(settings: TalkerSettings(useConsoleLogs: false));
      logger = TalkerDioLogger(talker: talker);
    });

    test('configure method should update logger settings', () {
      logger.configure(printRequestData: true);
      expect(logger.settings.printRequestData, true);
    });

    test('onRequest method should log http request', () {
      final options = RequestOptions(path: '/test');
      final logMessage = '${options.uri}';
      logger.onRequest(options, RequestInterceptorHandler());
      expect(talker.history.last.message, logMessage);
    });

    test('onResponse method should log http response', () {
      final options = RequestOptions(path: '/test');
      final response = Response(requestOptions: options, statusCode: 200);
      final logMessage = '${response.requestOptions.uri}';
      logger.onResponse(response, ResponseInterceptorHandler());
      expect(talker.history.last.message, logMessage);
    });
  });
}
