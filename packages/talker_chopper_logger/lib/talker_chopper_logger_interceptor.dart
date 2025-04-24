import 'package:chopper/chopper.dart'
    show
        Chain,
        ChopperException,
        ChopperHttpException,
        Interceptor,
        Request,
        Response;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';

import 'chopper_logs.dart';

// ignore: must_be_immutable
class TalkerChopperLogger implements Interceptor {
  TalkerChopperLogger({
    Talker? talker,
    this.settings = const TalkerChopperLoggerSettings(),
    this.addonId,
  }) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;

  /// [TalkerChopperLogger] settings and customization
  TalkerChopperLoggerSettings settings;

  /// Talker addon functionality
  /// addon id for create a lot of addons
  final String? addonId;

  /// Method to update [settings] of [TalkerChopperLogger]
  void configure({
    bool? enabled,
    LogLevel? logLevel,
    bool? printResponseData,
    bool? printResponseHeaders,
    bool? printResponseMessage,
    bool? printResponseTime,
    bool? printErrorData,
    bool? printErrorHeaders,
    bool? printErrorMessage,
    bool? printRequestData,
    bool? printRequestHeaders,
    bool? printRequestCurl,
    AnsiPen? requestPen,
    AnsiPen? responsePen,
    AnsiPen? errorPen,
    RequestFilter? requestFilter,
    ResponseFilter? responseFilter,
    ResponseFilter? errorFilter,
    Set<String>? hiddenHeaders,
  }) =>
      settings = settings.copyWith(
        enabled: enabled,
        logLevel: logLevel,
        printRequestData: printRequestData,
        printRequestHeaders: printRequestHeaders,
        printRequestCurl: printRequestCurl,
        printResponseData: printResponseData,
        printErrorData: printErrorData,
        printErrorHeaders: printErrorHeaders,
        printErrorMessage: printErrorMessage,
        printResponseHeaders: printResponseHeaders,
        printResponseMessage: printResponseMessage,
        requestPen: requestPen,
        responsePen: responsePen,
        errorPen: errorPen,
        requestFilter: requestFilter,
        responseFilter: responseFilter,
        errorFilter: errorFilter,
        hiddenHeaders: hiddenHeaders,
        printResponseTime: printResponseTime,
      );

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final Stopwatch stopWatch = Stopwatch();

    try {
      final Request request = chain.request;

      if (settings.enabled && (settings.requestFilter?.call(request) ?? true)) {
        _talker.logCustom(
          ChopperRequestLog(
            request.url.toString(),
            request: await request.toBaseRequest(),
            settings: settings,
          ),
        );
      }

      stopWatch.start();

      final Response<BodyType> response = await chain.proceed(request);

      stopWatch.stop();

      if (response.statusCode < 400) {
        if (settings.enabled &&
            (settings.responseFilter?.call(response) ?? true)) {
          _talker.logCustom(
            ChopperResponseLog<BodyType>(
              response.base.request?.url.toString() ?? request.url.toString(),
              settings: settings,
              request: request,
              response: response,
              responseTime: stopWatch.elapsedMilliseconds,
            ),
          );
        }
      } else {
        if (settings.enabled &&
            (settings.errorFilter?.call(response) ?? true)) {
          _talker.logCustom(
            ChopperErrorLog<BodyType>(
              response.error?.toString() ?? 'HTTP Error ${response.statusCode}',
              settings: settings,
              request: request,
              exception: ChopperException(
                response.error.toString(),
                request: request,
                response: response,
              ),
              responseTime: stopWatch.elapsedMilliseconds,
            ),
          );
        }
      }

      return response;
    } catch (exception, stackTrace) {
      switch (exception) {
        case ChopperHttpException ex when settings.enabled:
          if (settings.errorFilter?.call(ex.response) ?? true) {
            _talker.logCustom(
              ChopperErrorLog<BodyType>(
                ex.toString(),
                settings: settings,
                exception: ex,
                stackTrace: stackTrace,
              ),
            );
          }
          break;
        case ChopperException ex when settings.enabled:
          if (ex.response != null &&
              (settings.errorFilter?.call(ex.response!) ?? true)) {
            _talker.logCustom(
              ChopperErrorLog<BodyType>(
                ex.message,
                settings: settings,
                exception: ex,
                stackTrace: stackTrace,
              ),
            );
          }
          break;
        case _ when settings.enabled:
          _talker.error(exception.toString(), exception, stackTrace);
          break;
      }

      rethrow;
    } finally {
      if (stopWatch.isRunning) {
        stopWatch.stop();
      }
    }
  }
}
