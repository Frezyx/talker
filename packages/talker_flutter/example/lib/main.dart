import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_example/extended_example/extended_example.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// You can see [ExtendedExample] to
/// check how logs working in realtime
///
///

void main() {
  final talker = TalkerFlutter.init();
  runZonedGuarded(
    () => runApp(BaseExample(talker: talker)),
    (Object error, StackTrace stack) {
      talker.handle(error, stack, 'Uncaught app exception');
    },
  );
}

class BaseExample extends StatefulWidget {
  const BaseExample({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  State<BaseExample> createState() => _BaseExampleState();
}

class _BaseExampleState extends State<BaseExample> {
  @override
  void initState() {
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
          body: TalkerScreen(talker: widget.talker),
        );
      }),
    );
  }

  void _handleError() {
    try {
      throw ArgumentError('-6 is not positive number');
    } catch (e, st) {
      widget.talker.handle(e, st, 'Something wrong in calculation');
    }
  }

  void _handleException() {
    try {
      throw Exception('Test service exception');
    } catch (e, st) {
      widget.talker.handle(e, st, 'FakeService exception');
    }
  }

  void _fineLog() {
    widget.talker.fine('Service send good request');
  }

  void _infoLog() {
    widget.talker.info('Renew token from expire date');
  }

  void _warningLog() {
    widget.talker.warning('Cache images working slowly on this platform');
  }

  void _customLog() {
    widget.talker.logTyped(CustomLog('Custom log message'));
  }

  void _criticalLog() {
    widget.talker.log('Server exception', logLevel: LogLevel.critical);
  }
}
