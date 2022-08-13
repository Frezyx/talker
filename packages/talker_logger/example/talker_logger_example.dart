import 'dart:convert';

import 'package:talker_logger/talker_logger.dart';

void main() {
  // Create instance
  final logger = TalkerLogger(
    //Enable for custom colored logs with Formatter
    // formater: ColoredLoggerFormatter(),
    settings: const TalkerLoggerSettings(
      level: LogLevel.info,
    ),
  );

  // Log messages
  logger.debug('debug');
  logger.info('info');
  logger.warning('warning');
  logger.error('error');
  logger.fine('fine');
  logger.good('good');
  logger.warning('warning');
  logger.verbose('verbose');
  logger.log('log with level info', level: LogLevel.info);
  logger.log('custom pen log ', pen: AnsiPen()..xterm(49));
  logger.log(
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.''',
  );

  const encoder = JsonEncoder.withIndent('  ');
  final prettyData = encoder.convert(
    {
      "widget": {
        "debug": "on",
        "window": {
          "title": "Sample Konfabulator Widget",
          "name": "main_window",
          "width": 500,
          "height": 500
        },
        "image": {
          "src": "Images/Sun.png",
          "name": "sun1",
          "hOffset": 250,
          "vOffset": 250,
          "alignment": "center"
        },
      }
    },
  );
  logger.log(prettyData, pen: AnsiPen()..xterm(46));
}

class ColoredLoggerFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final coloredMsg =
        msg.split('\n').map((e) => details.pen.write(e)).toList().join('\n');
    return coloredMsg;
  }
}
