import 'package:talker/talker.dart';

abstract class TalkerErrorHandlerInterface {
  TalkerDataInterface handle(
    Object exception, [
    StackTrace? stackTrace,
    String? msg,
  ]);
}
