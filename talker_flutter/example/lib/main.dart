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
  @override
  void initState() {
    Talker.instance.configure(
      settings: const TalkerSettings(writeToFile: false),
    );
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
            talker: Talker.instance,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 170,
              width: 600,
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  BarButton(
                    title: 'Handle Error',
                    onTap: _handleError,
                  ),
                  BarButton(
                    title: 'Handle Exception',
                    onTap: _handleException,
                  ),
                  BarButton(
                    title: 'Fine Log',
                    onTap: _fineLog,
                  ),
                  BarButton(
                    title: 'Info Log',
                    onTap: _infoLog,
                  ),
                  BarButton(
                    title: 'Waring Log',
                    onTap: _warningLog,
                  ),
                  BarButton(
                    title: 'Big Critical log',
                    onTap: _bigCriticalLog,
                  ),
                  BarButton(
                    title: 'Custom log',
                    onTap: _customLog,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _handleError() {
    Talker.instance.handleError(
      ArgumentError('-6 is not positive number'),
      'dart argument error',
    );
  }

  void _handleException() {
    Talker.instance.handleException(
      Exception('Not connected'),
      'Http service is not working',
    );
  }

  void _fineLog() {
    Talker.instance.fine(
      'Service send good request',
    );
  }

  void _infoLog() {
    Talker.instance.info('Renew token from expire date');
  }

  void _warningLog() {
    Talker.instance.warning(
      'Cache images working slowly on this platform',
    );
  }

  void _customLog() {
    Talker.instance.logTyped(
      CustomLog('Custom log message'),
    );
  }

  void _bigCriticalLog() {
    Talker.instance.log(
      'Server exception',
      logLevel: LogLevel.critical,
      additional: {
        "timestamp": 1510417124782,
        "status": 500,
        "error": "Internal Server Error",
        "exception": "com.netflix.hystrix.exception.HystrixRuntimeException",
        "message":
            "ApplicationRepository#save(Application) failed and no fallback available.",
        "path": "/application"
      },
    );
  }
}

class CustomLog extends TalkerLog {
  CustomLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return pen.write(message);
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
      color: Colors.black,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
