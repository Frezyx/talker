import 'dart:convert';

import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:talker/talker.dart';

import 'talker_graphql_logger_settings.dart';

const _encoder = JsonEncoder.withIndent('  ');
const _obfuscatedValue = '*****';

/// Returns the operation type from the request.
String _getOperationType(Request request) {
  final definitions = request.operation.document.definitions;
  for (final definition in definitions) {
    if (definition is OperationDefinitionNode) {
      switch (definition.type) {
        case OperationType.query:
          return 'Query';
        case OperationType.mutation:
          return 'Mutation';
        case OperationType.subscription:
          return 'Subscription';
      }
    }
  }
  return 'Unknown';
}

/// Returns the operation name from the request.
String _getOperationName(Request request) {
  final operationName = request.operation.operationName;
  if (operationName != null && operationName.isNotEmpty) {
    return operationName;
  }

  final definitions = request.operation.document.definitions;
  for (final definition in definitions) {
    if (definition is OperationDefinitionNode) {
      final name = definition.name?.value;
      if (name != null) return name;
    }
  }
  return 'Anonymous';
}

/// Obfuscates sensitive fields in the variables map.
Map<String, dynamic> _obfuscateVariables(
  Map<String, dynamic> variables,
  Set<String> obfuscateFields,
) {
  if (obfuscateFields.isEmpty) return variables;

  final result = <String, dynamic>{};
  final lowerCaseFields = obfuscateFields.map((f) => f.toLowerCase()).toSet();

  for (final entry in variables.entries) {
    if (lowerCaseFields.contains(entry.key.toLowerCase())) {
      result[entry.key] = _obfuscatedValue;
    } else if (entry.value is Map<String, dynamic>) {
      result[entry.key] = _obfuscateVariables(
        entry.value as Map<String, dynamic>,
        obfuscateFields,
      );
    } else {
      result[entry.key] = entry.value;
    }
  }

  return result;
}

/// {@template graphql_request_log}
/// A [TalkerLog] implementation that logs outgoing GraphQL request data.
///
/// Includes:
/// - Operation name
/// - Operation type (Query/Mutation/Subscription)
/// - Variables (with optional obfuscation)
/// - Query string (optional)
/// {@endtemplate}
class GraphQLRequestLog extends TalkerLog {
  /// {@macro graphql_request_log}
  GraphQLRequestLog(
    super.message, {
    required this.request,
    required this.settings,
  });

  /// The GraphQL request being logged.
  final Request request;

  /// Logger settings.
  final TalkerGraphQLLoggerSettings settings;

  @override
  AnsiPen get pen => settings.requestPen ?? (AnsiPen()..xterm(219));

  @override
  String get key => TalkerKey.graphqlRequest;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final operationType = _getOperationType(request);
    final operationName = _getOperationName(request);

    var msg = '[$title] [$operationType] $operationName';

    try {
      final variables = request.variables;
      if (settings.printVariables && variables.isNotEmpty) {
        final obfuscated = _obfuscateVariables(
          variables,
          settings.obfuscateFields,
        );
        final prettyVariables = _encoder.convert(obfuscated);
        msg += '\nVariables: $prettyVariables';
      }

      if (settings.printQuery) {
        final query = request.operation.document.toString();
        msg += '\nQuery: $query';
      }
    } catch (_) {
      // Ignore encoding errors
    }

    return msg;
  }
}

/// {@template graphql_response_log}
/// A [TalkerLog] implementation that logs successful GraphQL responses.
///
/// Includes:
/// - Operation name
/// - Operation type
/// - Duration
/// - Response data (optional, with length limit)
/// {@endtemplate}
class GraphQLResponseLog extends TalkerLog {
  /// {@macro graphql_response_log}
  GraphQLResponseLog(
    super.message, {
    required this.request,
    required this.response,
    required this.durationMs,
    required this.settings,
  });

  /// The original GraphQL request.
  final Request request;

  /// The GraphQL response.
  final Response response;

  /// Duration of the request in milliseconds.
  final int durationMs;

  /// Logger settings.
  final TalkerGraphQLLoggerSettings settings;

  @override
  AnsiPen get pen => settings.responsePen ?? (AnsiPen()..xterm(46));

  @override
  String get key => TalkerKey.graphqlResponse;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final operationType = _getOperationType(request);
    final operationName = _getOperationName(request);

    var msg = '[$title] [$operationType] $operationName';
    msg += '\nDuration: $durationMs ms';

