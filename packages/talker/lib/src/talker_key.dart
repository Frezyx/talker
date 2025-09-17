import 'package:talker/talker.dart';

/// TalkerKey - String key of log type (After 5.0.0)
/// TalkerLogType (Before 5.0.0)
abstract class TalkerKey {
  TalkerKey._();

  /// Base logs section
  static const error = 'error';
  static const critical = 'critical';
  static const info = 'info';
  static const debug = 'debug';
  static const verbose = 'verbose';
  static const warning = 'warning';
  static const exception = 'exception';

  /// Http section
  static const httpError = 'http-error';
  static const httpRequest = 'http-request';
  static const httpResponse = 'http-response';

  /// Bloc section
  static const blocEvent = 'bloc-event';
  static const blocTransition = 'bloc-transition';
  static const blocClose = 'bloc-close';
  static const blocCreate = 'bloc-create';

  /// Riverpod section
  static const riverpodAdd = 'riverpod-add';
  static const riverpodUpdate = 'riverpod-update';
  static const riverpodDispose = 'riverpod-dispose';
  static const riverpodFail = 'riverpod-fail';

  /// grpc section
  static const grpcRequest = 'grpc-request';
  static const grpcResponse = 'grpc-response';
  static const grpcError = 'grpc-error';

  /// Drift section
  static const driftQuery = 'drift-query';
  static const driftResult = 'drift-result';
  static const driftError = 'drift-error';
  static const driftTransaction = 'drift-transaction';
  static const driftBatch = 'drift-batch';

  /// Flutter section
  static const route = 'route';

  static String fromLogLevel(LogLevel logLevel) =>
      _logLevels[logLevel] ?? TalkerKey.debug;

  static const _logLevels = {
    LogLevel.error: TalkerKey.error,
    LogLevel.critical: TalkerKey.critical,
    LogLevel.info: TalkerKey.info,
    LogLevel.debug: TalkerKey.debug,
    LogLevel.verbose: TalkerKey.verbose,
    LogLevel.warning: TalkerKey.warning,
  };
}
