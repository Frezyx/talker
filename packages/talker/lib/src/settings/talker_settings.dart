import 'package:talker/talker.dart';

const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.useConsoleLogs = true,
    this.maxHistoryItems = 200,
    this.writeToFile = false,
    List<Type>? registeredTypes,
  }) : _registeredTypes = registeredTypes;

  /// Use history to write talker records
  final bool useHistory;

  /// Use console logs to display talker records
  final bool useConsoleLogs;

  /// Max records count in history
  final int maxHistoryItems;

  /// Use writing talker records in file
  final bool writeToFile;

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
  ///   Talker.instance.configure(
  ///     settings: const TalkerSettings(
  ///       registeredTypes: [HttpTalkerLog],
  ///     ),
  ///   );
  ///
  ///   final httpLog = HttpTalkerLog('Http good');
  ///   Talker.instance.logTyped(httpLog);
  /// }
  /// ```
  List<Type> get registeredTypes =>
      [TalkerLog, TalkerError, TalkerException, ...?_registeredTypes];
  //TODO: make interface
  final List<Type>? _registeredTypes;
}
