import 'package:talker/src/models/talker_data/talker_data.dart';
import 'package:talker_error_handler/talker_error_handler.dart';

abstract class TalkerObserver {
  Function(ErrorDetails err) get onError;
  Function(TalkerDataInterface data) get onLog;
}
