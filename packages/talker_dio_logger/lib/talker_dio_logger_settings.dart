import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

/// [TalkerDioLogger] settings and customization
class TalkerDioLoggerSettings {
  const TalkerDioLoggerSettings({
    this.printResponseData = true,
    this.printResponseHeaders = false,
    this.printResponseMessage = true,
    this.printRequestData = true,
    this.printRequestHeaders = false,
    this.requestPen,
    this.responsePen,
    this.errorPen,
    this.requestFilter,
    this.responseFilter,
  });

  /// Print [response.data] if true
  final bool printResponseData;

  /// Print [response.headers] if true
  final bool printResponseHeaders;

  /// Print [response.statusMessage] if true
  final bool printResponseMessage;

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
  /// You can add your custom logic to log only specific HTTP requests [RequestOptions].
  final bool Function(RequestOptions requestOptions)? requestFilter;

  /// For response filtering.
  /// You can add your custom logic to log only specific HTTP responses [Response].
  final bool Function(Response response)? responseFilter;

  TalkerDioLoggerSettings copyWith({
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    bool Function(RequestOptions requestOptions)? requestFilter,
    bool Function(Response response)? responseFilter,
  }) {
    return TalkerDioLoggerSettings(
      printResponseData: printResponseData ?? this.printResponseData,
      printResponseHeaders: printResponseHeaders ?? this.printResponseHeaders,
      printResponseMessage: printResponseMessage ?? this.printResponseMessage,
      printRequestData: printRequestData ?? this.printRequestData,
      printRequestHeaders: printRequestHeaders ?? this.printRequestHeaders,
      requestPen: requestPen ?? this.requestPen,
      responsePen: responsePen ?? this.responsePen,
      errorPen: errorPen ?? this.errorPen,
      requestFilter: requestFilter ?? this.requestFilter,
      responseFilter: responseFilter ?? this.responseFilter,
    );
  }
}
