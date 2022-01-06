import 'package:talker_error_handler/talker_error_handler.dart';

extension DebugErrorsStream on Stream<ErrorDetails> {
  Stream<ErrorDetails> get debug =>
      where((e) => e.errorLevel == ErrorLevel.debug);
}

extension CriticalErrorsStream on Stream<ErrorDetails> {
  Stream<ErrorDetails> get critical =>
      where((e) => e.errorLevel == ErrorLevel.critical);
}

extension InfoErrorsStream on Stream<ErrorDetails> {
  Stream<ErrorDetails> get info =>
      where((e) => e.errorLevel == ErrorLevel.info);
}

extension WarningErrorsStream on Stream<ErrorDetails> {
  Stream<ErrorDetails> get warning =>
      where((e) => e.errorLevel == ErrorLevel.warning);
}

extension TinyErrorsStream on Stream<ErrorDetails> {
  Stream<ErrorDetails> get tiny =>
      where((e) => e.errorLevel == ErrorLevel.tiny);
}
