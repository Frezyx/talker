import 'package:talker/talker.dart';

/// Base class for create your own implementation of history
///
/// The history stores all information about all events like
/// occurred errors [TalkerError]s, exceptions [TalkerException]s
/// and logs [TalkerLog]s that have been sent
abstract class TalkerHistory {
  /// Return List of [TalkerDataInterface]
  List<TalkerData> get history;

  /// Called when [Talker] handle [cleanHistory].
  /// For example, [TalkerView] handle the [Talker.cleanHistory]
  void clean();

  /// Called when [Talker] handle an [TalkerDataInterface] log
  void write(TalkerData data);
}