    try {
      final data = response.data;
      if (settings.printResponse && data != null) {
        var prettyData = _encoder.convert(data);
        if (prettyData.length > settings.responseMaxLength) {
          prettyData =
              '${prettyData.substring(0, settings.responseMaxLength)}... [truncated]';
        }
        msg += '\nData: $prettyData';
      }
    } catch (_) {
      // Ignore encoding errors
    }

    return msg;
  }
}

/// {@template graphql_error_log}
/// A [TalkerLog] implementation that logs GraphQL errors.
///
/// Includes:
/// - Operation name
/// - Operation type
/// - Duration
/// - GraphQL errors (from response.errors)
/// - Link exception (network errors)
/// - Variables (for debugging)
/// {@endtemplate}
class GraphQLErrorLog extends TalkerLog {
  /// {@macro graphql_error_log}
  GraphQLErrorLog(
    super.message, {
    required this.request,
    this.response,
    this.linkException,
    required this.durationMs,
    required this.settings,
  });

  /// The original GraphQL request.
  final Request request;

  /// The GraphQL response (may be null for network errors).
  final Response? response;

  /// The link exception (for network errors).
  final Object? linkException;

  /// Duration of the request in milliseconds.
  final int durationMs;

  /// Logger settings.
  final TalkerGraphQLLoggerSettings settings;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerKey.graphqlError;

  @override
  LogLevel get logLevel => LogLevel.error;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final operationType = _getOperationType(request);
    final operationName = _getOperationName(request);

    var msg = '[$title] [$operationType] $operationName';
    msg += '\nDuration: $durationMs ms';

    // Log GraphQL errors
    final errors = response?.errors;
    if (errors != null && errors.isNotEmpty) {
      msg += '\nGraphQL Errors:';
      for (final error in errors) {
        msg += '\n  - ${error.message}';
        final locations = error.locations;
        if (locations != null && locations.isNotEmpty) {
          final loc = locations.first;
          msg += ' (line: ${loc.line}, column: ${loc.column})';
        }
        final path = error.path;
        if (path != null && path.isNotEmpty) {
          msg += '\n    Path: ${path.join(' > ')}';
        }
      }
    }

    // Log link exception
    if (linkException != null) {
      msg += '\nException: $linkException';
    }

    // Log variables for debugging
    try {
      final variables = request.variables;
      if (settings.printVariables && variables.isNotEmpty) {
        final obfuscated = _obfuscateVariables(
          variables,
          settings.obfuscateFields,
        );
        final prettyVariables = _encoder.convert(obfuscated);
        msg += '\nVariables: $prettyVariables';
      }
    } catch (_) {
      // Ignore encoding errors
    }

    return msg;
  }
}

/// {@template graphql_subscription_log}
/// A [TalkerLog] implementation that logs GraphQL subscription events.
///
/// Includes:
/// - Operation name
/// - Event type (data/error/done)
/// - Data preview (optional)
/// {@endtemplate}
class GraphQLSubscriptionLog extends TalkerLog {
  /// {@macro graphql_subscription_log}
  GraphQLSubscriptionLog(
    super.message, {
    required this.request,
    this.response,
    this.eventType = GraphQLSubscriptionEventType.data,
    required this.settings,
  });

  /// The original GraphQL request.
  final Request request;

  /// The GraphQL response (for data events).
  final Response? response;

  /// The type of subscription event.
  final GraphQLSubscriptionEventType eventType;

  /// Logger settings.
  final TalkerGraphQLLoggerSettings settings;

  @override
  AnsiPen get pen => settings.subscriptionPen ?? (AnsiPen()..cyan());

  @override
  String get key => TalkerKey.graphqlSubscription;

  @override
  LogLevel get logLevel => settings.logLevel;

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final operationName = _getOperationName(request);

    var msg = '[$title] [Subscription] $operationName';
    msg += '\nEvent: ${eventType.name}';

    try {
      final data = response?.data;
      if (settings.printResponse && data != null) {
        var prettyData = _encoder.convert(data);
        if (prettyData.length > settings.responseMaxLength) {
          prettyData =
              '${prettyData.substring(0, settings.responseMaxLength)}... [truncated]';
        }
        msg += '\nData: $prettyData';
      }
    } catch (_) {
      // Ignore encoding errors
    }

    return msg;
  }
}

/// Types of subscription events.
enum GraphQLSubscriptionEventType {
  /// New data received.
  data,

  /// Error occurred.
  error,

  /// Subscription completed.
  done,
}
