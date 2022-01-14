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
  logger.log('Test custom pen log', pen: AnsiPen()..xterm(49));
  logger.log(
    'Test log orem Ipsum is simply dummy text of\nthe printing and typesetting industry. Lorem Ipsum has been the industry`s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
  );
}
