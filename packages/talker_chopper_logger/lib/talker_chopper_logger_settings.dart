import 'package:chopper/chopper.dart' show Response, Request;
import 'package:equatable/equatable.dart';
import 'package:talker/talker.dart' show AnsiPen;

typedef RequestFilter = bool Function(Request request);
typedef ResponseFilter = bool Function(Response response);

class TalkerChopperLoggerSettings with EquatableMixin {
  const TalkerChopperLoggerSettings({
    this.enabled = true,
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
    this.hiddenHeaders = const <String>{},
    this.requestPen,
    this.responsePen,
    this.errorPen,
    this.requestFilter,
    this.responseFilter,
    this.errorFilter,
  });

  /// Print Chopper logger if true
  final bool enabled;

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
  /// You can add your custom logic to log only specific HTTP requests [Request].
  final RequestFilter? requestFilter;

  /// For response filtering.
  /// You can add your custom logic to log only specific HTTP responses [Response].
  final ResponseFilter? responseFilter;

  /// For error filtering.
  /// You can add your custom logic to log only specific Chopper error [Response].
  final ResponseFilter? errorFilter;

  /// Header values for the specified keys in the Set will be replaced with *****.
  /// Case insensitive
  final Set<String> hiddenHeaders;

  TalkerChopperLoggerSettings copyWith({
    bool? enabled,
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printResponseTime,
    bool? printErrorData,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    RequestFilter? requestFilter,
    ResponseFilter? responseFilter,
    ResponseFilter? errorFilter,
    Set<String>? hiddenHeaders,
  }) =>
      TalkerChopperLoggerSettings(
        enabled: enabled ?? this.enabled,
        printResponseData: printResponseData ?? this.printResponseData,
        printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
        printResponseMessage: printResponseMessage ?? this.printResponseMessage,
        printResponseTime: printResponseTime ?? this.printResponseTime,
        printErrorData: printErrorData ?? this.printErrorData,
        printErrorHeaders: printErrorHeaders ?? this.printErrorHeaders,
        printErrorMessage: printErrorMessage ?? this.printErrorMessage,
        printRequestData: printRequestData ?? this.printRequestData,
        printRequestHeaders: printRequestHeaders ?? this.printRequestHeaders,
        requestPen: requestPen ?? this.requestPen,
        responsePen: responsePen ?? this.responsePen,
        errorPen: errorPen ?? this.errorPen,
        requestFilter: requestFilter ?? this.requestFilter,
        responseFilter: responseFilter ?? this.responseFilter,
        errorFilter: errorFilter ?? this.errorFilter,
        hiddenHeaders: hiddenHeaders ?? this.hiddenHeaders,
      );

  @override
  List<Object?> get props => [
        enabled,
        printResponseData,
        printResponseHeaders,
        printResponseMessage,
        printResponseTime,
        printErrorData,
        printErrorHeaders,
        printErrorMessage,
        printRequestData,
        printRequestHeaders,
        requestPen,
        responsePen,
        errorPen,
        requestFilter,
        responseFilter,
        errorFilter,
        hiddenHeaders,
      ];
}
