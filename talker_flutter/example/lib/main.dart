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
    Talker.instance.configure();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talker Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Stack(
        children: [
          TalkerScreen(
            talker: Talker.instance,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100,
              width: 600,
              color: Colors.white,
              padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
              child: Wrap(
                spacing: 10,
                children: [
                  MaterialButton(
                    onPressed: () => Talker.instance
                        .handleError('Test error', ArgumentError()),
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
                        'Test exception', Exception('Http exception')),
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
                      'Fine log',
                      LogLevel.fine,
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
                    onPressed: () => Talker.instance.log(
                      'Info log',
                      LogLevel.info,
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
                    onPressed: () => Talker.instance.log(
                      'Test waring log',
                      LogLevel.warning,
                    ),
                    color: Colors.black,
                    child: const Text(
                      'Warning log',
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
