import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Talker _talker;

  @override
  void initState() {
    _talker = Talker(
      settings: TalkerSettings(writeToFile: false),
    );

    _handleError();
    _handleException();
    _fineLog();
    _infoLog();
    _warningLog();
    _criticalLog();
    _customLog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talker Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Stack(
        children: [
          TalkerScreen(
            talker: _talker,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: kIsWeb ? 100 : 170,
              width: 600,
              color: Colors.grey[850],
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  BarButton(title: 'Handle Error', onTap: _handleError),
                  BarButton(title: 'Handle Exception', onTap: _handleException),
                  BarButton(title: 'Fine Log', onTap: _fineLog),
                  BarButton(title: 'Info Log', onTap: _infoLog),
                  BarButton(title: 'Waring Log', onTap: _warningLog),
                  BarButton(title: 'Varning Log', onTap: _verboseLog),
                  BarButton(title: 'Big Critical log', onTap: _criticalLog),
                  BarButton(title: 'Custom log', onTap: _customLog),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleError() {
    _talker.handleError(ArgumentError('-6 is not positive number'));
  }

  void _handleException() {
    _talker.handleException(Exception('Not connected'));
  }

  void _fineLog() {
    _talker.fine(
      'Service send good request',
    );
  }

  void _infoLog() {
    _talker.info('Renew token from expire date');
  }

  void _verboseLog() {
    _talker.verbose(
      'Cache images working slowly on this platform',
    );
  }

  void _warningLog() {
    _talker.warning(
      'Cache images working slowly on this platform',
    );
  }

  void _customLog() {
    _talker.logTyped(
      CustomLog('Custom log message'),
    );
  }

  void _criticalLog() {
    _talker.log('Server exception', logLevel: LogLevel.critical);
  }
}

class CustomLog extends FlutterTalkerLog {
  CustomLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  Color get color => Colors.teal;

  @override
  String generateTextMessage() {
    return '| Custom leading | ' + message;
  }
}

class BarButton extends StatelessWidget {
  const BarButton({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: Theme.of(context).primaryColor,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
