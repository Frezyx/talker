import 'package:talker_logger/talker_logger.dart';

/// A class for transporting data
/// about an log message
class LogDetails {
  const LogDetails({
    required this.message,
    required this.level,
    required this.pen,
  });

  /// Log message
  final dynamic message;

  /// Log [LogLevel]
  final LogLevel level;

  /// Pen for colored console message
  final AnsiPen pen;
}
