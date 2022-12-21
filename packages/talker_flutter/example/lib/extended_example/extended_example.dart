import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class ExtendedExample extends StatefulWidget {
  const ExtendedExample({Key? key}) : super(key: key);

  @override
  State<ExtendedExample> createState() => _ExtendedExampleState();
}

class _ExtendedExampleState extends State<ExtendedExample> {
  late Talker _talker;
  var _logsEnabled = true;

  @override
  void initState() {
    _talker = TalkerFlutter.init();

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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showLogMaker(context),
            child: const Icon(Icons.bug_report),
          ),
        );
      }),
    );
  }

  void _toggleLogsEnabled() {
    setState(() => _logsEnabled = !_logsEnabled);
    if (_logsEnabled) {
      _talker.disable();
    } else {
      _talker.enable();
    }
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

  void _verboseLog() {
    _talker.verbose('Cache images working slowly on this platform');
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

  void _showLogMaker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[850]?.withOpacity(0.9),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
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
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                BarButton(
                  title: ' ${_logsEnabled ? 'Enable' : 'Disable'} logs',
                  onTap: _toggleLogsEnabled,
                  backgroundColor: Colors.white,
                  titleColor: Colors.grey[900],
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
    this.backgroundColor,
    this.titleColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.white,
        ),
      ),
    );
  }
}
