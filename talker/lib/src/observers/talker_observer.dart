import 'package:talker/src/models/talker_data/talker_data.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

class TalkerObserver {
  const TalkerObserver({
    this.onError,
    this.onLog,
  });

  final Function(ErrorDetails err)? onError;
  final Function(TalkerDataInterface data)? onLog;
}
