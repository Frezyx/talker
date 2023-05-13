/// {@template talker_settings}
/// This class used for setup [Talker] configuration
/// {@endtemplate}
class TalkerSettings {
  TalkerSettings({
    this.enabled = true,
    bool useHistory = true,
    bool useConsoleLogs = true,
    int? maxHistoryItems = 200,
    // bool writeToFile = false,
  })  : _useHistory = useHistory,
        _useConsoleLogs = useConsoleLogs,
        _maxHistoryItems = maxHistoryItems ?? 200;
  // _writeToFile = writeToFile;

  /// By default talker write all Errors / Exceptions and logs in history list
  /// (base dart [List] field in core)
  /// If [true] - writing in history
  /// If [false] - not writing
  bool get useHistory => _useHistory && enabled;
  final bool _useHistory;

  /// By default talker print all Errors / Exceptions and logs in console.
  /// If [true] - printing in history [false] - not printing.
  bool get useConsoleLogs => _useConsoleLogs && enabled;
  final bool _useConsoleLogs;

  /// Max records count in history list
  int get maxHistoryItems => _maxHistoryItems;
  final int _maxHistoryItems;

  /// Use writing talker records in file
  // bool get writeToFile => _writeToFile && enabled;
  // final bool _writeToFile;

  /// The main rule that is responsible
  /// for the operation of the package
  /// All log and handle error / exception methods are working when [true] and not working when [false]
  bool enabled;

  /// Registered types to make fltering
  /// and more easy displaying in talker_flutter
  /// ```dart
  ///class HttpTalkerLog extends TalkerLog {
  ///   HttpTalkerLog(String message) : super(message);
  ///
  ///   @override
  ///   AnsiPen get pen => AnsiPen()..xterm(49);
  ///
  ///   @override
  ///   String generateTextMessage() {
  ///     return pen.write(message);
  ///   }
  ///}
  ///
  ///void main() {
  ///   talker.configure(
  ///     settings: const TalkerSettings(
  ///       registeredTypes: [HttpTalkerLog],
  ///     ),
  ///   );
  ///
  ///   final httpLog = HttpTalkerLog('Http good');
  ///   talker.logTyped(httpLog);
  /// }
  /// ```
  // List<Type> get registeredTypes => [
  //       TalkerLog, TalkerError, TalkerException,
  //       //...?_registeredTypes
  //     ];

  TalkerSettings copyWith({
    bool? enabled,
    bool? useHistory,
    bool? useConsoleLogs,
    int? maxHistoryItems,
  }) {
    return TalkerSettings(
      useHistory: useHistory ?? _useHistory,
      useConsoleLogs: useConsoleLogs ?? _useConsoleLogs,
      maxHistoryItems: maxHistoryItems ?? _maxHistoryItems,
      enabled: enabled ?? this.enabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TalkerSettings &&
        other._useHistory == _useHistory &&
        other._useConsoleLogs == _useConsoleLogs &&
        other._maxHistoryItems == _maxHistoryItems &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return _useHistory.hashCode ^
        _useConsoleLogs.hashCode ^
        _maxHistoryItems.hashCode ^
        enabled.hashCode;
  }
}
