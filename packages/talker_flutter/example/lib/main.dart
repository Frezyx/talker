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
    widget.talker.info('Renew token from expire date');
    _handleException();
    widget.talker.warning('Cache images working slowly on this platform');
    widget.talker.log('Server exception', logLevel: LogLevel.critical);
    widget.talker.info('3.............');
    widget.talker.info('2.......');
    widget.talker.info('1');
    widget.talker.good('Now you can check all Talkler power ⚡');
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

  void _handleException() {
    try {
      throw Exception('Test service exception');
    } catch (e, st) {
      widget.talker.handle(e, st, 'FakeService exception');
    }
  }
}
