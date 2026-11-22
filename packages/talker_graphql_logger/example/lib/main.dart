import 'package:gql/language.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:gql_link/gql_link.dart';
import 'package:talker/talker.dart';
import 'package:talker_graphql_logger/talker_graphql_logger.dart';

void main() async {
  // Create talker instance
  final talker = Talker();

  // Create TalkerGraphQLLink with custom settings
  final talkerLink = TalkerGraphQLLink(
    talker: talker,
    settings: const TalkerGraphQLLoggerSettings(
      printVariables: true,
      printResponse: true,
      printQuery: false, // Query strings can be large
      obfuscateFields: {'password', 'token', 'secret'},
    ),
  );

  // Create the HTTP link
  final httpLink = HttpLink('https://api.spacex.land/graphql/');

  // Compose links
  final link = Link.from([talkerLink, httpLink]);

  // Example query
  const query = r'''
    query GetLaunches($limit: Int!) {
      launchesPast(limit: $limit) {
        mission_name
        launch_date_utc
        rocket {
          rocket_name
        }
      }
    }
  ''';

  // Create request
  final request = Request(
    operation: Operation(
      document: parseString(query),
      operationName: 'GetLaunches',
    ),
    variables: const {'limit': 5},
  );

  // Execute request
  try {
    await for (final response in link.request(request)) {
      print('Got response: ${response.data}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
