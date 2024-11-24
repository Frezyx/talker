import 'package:objectbox/objectbox.dart';
import 'package:talker/talker.dart';

/// Base [Talker] Data transfer object
/// Objects of this type are passed through
/// handlers observer and stream
@Entity()
class TalkerData {
  @Id()
  int id;
  String? message;
  String? key;
  String? title;

  @Property(type: PropertyType.date)
  DateTime time;

  // Stored versions of previously transient fields
  String? logLevelString; // Store enum as string
  String? exceptionMessage; // Store exception message
  String? errorMessage; // Store error message
  String? stackTraceString; // Store stack trace as string
  String? penColor; // Store pen color information

  // Runtime-only fields
  @Transient()
  LogLevel? _logLevel;
  @Transient()
  Object? _exception;
  @Transient()
  Error? _error;
  @Transient()
  StackTrace? _stackTrace;
  @Transient()
  AnsiPen? _pen;

  // Getters and setters for runtime fields
  LogLevel? get logLevel => _logLevel;
  set logLevel(LogLevel? value) {
    _logLevel = value;
    logLevelString = value?.toString();
  }

  Object? get exception => _exception;
  set exception(Object? value) {
    _exception = value;
    exceptionMessage = value?.toString();
  }

  Error? get error => _error;
  set error(Error? value) {
    _error = value;
    errorMessage = value?.toString();
  }

  StackTrace? get stackTrace => _stackTrace;
  set stackTrace(StackTrace? value) {
    _stackTrace = value;
    stackTraceString = value?.toString();
  }

  AnsiPen? get pen => _pen;
  set pen(AnsiPen? value) {
    _pen = value;
    penColor = value?.toString();
  }

  TalkerData(
    this.message, {
    this.id = 0,
    this.key,
    this.title = 'log',
    DateTime? time,
    LogLevel? logLevel,
    Object? exception,
    Error? error,
    StackTrace? stackTrace,
    AnsiPen? pen,
  }) : time = time ?? DateTime.now() {
    this.logLevel = logLevel;
    this.exception = exception;
    this.error = error;
    this.stackTrace = stackTrace;
    this.pen = pen;
  }

  String generateTextMessage(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '${displayTitleWithTime(timeFormat: timeFormat)}$message$stackTraceString';
  }

  // Method to reconstruct all transient fields from stored strings
  void reconstructTransientFields() {
    reconstructLogLevel();
    reconstructException();
    reconstructError();
    reconstructStackTrace();
    reconstructPen();
  }

  // Individual reconstruction methods
  void reconstructLogLevel() {
    if (logLevelString != null) {
      _logLevel = LogLevel.values.firstWhere(
          (e) => e.toString() == logLevelString,
          orElse: () => LogLevel.debug // Provide a default value
          );
    }
  }

  void reconstructException() {
    if (exceptionMessage != null) {
      _exception = Exception(exceptionMessage);
    }
  }

  void reconstructError() {
    if (errorMessage != null) {
      _error =
          ArgumentError(errorMessage!); // Assuming Error has such constructor
    }
  }

  void reconstructStackTrace() {
    if (stackTraceString != null) {
      _stackTrace = StackTrace.fromString(stackTraceString!);
    }
  }

  /// this is not working now facing some issue with penColor
  void reconstructPen() {
    if (penColor != null) {
      // Reconstruct AnsiPen based on your pen color format
      // _pen = AnsiPen()..xterm(int.parse(penColor!)); // Example reconstruction
    }
  }
}

/// Extension to get
/// display text of [TalkerData] fields
extension FieldsToDisplay on TalkerData {
  /// Displayed title of [TalkerData]

  String displayTitleWithTime(
      {TimeFormat timeFormat = TimeFormat.timeAndSeconds}) {
    return '[$title] | ${displayTime(timeFormat: timeFormat)} | ';
  }

  /// Displayed stackTrace of [TalkerData]
  String get displayStackTrace {
    if (stackTrace == null || stackTrace == StackTrace.empty) {
      return '';
    }
    return '\nStackTrace: $stackTrace}';
  }

  /// Displayed exception of [TalkerData]
  String get displayException {
    if (exception == null) {
      return '';
    }
    return '\n$exception';
  }

  /// Displayed error of [TalkerData]
  String get displayError {
    if (error == null) {
      return '';
    }
    return '\n$error';
  }

  /// Displayed message of [TalkerData]
  String get displayMessage {
    if (message == null) {
      return '';
    }
    return '$message';
  }

  /// Displayed tile of [TalkerData]
  String displayTime({TimeFormat timeFormat = TimeFormat.timeAndSeconds}) =>
      TalkerDateTimeFormatter(time, timeFormat: timeFormat).format;
}
