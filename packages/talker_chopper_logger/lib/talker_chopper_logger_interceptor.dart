import 'package:chopper/chopper.dart'
    show Chain, ChopperException, Interceptor, Request, Response;
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

  static const String kChopperLogsTimeStampKey = '_talker_chopper_logger_ts_';

  late Talker _talker;

  /// [TalkerChopperLogger] settings and customization
  TalkerChopperLoggerSettings settings;

  /// Talker addon functionality
  /// addon id for create a lot of addons
  final String? addonId;

  /// Method to update [settings] of [TalkerChopperLogger]
  void configure({
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
    bool Function(Request)? requestFilter,
    bool Function(Response)? responseFilter,
    bool Function(Response)? errorFilter,
    Set<String>? hiddenHeaders,
  }) {
    settings = settings.copyWith(
      enabled: enabled ?? settings.enabled,
      printRequestData: printRequestData ?? settings.printRequestData,
      printRequestHeaders: printRequestHeaders ?? settings.printRequestHeaders,
      printResponseData: printResponseData ?? settings.printResponseData,
      printErrorData: printErrorData ?? settings.printErrorData,
      printErrorHeaders: printErrorHeaders ?? settings.printErrorHeaders,
      printErrorMessage: printErrorMessage ?? settings.printErrorMessage,
      printResponseHeaders:
          printResponseHeaders ?? settings.printResponseHeaders,
      printResponseMessage:
          printResponseMessage ?? settings.printResponseMessage,
      requestPen: requestPen ?? settings.requestPen,
      responsePen: responsePen ?? settings.responsePen,
      errorPen: errorPen ?? settings.errorPen,
      requestFilter: requestFilter ?? settings.requestFilter,
      responseFilter: responseFilter ?? settings.responseFilter,
      errorFilter: errorFilter ?? settings.errorFilter,
      hiddenHeaders: hiddenHeaders ?? settings.hiddenHeaders,
      printResponseTime: printResponseTime ?? settings.printResponseTime,
    );
  }

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final Stopwatch stopWatch = Stopwatch();

    try {
      final Request request = chain.request;

      if (settings.enabled && (settings.requestFilter?.call(request) ?? true)) {
        try {
          _talker.logCustom(
            ChopperRequestLog(
              request.url.toString(),
              request: await request.toBaseRequest(),
              settings: settings,
            ),
          );
        } catch (_) {}
      }

      stopWatch.start();

      final Response<BodyType> response = await chain.proceed(request);

      stopWatch.stop();

      if (response.statusCode < 400) {
        if (settings.enabled &&
            (settings.responseFilter?.call(response) ?? true)) {
          try {
            _talker.logCustom(
              ChopperResponseLog<BodyType>(
                response.base.request?.url.toString() ?? request.url.toString(),
                settings: settings,
                response: response,
                responseTime: stopWatch.elapsedMilliseconds,
              ),
            );
          } catch (_) {}
        }
      } else {
        if (settings.enabled &&
            (settings.errorFilter?.call(response) ?? true)) {
          try {
            _talker.logCustom(
              ChopperErrorLog<BodyType>(
                response.base.request?.url.toString() ?? request.url.toString(),
                settings: settings,
                chopperException: ChopperException(
                  response.error.toString(),
                  request: request,
                  response: response,
                ),
                responseTime: stopWatch.elapsedMilliseconds,
              ),
            );
          } catch (_) {}
        }
      }

      return response;
    } on ChopperException catch (error) {
      if (settings.enabled &&
          error.response != null &&
          (settings.errorFilter?.call(error.response!) ?? true)) {
        try {
          _talker.logCustom(
            ChopperErrorLog<BodyType>(
              error.response!.base.request?.url.toString() ??
                  error.request?.url.toString() ??
                  error.message,
              settings: settings,
              chopperException: error,
            ),
          );
        } catch (_) {}
      }

      rethrow;
    } catch (err) {
      if (settings.enabled) {
        try {
          _talker.error(err.toString(), err);
        } catch (_) {}
      }

      rethrow;
    } finally {
      if (stopWatch.isRunning) {
        stopWatch.stop();
      }
    }
  }
}
