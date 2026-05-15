# talker_graphql_logger

Lightweight and customizable GraphQL client logger on [talker](https://pub.dev/packages/talker) base.

## Preview

<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_graphql_logger/preview.png?raw=true" alt="talker_graphql_logger preview" width="600">

## Getting started

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  talker: ^5.1.1
  talker_graphql_logger: ^5.1.1
  graphql: ^5.2.3 # or gql packages
```

## Usage

### Basic Setup

```dart
import 'package:talker/talker.dart';
import 'package:talker_graphql_logger/talker_graphql_logger.dart';
import 'package:gql_link/gql_link.dart';
import 'package:gql_http_link/gql_http_link.dart';

void main() {
  // Create talker instance
  final talker = Talker();

  // Create TalkerGraphQLLink
  final talkerLink = TalkerGraphQLLink(talker: talker);

  // Create HTTP link
  final httpLink = HttpLink('https://api.example.com/graphql');

  // Compose links
  final link = Link.from([
    talkerLink,
    httpLink,
  ]);

  // Use the link with your GraphQL client
}
```

### With graphql_flutter package

```dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:talker/talker.dart';
import 'package:talker_graphql_logger/talker_graphql_logger.dart';

void main() async {
  await initHiveForFlutter();

  final talker = Talker();

  final talkerLink = TalkerGraphQLLink(talker: talker);
  final httpLink = HttpLink('https://api.example.com/graphql');

  final link = Link.from([talkerLink, httpLink]);

  final client = GraphQLClient(
    link: link,
    cache: GraphQLCache(store: HiveStore()),
  );
}
```

## Customization

### Settings

```dart
final talkerLink = TalkerGraphQLLink(
  talker: talker,
  settings: TalkerGraphQLLoggerSettings(
    // Enable/disable logging
    enabled: true,

    // Log level for GraphQL logs
    logLevel: LogLevel.debug,

    // Print variables in request logs
    printVariables: true,

    // Print response data
    printResponse: true,

    // Print GraphQL query string (can be large)
    printQuery: false,

    // Maximum length of response data to print
    responseMaxLength: 2000,

    // Fields to obfuscate in variables
    obfuscateFields: {'password', 'token', 'apiKey'},

    // Custom colors for different log types
    requestPen: AnsiPen()..xterm(219),
    responsePen: AnsiPen()..xterm(46),
    errorPen: AnsiPen()..red(),
    subscriptionPen: AnsiPen()..cyan(),
  ),
);
```

### Filtering

```dart
final talkerLink = TalkerGraphQLLink(
  talker: talker,
  settings: TalkerGraphQLLoggerSettings(
    // Filter which requests to log
    requestFilter: (request) {
      // Don't log introspection queries
      final operationName = request.operation.operationName;
      return operationName != 'IntrospectionQuery';
    },

    // Filter which responses to log
    responseFilter: (request, response) {
      return true; // Log all responses
    },

    // Filter which errors to log
    errorFilter: (request, response, error) {
      return true; // Log all errors
    },
  ),
);
```

## Features

- ✅ Logs queries, mutations, and subscriptions
- ✅ Request/response duration tracking
- ✅ Variable obfuscation for sensitive data
- ✅ Customizable log colors
- ✅ Request/response/error filtering
- ✅ Truncation for large responses
- ✅ GraphQL error details with path and locations
- ✅ Network error handling

## Log Types

The logger creates the following log types:

| Log Type | TalkerKey | Description |
|----------|-----------|-------------|
| `GraphQLRequestLog` | `graphql-request` | Outgoing GraphQL request |
| `GraphQLResponseLog` | `graphql-response` | Successful response |
| `GraphQLErrorLog` | `graphql-error` | GraphQL or network errors |
| `GraphQLSubscriptionLog` | `graphql-subscription` | Subscription events |

## Integration with TalkerFlutter

Use with [talker_flutter](https://pub.dev/packages/talker_flutter) to view logs in a beautiful UI:

```dart
import 'package:talker_flutter/talker_flutter.dart';

// Navigate to logs screen
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

## Additional information

- [Talker documentation](https://github.com/Frezyx/talker)
- [GraphQL package](https://pub.dev/packages/graphql)
- [GQL packages](https://pub.dev/packages/gql)

For issues and feature requests, please visit the [GitHub repository](https://github.com/Frezyx/talker/issues).
