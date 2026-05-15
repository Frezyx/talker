import 'package:gql_exec/gql_exec.dart';
import 'package:talker/talker.dart';

/// Callback for filtering GraphQL requests.
typedef GraphQLRequestFilter = bool Function(Request request);

/// Callback for filtering GraphQL responses.
typedef GraphQLResponseFilter =
    bool Function(Request request, Response response);

/// Callback for filtering GraphQL errors.
typedef GraphQLErrorFilter =
    bool Function(Request request, Response? response, Object? error);

/// [TalkerGraphQLLink] settings and customization.
class TalkerGraphQLLoggerSettings {
  const TalkerGraphQLLoggerSettings({
    this.enabled = true,
    this.logLevel = LogLevel.debug,
    this.printVariables = true,
    this.printResponse = true,
    this.printQuery = false,
    this.responseMaxLength = 2000,
    this.obfuscateFields = const <String>{},
    this.requestPen,
    this.responsePen,
    this.errorPen,
    this.subscriptionPen,
    this.requestFilter,
    this.responseFilter,
    this.errorFilter,
  });

  /// Print GraphQL logger if true.
  final bool enabled;

  /// LogLevel of all GraphQL logs. By default set as debug.
  final LogLevel logLevel;

  /// Print variables in request log if true.
  final bool printVariables;

  /// Print response data if true.
  final bool printResponse;

  /// Print GraphQL query string if true.
  /// Note: Query strings can be large, so this is disabled by default.
  final bool printQuery;

  /// Maximum length of response data to print.
  /// Data longer than this will be truncated.
  final int responseMaxLength;

  /// Set of field names to obfuscate in variables.
  /// Values of these fields will be replaced with '*****'.
  /// Case-insensitive comparison.
  final Set<String> obfuscateFields;

  /// Field to set custom GraphQL request console logs color.
  ///```dart
  /// // Violet color
  /// final violetPen = AnsiPen()..xterm(219);
  ///
  /// // Blue color
  /// final bluePen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs.
  final AnsiPen? requestPen;

  /// Field to set custom GraphQL response console logs color.
  ///```dart
  /// // Green color
  /// final greenPen = AnsiPen()..xterm(46);
  ///
  /// // Blue color
  /// final bluePen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs.
  final AnsiPen? responsePen;

  /// Field to set custom GraphQL error console logs color.
  ///```dart
  /// // Red color
  /// final redPen = AnsiPen()..red();
  ///
  /// // Blue color
  /// final bluePen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs.
  final AnsiPen? errorPen;

  /// Field to set custom GraphQL subscription console logs color.
  ///```dart
  /// // Cyan color
  /// final cyanPen = AnsiPen()..cyan();
  ///```
  /// More details in [AnsiPen] docs.
  final AnsiPen? subscriptionPen;

  /// For request filtering.
  /// You can add your custom logic to log only specific GraphQL requests.
  final GraphQLRequestFilter? requestFilter;

  /// For response filtering.
  /// You can add your custom logic to log only specific GraphQL responses.
  final GraphQLResponseFilter? responseFilter;

  /// For error filtering.
  /// You can add your custom logic to log only specific GraphQL errors.
  final GraphQLErrorFilter? errorFilter;

  /// Creates a copy of this settings with the given fields replaced.
  TalkerGraphQLLoggerSettings copyWith({
    bool? enabled,
    LogLevel? logLevel,
    bool? printVariables,
    bool? printResponse,
    bool? printQuery,
    int? responseMaxLength,
    Set<String>? obfuscateFields,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    AnsiPen? subscriptionPen,
    GraphQLRequestFilter? requestFilter,
    GraphQLResponseFilter? responseFilter,
    GraphQLErrorFilter? errorFilter,
  }) {
    return TalkerGraphQLLoggerSettings(
      enabled: enabled ?? this.enabled,
      logLevel: logLevel ?? this.logLevel,
      printVariables: printVariables ?? this.printVariables,
      printResponse: printResponse ?? this.printResponse,
      printQuery: printQuery ?? this.printQuery,
      responseMaxLength: responseMaxLength ?? this.responseMaxLength,
      obfuscateFields: obfuscateFields ?? this.obfuscateFields,
      requestPen: requestPen ?? this.requestPen,
      responsePen: responsePen ?? this.responsePen,
      errorPen: errorPen ?? this.errorPen,
      subscriptionPen: subscriptionPen ?? this.subscriptionPen,
      requestFilter: requestFilter ?? this.requestFilter,
      responseFilter: responseFilter ?? this.responseFilter,
      errorFilter: errorFilter ?? this.errorFilter,
    );
  }
}
