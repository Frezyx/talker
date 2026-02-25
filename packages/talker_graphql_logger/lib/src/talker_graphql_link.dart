import 'dart:async';

import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:talker/talker.dart';

import 'graphql_logs.dart';
import 'talker_graphql_logger_settings.dart';

/// {@template talker_graphql_link}
/// A GraphQL [Link] implementation that logs GraphQL operations
/// using the [Talker] logger.
///
/// This link captures:
/// - Request data (operation name, type, variables)
/// - Response data (with duration)
/// - GraphQL errors and network errors
/// - Subscription events
///
/// Example usage:
/// ```dart
/// final talker = Talker();
///
/// final link = Link.from([
///   TalkerGraphQLLink(talker: talker),
///   authLink,
///   HttpLink('https://api.example.com/graphql'),
/// ]);
///
/// final client = GraphQLClient(
///   link: link,
///   cache: GraphQLCache(),
/// );
/// ```
/// {@endtemplate}
class TalkerGraphQLLink extends Link {
  /// {@macro talker_graphql_link}
  ///
  /// If a [talker] instance is not provided, a default one will be created.
  TalkerGraphQLLink({
    Talker? talker,
    this.settings = const TalkerGraphQLLoggerSettings(),
  }) {
    _talker = talker ?? Talker();
    _talker.settings.registerKeys(const [
      TalkerKey.graphqlRequest,
      TalkerKey.graphqlResponse,
      TalkerKey.graphqlError,
      TalkerKey.graphqlSubscription,
    ]);
  }

  late final Talker _talker;

  /// [TalkerGraphQLLink] settings and customization.
  final TalkerGraphQLLoggerSettings settings;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    if (!settings.enabled) {
      return forward!(request);
    }

    // Check request filter
    final accepted = settings.requestFilter?.call(request) ?? true;
    if (!accepted) {
      return forward!(request);
    }

    final isSubscription = _isSubscription(request);

    if (isSubscription) {
      return _handleSubscription(request, forward!);
    } else {
      return _handleOperation(request, forward!);
    }
  }

  /// Checks if the request is a subscription.
  bool _isSubscription(Request request) {
    final definitions = request.operation.document.definitions;
    for (final definition in definitions) {
      if (definition is OperationDefinitionNode) {
        return definition.type == OperationType.subscription;
      }
    }
    return false;
  }

  /// Handles regular query/mutation operations.
  Stream<Response> _handleOperation(Request request, NextLink forward) async* {
    final startTime = DateTime.now();

    // Log request
    try {
      _talker.logCustom(
        GraphQLRequestLog(
          _getOperationName(request),
          request: request,
          settings: settings,
        ),
      );
    } catch (_) {
      // Ignore logging errors
    }

    try {
      await for (final response in forward(request)) {
        final durationMs = DateTime.now().difference(startTime).inMilliseconds;

        // Check if response has errors
        final hasErrors =
            response.errors != null && response.errors!.isNotEmpty;

        if (hasErrors) {
          // Check error filter
          final errorAccepted =
              settings.errorFilter?.call(request, response, null) ?? true;
          if (errorAccepted) {
            try {
              _talker.logCustom(
                GraphQLErrorLog(
                  _getOperationName(request),
                  request: request,
                  response: response,
                  durationMs: durationMs,
                  settings: settings,
                ),
              );
            } catch (_) {
              // Ignore logging errors
            }
          }
        } else {
          // Check response filter
          final responseAccepted =
              settings.responseFilter?.call(request, response) ?? true;
          if (responseAccepted) {
            try {
              _talker.logCustom(
                GraphQLResponseLog(
                  _getOperationName(request),
                  request: request,
                  response: response,
                  durationMs: durationMs,
                  settings: settings,
                ),
              );
            } catch (_) {
              // Ignore logging errors
            }
          }
        }

        yield response;
      }
    } catch (e) {
      final durationMs = DateTime.now().difference(startTime).inMilliseconds;

      // Check error filter
      final errorAccepted =
          settings.errorFilter?.call(request, null, e) ?? true;
      if (errorAccepted) {
        try {
          _talker.logCustom(
            GraphQLErrorLog(
              _getOperationName(request),
              request: request,
              linkException: e,
              durationMs: durationMs,
              settings: settings,
            ),
          );
        } catch (_) {
          // Ignore logging errors
        }
      }

      rethrow;
    }
  }

  /// Handles subscription operations.
  Stream<Response> _handleSubscription(
    Request request,
    NextLink forward,
  ) async* {
    // Log subscription start
    try {
      _talker.logCustom(
        GraphQLRequestLog(
          _getOperationName(request),
          request: request,
          settings: settings,
        ),
      );
    } catch (_) {
      // Ignore logging errors
    }

    try {
      await for (final response in forward(request)) {
        final hasErrors =
            response.errors != null && response.errors!.isNotEmpty;

        if (hasErrors) {
          try {
            _talker.logCustom(
              GraphQLSubscriptionLog(
                _getOperationName(request),
                request: request,
                response: response,
                eventType: GraphQLSubscriptionEventType.error,
                settings: settings,
              ),
            );
          } catch (_) {
            // Ignore logging errors
          }
        } else {
          try {
            _talker.logCustom(
              GraphQLSubscriptionLog(
                _getOperationName(request),
                request: request,
                response: response,
                eventType: GraphQLSubscriptionEventType.data,
                settings: settings,
              ),
            );
          } catch (_) {
            // Ignore logging errors
          }
        }

        yield response;
      }

      // Log subscription done
      try {
        _talker.logCustom(
          GraphQLSubscriptionLog(
            _getOperationName(request),
            request: request,
            eventType: GraphQLSubscriptionEventType.done,
            settings: settings,
          ),
        );
      } catch (_) {
        // Ignore logging errors
      }
    } catch (e) {
      // Log subscription error
      try {
        _talker.logCustom(
          GraphQLErrorLog(
            _getOperationName(request),
            request: request,
            linkException: e,
            durationMs: 0,
            settings: settings,
          ),
        );
      } catch (_) {
        // Ignore logging errors
      }

      rethrow;
    }
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
}
