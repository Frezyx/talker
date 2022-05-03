import 'package:talker/talker.dart';

class TalkerSettings {
  TalkerSettings({
    this.enabled = true,
    bool useHistory = true,
    bool useConsoleLogs = true,
    int maxHistoryItems = 200,
    // bool writeToFile = false,
  })  : _useHistory = useHistory,
        _useConsoleLogs = useConsoleLogs,
        _maxHistoryItems = maxHistoryItems;
  // _writeToFile = writeToFile;

  /// Use history to write talker records
  bool get useHistory => _useHistory && enabled;
  final bool _useHistory;

  /// Use console logs to display talker records
  bool get useConsoleLogs => _useConsoleLogs && enabled;
  final bool _useConsoleLogs;

  /// Max records count in history
  int get maxHistoryItems => _maxHistoryItems;
  final int _maxHistoryItems;

  /// Use writing talker records in file
  // bool get writeToFile => _writeToFile && enabled;
  // final bool _writeToFile;

  /// The main rule that is responsible
  /// for the operation of the package
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
  List<Type> get registeredTypes => [
        TalkerLog, TalkerError, TalkerException,
        //...?_registeredTypes
      ];
}
