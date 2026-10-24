import 'package:talker/src/models/models.dart';

/// Base observer class for
/// to create your own observers
abstract class TalkerObserver {
  const TalkerObserver();

  /// Called when [Talker] handle an [TalkerError]
  void onError(TalkerError err) {}

  /// Called when [Talker] handle an [TalkerException]
  void onException(TalkerException err) {}

  /// Called when [Talker] handle an [TalkerData] log
  void onLog(TalkerData log) {}
}

class MultipleTalkerObserver implements TalkerObserver {
  MultipleTalkerObserver({required this.observers});
  final List<TalkerObserver> observers;

  @override
  void onError(TalkerError err) => observers.forEach((e) => e.onError(err));

  @override
  void onException(TalkerException err) =>
      observers.forEach((e) => e.onException(err));

  @override
  void onLog(TalkerData log) => observers.forEach((e) => e.onLog(log));
}
