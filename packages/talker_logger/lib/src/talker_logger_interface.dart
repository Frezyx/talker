import 'package:talker_logger/talker_logger.dart';

abstract class TalkerLoggerInterface {
  /// {@template talker_logger_log}
  /// Log a new custom message
  /// [String] [msg] - message describes what happened
  /// [LogLevel] [level] - level of logs to segmentation фтв control logging output
  /// [AnsiPen] [pen] - console pen to setting log color
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.log('Log custom message', level: LogLevel.error, pen: AnsiPen()..red());
  /// ```
  /// {@endtemplate}
  void log(String msg, {LogLevel? level, AnsiPen? pen});

  /// {@template talker_logger_critical_log}
  /// Log a new critical message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.critical('Log critical message');
  /// ```
  /// {@endtemplate}
  void critical(String msg);

  /// {@template talker_logger_error_log}
  /// Log a new error message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.error('Log error message');
  /// ```
  /// {@endtemplate}
  void error(String msg);

  /// {@template talker_logger_debug_log}
  /// Log a new debug message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.debug('Log debug message');
  /// ```
  /// {@endtemplate}
  void debug(String msg);

  /// {@template talker_logger_warning_log}
  /// Log a new warning message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.warning('Log warning message');
  /// ```
  /// {@endtemplate}
  void warning(String msg);

  /// {@template talker_logger_verbose_log}
  /// Log a new verbose message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.verbose('Log verbose message');
  /// ```
  /// {@endtemplate}
  void verbose(String msg);

  /// {@template talker_logger_info_log}
  /// Log a new info message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.info('Log info message');
  /// ```
  /// {@endtemplate}
  void info(String msg);

  /// {@template talker_logger_fine_log}
  /// Log a new fine message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.fine('Log fine message');
  /// ```
  /// {@endtemplate}
  void fine(String msg);

  /// {@template talker_logger_good_log}
  /// Log a new good message
  /// [String] [msg] - message describes what happened
  ///
  /// ```dart
  /// final logger = TalkerLogger();
  /// logger.good('Log good message');
  /// ```
  /// {@endtemplate}
  void good(String msg);
}
