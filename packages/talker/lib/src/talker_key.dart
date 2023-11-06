import 'package:talker/talker.dart';

enum TalkerLogType {
  /// Logger level
  error('error'),
  critical('critical'),
  info('info'),
  debug('debug'),
  verbose('verbose'),
  warning('warning'),

  /// talker level
  exception('exception'),
  httpError('http-error'),
  httpRequest('http-request'),
  httpResponse('http-response'),
  blocEvent('bloc-event'),
  blocTransition('bloc-transition'),
  route('route');

  const TalkerLogType(this.key);
  final String key;
}

extension TalkerLogTypeExt on TalkerLogType {
  static TalkerLogType fromLogLevel(LogLevel logLevel) {
    return TalkerLogType.values.firstWhere((e) => e.logLevel == logLevel);
  }

  static TalkerLogType fromKey(String key) {
    return TalkerLogType.values.firstWhere((e) => e.key == key);
  }

  /// Mapping [TalkerLogType] into [LogLevel]
  LogLevel get logLevel {
    switch (this) {
      case TalkerLogType.error:
        return LogLevel.error;
      case TalkerLogType.critical:
        return LogLevel.critical;
      case TalkerLogType.info:
        return LogLevel.info;
      case TalkerLogType.debug:
        return LogLevel.debug;
      case TalkerLogType.verbose:
        return LogLevel.verbose;
      case TalkerLogType.warning:
        return LogLevel.warning;
      default:
        return LogLevel.debug;
    }
  }
}
