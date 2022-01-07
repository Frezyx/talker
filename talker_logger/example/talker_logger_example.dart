import 'package:talker_logger/talker_logger.dart';

void main() {
  final logger = TalkerLogger(
    settings: const TalkerLoggerSettings(
      level: LogLevel.info,
    ),
  );

  logger.log('Test debug');
  logger.log('Test info', level: LogLevel.info);
  logger.log('Test critical', level: LogLevel.critical);
  logger.log('Test error', level: LogLevel.error);
  logger.log('Test fine', level: LogLevel.fine);
  logger.log('Test good', level: LogLevel.good);
  logger.log('Test warning', level: LogLevel.warning);
  logger.log('Test verbose', level: LogLevel.verbose);
}
