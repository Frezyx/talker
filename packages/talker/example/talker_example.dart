import 'package:talker/talker.dart';

Future<void> main() async {
  final talker = Talker();

  // Handle exceptions and errors
  try {
    throw Exception('Something went wrong');
  } catch (e, st) {
    talker.handle(e, st, 'Exception with');
  }

  // Log your app actions
  talker.info('App is started');
  talker.debug('All services enabled');
  talker.error('❌ Houston, we have a problem!');
  talker.logTyped(YourCustomLog('Something like your own service message'));
}

class YourCustomLog extends TalkerLog {
  YourCustomLog(String message) : super(message);

  @override
  String get title => 'CUSTOM';

  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}
