import 'package:talker_logger/talker_logger.dart';

void main() {
  final logger = TalkerLogger(
    settings: const TalkerLoggerSettings(
      logLevel: LogLevel.info,
    ),
  );

  logger.log('Test debug');
  logger.log('Test info', logLevel: LogLevel.info);
  logger.log('Test critical', logLevel: LogLevel.critical);
  logger.log('Test error', logLevel: LogLevel.error);
  logger.log('Test fine', logLevel: LogLevel.fine);
  logger.log('Test good', logLevel: LogLevel.good);
  logger.log('Test warning', logLevel: LogLevel.warning);
  logger.log('Test verbose', logLevel: LogLevel.verbose);
}
