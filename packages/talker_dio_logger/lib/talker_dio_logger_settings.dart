import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

/// [TalkerDioLogger] settings and customization
class TalkerDioLoggerSettings {
  const TalkerDioLoggerSettings({
    this.enabled = true,
    this.logLevel = LogLevel.debug,
    this.printResponseData = true,
    this.printResponseHeaders = false,
    this.printResponseMessage = true,
    this.printResponseRedirects = false,
    this.printResponseTime = false,
    this.printErrorData = true,
    this.printErrorHeaders = true,
    this.printErrorMessage = true,
    this.printRequestData = true,
    this.printRequestHeaders = false,
    this.printRequestExtra = false,
    this.hiddenHeaders = const <String>{},
    this.stripJsonQuotes = false,
    this.prettyFormatter,
    this.responseDataConverter,
    this.requestPen,
    this.responsePen,
    this.errorPen,
    this.requestFilter,
    this.responseFilter,
    this.errorFilter,
  });

  // Print Dio logger if true
  final bool enabled;

  // LogLevel of all dio logs. By default set as debug
  final LogLevel logLevel;

  /// Print [response.data] if true
  final bool printResponseData;

  /// Print [response.headers] if true
  final bool printResponseHeaders;

  /// Print [response.statusMessage] if true
  final bool printResponseMessage;

  /// Print [response.redirects] if true
  final bool printResponseRedirects;

  /// Print response time if true
  final bool printResponseTime;

  /// Print [error.response.data] if true
  final bool printErrorData;

  /// Print [error.response.headers] if true
  final bool printErrorHeaders;

  /// Print [error.message] if true
  final bool printErrorMessage;

  /// Print [request.data] if true
  final bool printRequestData;

  /// Print [request.headers] if true
  final bool printRequestHeaders;

  /// Print [request.extra] if true
  final bool printRequestExtra;

  /// Field to set custom http request console logs color
  ///```
  ///// Red color
  ///final redPen = AnsiPen()..red();
  ///
  ///// Blue color
  ///final redPen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs
  final AnsiPen? requestPen;

  /// Field to set custom http response console logs color
  ///```
  ///// Red color
  ///final redPen = AnsiPen()..red();
  ///
  ///// Blue color
  ///final redPen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs
  final AnsiPen? responsePen;

  /// Field to set custom http error console logs color
  ///```
  ///// Red color
  ///final redPen = AnsiPen()..red();
  ///
  ///// Blue color
  ///final redPen = AnsiPen()..blue();
  ///```
  /// More details in [AnsiPen] docs
  final AnsiPen? errorPen;

  /// For request filtering.
  /// You can add your custom logic to log only specific HTTP requests [RequestOptions].
  final bool Function(RequestOptions requestOptions)? requestFilter;

  /// For response filtering.
  /// You can add your custom logic to log only specific HTTP responses [Response].
  final bool Function(Response response)? responseFilter;

  /// Strip double quotes from JSON output.
  /// Only applies when using default encoder (no prettyFormatter is set).
  final bool stripJsonQuotes;

  /// Custom formatter for converting data to pretty string.
  /// If null, uses default JsonEncoder with indent.
  final String Function(dynamic data)? prettyFormatter;

  /// Response data converter.
  final String Function(Response response)? responseDataConverter;

  /// For error filtering.
  /// You can add your custom logic to log only specific Dio error [DioException].
  final bool Function(DioException response)? errorFilter;

  /// Header values for the specified keys in the Set will be replaced with *****.
  /// Case insensitive
  final Set<String> hiddenHeaders;

  TalkerDioLoggerSettings copyWith({
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printResponseTime,
    bool? printErrorData,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    bool? printRequestExtra,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    bool Function(RequestOptions requestOptions)? requestFilter,
    bool Function(Response response)? responseFilter,
    bool? stripJsonQuotes,
    String Function(dynamic data)? prettyFormatter,
    String Function(Response response)? responseDataConverter,
    bool Function(DioException response)? errorFilter,
    Set<String>? hiddenHeaders,
    LogLevel? logLevel,
  }) {
    return TalkerDioLoggerSettings(
      printResponseData: printResponseData ?? this.printResponseData,
      printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
      printResponseMessage: printResponseMessage ?? this.printResponseMessage,
      printResponseTime: printResponseTime ?? this.printResponseTime,
      printErrorData: printErrorData ?? this.printErrorData,
      printErrorHeaders: printErrorHeaders ?? this.printErrorHeaders,
      printErrorMessage: printErrorMessage ?? this.printErrorMessage,
      printRequestData: printRequestData ?? this.printRequestData,
      printRequestHeaders: printRequestHeaders ?? this.printRequestHeaders,
      printRequestExtra: printRequestExtra ?? this.printRequestExtra,
      requestPen: requestPen ?? this.requestPen,
      responsePen: responsePen ?? this.responsePen,
      errorPen: errorPen ?? this.errorPen,
      requestFilter: requestFilter ?? this.requestFilter,
      responseFilter: responseFilter ?? this.responseFilter,
      stripJsonQuotes: stripJsonQuotes ?? this.stripJsonQuotes,
      prettyFormatter: prettyFormatter ?? this.prettyFormatter,
      responseDataConverter:
          responseDataConverter ?? this.responseDataConverter,
      errorFilter: errorFilter ?? this.errorFilter,
      hiddenHeaders: hiddenHeaders ?? this.hiddenHeaders,
      logLevel: logLevel ?? this.logLevel,
    );
  }
}
