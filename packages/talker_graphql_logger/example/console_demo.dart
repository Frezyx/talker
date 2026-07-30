// ignore_for_file: avoid_print

import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:talker/talker.dart';
import 'package:talker_graphql_logger/talker_graphql_logger.dart';

void main() async {
  final talker = Talker();

  print('=== TalkerGraphQLLogger Demo ===\n');

  // Demo 1: Request Log
  print('--- Request Log ---');
  final requestLog = GraphQLRequestLog(
    'GetUser',
    request: Request(
      operation: Operation(
        document: parseString(
          'query GetUser(\$id: ID!) { user(id: \$id) { id name email } }',
        ),
        operationName: 'GetUser',
      ),
      variables: const {'id': '123'},
    ),
    settings: const TalkerGraphQLLoggerSettings(),
  );
  talker.logCustom(requestLog);

  print('\n--- Request Log with obfuscated password ---');
  final loginRequestLog = GraphQLRequestLog(
    'Login',
    request: Request(
      operation: Operation(
        document: parseString('mutation Login { login }'),
        operationName: 'Login',
      ),
      variables: const {
        'email': 'user@example.com',
        'password': 'super_secret_123',
        'token': 'abc123xyz',
      },
    ),
    settings: const TalkerGraphQLLoggerSettings(
      obfuscateFields: {'password', 'token'},
    ),
  );
  talker.logCustom(loginRequestLog);

  // Demo 2: Response Log
  print('\n--- Response Log ---');
  final responseLog = GraphQLResponseLog(
    'GetUser',
    request: Request(
      operation: Operation(
        document: parseString('query GetUser { user { id name } }'),
        operationName: 'GetUser',
      ),
      variables: const {},
    ),
    response: const Response(
      response: {},
      data: {
        'user': {
          'id': '123',
          'name': 'John Doe',
          'email': 'john@example.com',
        },
      },
    ),
    durationMs: 142,
    settings: const TalkerGraphQLLoggerSettings(),
  );
  talker.logCustom(responseLog);

  // Demo 3: Error Log
  print('\n--- Error Log (GraphQL Error) ---');
  final errorLog = GraphQLErrorLog(
    'GetUser',
    request: Request(
      operation: Operation(
        document: parseString('query GetUser { user { id } }'),
        operationName: 'GetUser',
      ),
      variables: const {'id': 'invalid'},
    ),
    response: const Response(
      response: {},
      data: null,
      errors: [
        GraphQLError(
          message: 'User not found',
          path: ['user'],
          locations: [
            ErrorLocation(line: 1, column: 15),
          ],
        ),
      ],
    ),
    durationMs: 45,
    settings: const TalkerGraphQLLoggerSettings(),
  );
  talker.logCustom(errorLog);

  // Demo 4: Network Error Log
  print('\n--- Error Log (Network Error) ---');
  final networkErrorLog = GraphQLErrorLog(
    'GetUser',
    request: Request(
      operation: Operation(
        document: parseString('query GetUser { user { id } }'),
        operationName: 'GetUser',
      ),
      variables: const {},
    ),
    linkException: Exception('Connection refused'),
    durationMs: 3000,
    settings: const TalkerGraphQLLoggerSettings(),
  );
  talker.logCustom(networkErrorLog);

  // Demo 5: Subscription Log
  print('\n--- Subscription Log ---');
  final subscriptionLog = GraphQLSubscriptionLog(
    'OnNewMessage',
    request: Request(
      operation: Operation(
        document: parseString(
          'subscription OnNewMessage { newMessage { id text } }',
        ),
        operationName: 'OnNewMessage',
      ),
      variables: const {},
    ),
    response: const Response(
      response: {},
      data: {
        'newMessage': {
          'id': '456',
          'text': 'Hello from subscription!',
        },
      },
    ),
    eventType: GraphQLSubscriptionEventType.data,
    settings: const TalkerGraphQLLoggerSettings(),
  );
  talker.logCustom(subscriptionLog);

  // Demo 6: Full flow with Link
  print('\n--- Full Flow Demo (Link) ---');
  final talkerLink = TalkerGraphQLLink(
    talker: talker,
    settings: const TalkerGraphQLLoggerSettings(
      printVariables: true,
      printResponse: true,
    ),
  );

  final mockLink = _MockLink();
  final link = talkerLink.concat(mockLink);

  await link
      .request(
        Request(
          operation: Operation(
            document: parseString(
              'mutation CreateUser(\$input: CreateUserInput!) { createUser(input: \$input) { id } }',
            ),
            operationName: 'CreateUser',
          ),
          variables: const {
            'input': {
              'name': 'Jane Doe',
              'email': 'jane@example.com',
            },
          },
        ),
      )
      .first;

  print('\n=== Demo Complete ===');
}

class _MockLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    await Future.delayed(const Duration(milliseconds: 50));
    yield const Response(
      response: {},
      data: {
        'createUser': {'id': '789'},
      },
    );
  }
}
