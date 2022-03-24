import 'package:talker_logger/talker_logger.dart';

class LogDetails {
  const LogDetails({
    required this.message,
    required this.level,
    required this.pen,
    this.lineSymbol = '-',
    this.maxLineWidth = 110,
  });

  final String message;
  final LogLevel level;
  final AnsiPen pen;
  final String lineSymbol;
  final int maxLineWidth;
}
