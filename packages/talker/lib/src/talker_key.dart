import 'package:talker/talker.dart';

enum TalkerLogType {
  /// Base logs section
  error('error'),
  critical('critical'),
  info('info'),
  debug('debug'),
  verbose('verbose'),
  warning('warning'),
  exception('exception'),

  /// Http section
  httpError('http-error'),
  httpRequest('http-request'),
  httpResponse('http-response'),

  /// Bloc section
  blocEvent('bloc-event'),
  blocTransition('bloc-transition'),
  blocClose('bloc-close'),
  blocCreate('bloc-create'),

  /// Riverpod section
  riverpodAdd('riverpod-add'),
  riverpodUpdate('riverpod-update'),
  riverpodDispose('riverpod-dispose'),
  riverpodFail('riverpod-fail'),

  /// Flutter section
  route('route');

  const TalkerLogType(this.key);
  final String key;

  static TalkerLogType fromLogLevel(LogLevel logLevel) {
    return TalkerLogType.values.firstWhere((e) => e.logLevel == logLevel);
  }

  static TalkerLogType fromKey(String key) {
    return TalkerLogType.values.firstWhereOrNull((e) => e.key == key) ?? TalkerLogType.debug;
  }
}

extension TalkerLogTypeExt on TalkerLogType {
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
