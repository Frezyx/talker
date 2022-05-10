import 'dart:io';

import 'package:flutter/material.dart';
import 'package:talker_example/extended_example/extended_example.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// You can see [ExtendedExample] to
/// check how logs working in realtime
///
///

void main() {
  runApp(const BaseEample());
}

class BaseEample extends StatefulWidget {
  const BaseEample({Key? key}) : super(key: key);

  @override
  State<BaseEample> createState() => _BaseEampleState();
}

class _BaseEampleState extends State<BaseEample> {
  late Talker _talker;

  @override
  void initState() {
    _talker = Talker(
      loggerSettings: TalkerLoggerSettings(
        enableColors: !Platform.isIOS,
      ),
    );

    _fineLog();
    _infoLog();
    _handleError();
    _handleException();
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
      home: Builder(builder: (context) {
        return Scaffold(
          body: TalkerScreen(talker: _talker),
        );
      }),
    );
  }

  void _handleError() {
    try {
      throw ArgumentError('-6 is not positive number');
    } catch (e, st) {
      _talker.handle(e, st, 'Something wrong in calculation');
    }
  }

  void _handleException() {
    try {
      throw Exception('Test service exception');
    } catch (e, st) {
      _talker.handle(e, st, 'FakeService excetion');
    }
  }

  void _fineLog() {
    _talker.fine('Service send good request');
  }

  void _infoLog() {
    _talker.info('Renew token from expire date');
  }

  void _warningLog() {
    _talker.warning('Cache images working slowly on this platform');
  }

  void _customLog() {
    _talker.logTyped(CustomLog('Custom log message'));
  }

  void _criticalLog() {
    _talker.log('Server exception', logLevel: LogLevel.critical);
  }
}
