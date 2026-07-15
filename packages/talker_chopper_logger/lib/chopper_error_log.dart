import 'package:chopper/chopper.dart'
    show ChopperException, ChopperHttpException, Request;
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:talker/talker.dart';
import 'package:talker_chopper_logger/talker_chopper_logger_settings.dart';

class ChopperErrorLog<BodyType> extends TalkerLog {
  ChopperErrorLog(
    super.title, {
    this.request,
    required super.exception,
    required this.settings,
    this.responseTime = 0,
    super.stackTrace,
  });

  final Request? request;
  final TalkerChopperLoggerSettings settings;
  final int responseTime;

  @override
  AnsiPen get pen => settings.errorPen ?? (AnsiPen()..red());

  @override
  String get key => TalkerKey.httpError;

  @override
  LogLevel get logLevel => LogLevel.error;

  @visibleForTesting
  String convert(Object? object) => settings.jsonFormatter.format(object);

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final StringBuffer msg = StringBuffer();

    msg.write('[$title]');

    switch (exception) {
      case ChopperException chopperException:
        if (chopperException.response?.base.request?.method != null ||
            chopperException.request?.method != null) {
          msg.write(
            ' [${chopperException.response?.base.request?.method ?? chopperException.request?.method}]',
          );
        }
        if (chopperException.response?.base.request?.url != null ||
            chopperException.request?.url != null ||
            request?.url != null) {
          msg.write(
            ' ${chopperException.response?.base.request?.url ?? chopperException.request?.url ?? request?.url}',
          );
        }
        msg.writeln();

        final String responseMessage = chopperException.message;
        final int? statusCode = chopperException.response?.statusCode;
        final BodyType? body = chopperException.response?.body;
        final Map<String, String>? headers = chopperException.response?.headers;

        if (statusCode != null) {
          msg.writeln('Status: $statusCode');
        }

        if (settings.printResponseTime) {
          msg.writeln('Time: $responseTime ms');
        }

        if (settings.printErrorMessage &&
            responseMessage.isNotEmpty &&
            responseMessage != 'null') {
          msg.writeln('Message: $responseMessage');
        }

        if (settings.printErrorHeaders && (headers?.isNotEmpty ?? false)) {
          msg.writeln('Headers: ${convert(headers)}');
        }

        if (settings.printErrorData && body != null) {
          msg.writeln('Data: ${convert(body)}');
        }
        break;
      case ChopperHttpException chopperHttpException:
        if (chopperHttpException.response.base.request?.method != null) {
          msg.write(' [${chopperHttpException.response.base.request?.method}]');
        }
        if (chopperHttpException.response.base.request?.url != null ||
            request?.url != null) {
          msg.write(
            ' ${chopperHttpException.response.base.request?.url ?? request?.url}',
          );
        }
        msg.writeln();

        final BodyType? body = chopperHttpException.response.body;
        final Map<String, String> headers =
            chopperHttpException.response.headers;

        msg.writeln('Status: ${chopperHttpException.response.statusCode}');

        if (settings.printResponseTime) {
          msg.writeln('Time: $responseTime ms');
        }

        if (settings.printErrorHeaders && headers.isNotEmpty) {
          msg.writeln('Headers: ${convert(headers)}');
        }

        if (settings.printErrorData && body != null) {
          msg.writeln('Data: ${convert(body)}');
        }
        break;
      default:
        break;
    }

    return msg.toString().trimRight();
  }
}
