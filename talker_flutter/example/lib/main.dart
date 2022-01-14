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
                  MaterialButton(
                    onPressed: () => Talker.instance.handleError(
                      ArgumentError('-6 is not positive number'),
                      'dart argument error',
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Error',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.handleException(
                      Exception('Not connected'),
                      'Http service is not working',
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Exception',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.log(
                      'Service send good request',
                      logLevel: LogLevel.fine,
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Fine log',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.info(
                      'Renew token from expire date',
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Info log',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.warning(
                      'Cache images working slowly on this platform',
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Waring Log',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.log(
                      'Server exception',
                      logLevel: LogLevel.critical,
                      additional: {
                        "timestamp": 1510417124782,
                        "status": 500,
                        "error": "Internal Server Error",
                        "exception":
                            "com.netflix.hystrix.exception.HystrixRuntimeException",
                        "message":
                            "ApplicationRepository#save(Application) failed and no fallback available.",
                        "path": "/application"
                      },
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Big Exception',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => Talker.instance.log(
                      'Custom log message',
                      pen: AnsiPen()..xterm(49),
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Custom log',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
