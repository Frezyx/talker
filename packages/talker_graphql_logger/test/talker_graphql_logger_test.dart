import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:talker/talker.dart';
import 'package:talker_graphql_logger/talker_graphql_logger.dart';
import 'package:test/test.dart';

void main() {
  group('TalkerGraphQLLoggerSettings', () {
    test('should have correct default values', () {
      const settings = TalkerGraphQLLoggerSettings();

      expect(settings.enabled, isTrue);
      expect(settings.logLevel, equals(LogLevel.debug));
      expect(settings.printVariables, isTrue);
      expect(settings.printResponse, isTrue);
      expect(settings.printQuery, isFalse);
      expect(settings.responseMaxLength, equals(2000));
      expect(settings.obfuscateFields, isEmpty);
    });

    test('copyWith should override values correctly', () {
      const settings = TalkerGraphQLLoggerSettings();
      final newSettings = settings.copyWith(
        enabled: false,
        printVariables: false,
        obfuscateFields: {'password'},
      );

      expect(newSettings.enabled, isFalse);
      expect(newSettings.printVariables, isFalse);
      expect(newSettings.obfuscateFields, contains('password'));
      // Original values should be preserved
      expect(newSettings.printResponse, isTrue);
      expect(newSettings.responseMaxLength, equals(2000));
    });
  });

  group('TalkerGraphQLLink', () {
    late Talker talker;
    late List<TalkerData> logs;

    setUp(() {
      logs = [];
      talker = Talker();
      talker.stream.listen((log) => logs.add(log));
    });

    tearDown(() {
      talker.cleanHistory();
    });

    Request createRequest({
      String query = 'query GetUser { user { id name } }',
      String? operationName,
      Map<String, dynamic> variables = const {},
    }) {
      return Request(
        operation: Operation(
          document: parseString(query),
          operationName: operationName,
        ),
        variables: variables,
      );
    }

    test('should create instance with default talker', () {
      final link = TalkerGraphQLLink();
      expect(link, isNotNull);
    });

    test('should create instance with custom talker', () {
      final link = TalkerGraphQLLink(talker: talker);
      expect(link, isNotNull);
    });

    test('should not log when disabled', () async {
      final link = TalkerGraphQLLink(
        talker: talker,
        settings: const TalkerGraphQLLoggerSettings(enabled: false),
      );

      final terminalLink = MockTerminalLink();
      final composedLink = link.concat(terminalLink);

      final request = createRequest();
      await composedLink.request(request).first;

      expect(logs, isEmpty);
    });

    test('should log request and response', () async {
      final link = TalkerGraphQLLink(talker: talker);
      final terminalLink = MockTerminalLink();
      final composedLink = link.concat(terminalLink);

      final request = createRequest(
        query: 'query GetUser(\$id: ID!) { user(id: \$id) { id name } }',
        operationName: 'GetUser',
        variables: {'id': '123'},
      );

      await composedLink.request(request).first;

      // Wait for async logging
      await Future.delayed(const Duration(milliseconds: 50));

      expect(logs.length, equals(2));
      expect(logs[0], isA<GraphQLRequestLog>());
      expect(logs[1], isA<GraphQLResponseLog>());
    });

    test('should log GraphQL errors', () async {
      final link = TalkerGraphQLLink(talker: talker);
      final terminalLink = MockTerminalLink(
        response: const Response(
          response: {},
          data: null,
          errors: [
            GraphQLError(message: 'User not found'),
          ],
        ),
      );
      final composedLink = link.concat(terminalLink);

      final request = createRequest(operationName: 'GetUser');
      await composedLink.request(request).first;

      await Future.delayed(const Duration(milliseconds: 50));

      expect(logs.length, equals(2));
      expect(logs[0], isA<GraphQLRequestLog>());
      expect(logs[1], isA<GraphQLErrorLog>());
    });

    test('should filter requests', () async {
      final link = TalkerGraphQLLink(
        talker: talker,
        settings: TalkerGraphQLLoggerSettings(
          requestFilter: (request) {
            return request.operation.operationName != 'IgnoreMe';
          },
        ),
      );
      final terminalLink = MockTerminalLink();
      final composedLink = link.concat(terminalLink);

      // This request should be ignored
      final ignoredRequest = createRequest(operationName: 'IgnoreMe');
      await composedLink.request(ignoredRequest).first;

      await Future.delayed(const Duration(milliseconds: 50));

      expect(logs, isEmpty);

      // This request should be logged
      final loggedRequest = createRequest(operationName: 'LogMe');
      await composedLink.request(loggedRequest).first;

      await Future.delayed(const Duration(milliseconds: 50));

      expect(logs.length, equals(2));
    });
  });

  group('GraphQLRequestLog', () {
    test('should have correct key', () {
      final log = GraphQLRequestLog(
        'TestOperation',
        request: createSimpleRequest(),
        settings: const TalkerGraphQLLoggerSettings(),
      );

      expect(log.key, equals(TalkerKey.graphqlRequest));
    });

    test('should generate message with operation info', () {
      final request = Request(
        operation: Operation(
          document: parseString('query GetUser { user { id } }'),
          operationName: 'GetUser',
        ),
        variables: const {'id': '123'},
      );

      final log = GraphQLRequestLog(
        'GetUser',
        request: request,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      final message = log.generateTextMessage();

      expect(message, contains('[Query]'));
      expect(message, contains('GetUser'));
      expect(message, contains('Variables'));
      expect(message, contains('"id": "123"'));
    });

    test('should obfuscate sensitive fields', () {
      final request = Request(
        operation: Operation(
          document: parseString('mutation Login { login }'),
          operationName: 'Login',
        ),
        variables: const {
          'email': 'test@test.com',
          'password': 'secret123',
        },
      );

      final log = GraphQLRequestLog(
        'Login',
        request: request,
        settings: const TalkerGraphQLLoggerSettings(
          obfuscateFields: {'password'},
        ),
      );

      final message = log.generateTextMessage();

      expect(message, contains('"email": "test@test.com"'));
      expect(message, contains('"password": "*****"'));
      expect(message, isNot(contains('secret123')));
    });
  });

  group('GraphQLResponseLog', () {
    test('should have correct key', () {
      final log = GraphQLResponseLog(
        'TestOperation',
        request: createSimpleRequest(),
        response: const Response(response: {}, data: {'user': 'test'}),
        durationMs: 100,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      expect(log.key, equals(TalkerKey.graphqlResponse));
    });

    test('should include duration in message', () {
      final log = GraphQLResponseLog(
        'GetUser',
        request: createSimpleRequest(),
        response: const Response(response: {}, data: {
          'user': {'id': '1'}
        }),
        durationMs: 150,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      final message = log.generateTextMessage();

      expect(message, contains('Duration: 150 ms'));
    });

    test('should truncate long responses', () {
      final longData = {'data': 'x' * 3000};

      final log = GraphQLResponseLog(
        'GetData',
        request: createSimpleRequest(),
        response: Response(response: const {}, data: longData),
        durationMs: 100,
        settings: const TalkerGraphQLLoggerSettings(responseMaxLength: 100),
      );

      final message = log.generateTextMessage();

      expect(message, contains('[truncated]'));
    });
  });

  group('GraphQLErrorLog', () {
    test('should have correct key', () {
      final log = GraphQLErrorLog(
        'TestOperation',
        request: createSimpleRequest(),
        durationMs: 100,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      expect(log.key, equals(TalkerKey.graphqlError));
    });

    test('should have error log level', () {
      final log = GraphQLErrorLog(
        'TestOperation',
        request: createSimpleRequest(),
        durationMs: 100,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      expect(log.logLevel, equals(LogLevel.error));
    });

    test('should include GraphQL errors in message', () {
      final log = GraphQLErrorLog(
        'GetUser',
        request: createSimpleRequest(),
        response: const Response(
          response: {},
          data: null,
          errors: [
            GraphQLError(
              message: 'User not found',
              path: ['user'],
            ),
          ],
        ),
        durationMs: 50,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      final message = log.generateTextMessage();

      expect(message, contains('GraphQL Errors'));
      expect(message, contains('User not found'));
      expect(message, contains('Path: user'));
    });

    test('should include link exception in message', () {
      final log = GraphQLErrorLog(
        'GetUser',
        request: createSimpleRequest(),
        linkException: Exception('Network error'),
        durationMs: 50,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      final message = log.generateTextMessage();

      expect(message, contains('Exception'));
      expect(message, contains('Network error'));
    });
  });

  group('GraphQLSubscriptionLog', () {
    test('should have correct key', () {
      final log = GraphQLSubscriptionLog(
        'TestSubscription',
        request: createSimpleRequest(isSubscription: true),
        settings: const TalkerGraphQLLoggerSettings(),
      );

      expect(log.key, equals(TalkerKey.graphqlSubscription));
    });

    test('should include event type in message', () {
      final log = GraphQLSubscriptionLog(
        'OnMessage',
        request: createSimpleRequest(isSubscription: true),
        eventType: GraphQLSubscriptionEventType.data,
        settings: const TalkerGraphQLLoggerSettings(),
      );

      final message = log.generateTextMessage();

      expect(message, contains('[Subscription]'));
      expect(message, contains('Event: data'));
    });
  });
}

Request createSimpleRequest({bool isSubscription = false}) {
  final queryType = isSubscription ? 'subscription' : 'query';
  return Request(
    operation: Operation(
      document: parseString('$queryType Test { test }'),
      operationName: 'Test',
    ),
    variables: const {},
  );
}

/// Mock terminal link for testing
class MockTerminalLink extends Link {
  MockTerminalLink({
    Response? response,
  }) : _response =
            response ?? const Response(response: {}, data: {'success': true});

  final Response _response;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    return Stream.value(_response);
  }
}
