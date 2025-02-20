import 'package:dart_frog/dart_frog.dart';
import 'package:talker_dart_frog_logger/talker_dart_frog_logger.dart';

Handler middleware(Handler handler) {
  return (context) async {
    /// Setup Talker logger only for middleware logs
    final talker = Talker(
      logger: TalkerLogger(
        formatter: DartFrogLoggerFormatter(),
      ),
    );

    /// Or you can provide one talker instance via context
    // final talker = context.read<Talker>();

    return loggerMiddleware(handler: handler, talker: talker)(context);
  };
}
