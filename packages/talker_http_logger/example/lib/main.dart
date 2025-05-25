import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_http_logger/talker_http_logger_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger_settings.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Talker _talker = Talker();

  late final InterceptedClient client = InterceptedClient.build(
    interceptors: [
      TalkerHttpLogger(
        talker: _talker,
        settings: TalkerHttpLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          hiddenHeaders: {'authorization'},
        ),
      ),
    ],
  );

  late final List<({String title, VoidCallback onPressed})> _buttons = [
    (
      title: 'GET todo request',
      onPressed: () => client.get(
            Uri.https("jsonplaceholder.typicode.com", "/todos/1"),
            headers: {
              "firstHeader": "firstHeaderValue",
              "authorization": "bearer super_secret_token",
              "lastHeader": "lastHeaderValue",
            },
          ),
    ),
    (
      title: 'GET todos list request',
      onPressed: () =>
          client.get(Uri.https("jsonplaceholder.typicode.com", "/todos")),
    ),
    (
      title: 'POST todo request',
      onPressed: () => client.post(
            Uri.https("jsonplaceholder.typicode.com", "/todos"),
            body: {
              "userId": '1',
              "id": '1',
              "title": "delectus aut autem",
              "completed": 'false',
            },
          ),
    ),
    (
      title: 'PUT todo request',
      onPressed: () => client.put(
            Uri.https("jsonplaceholder.typicode.com", "/todos/1"),
            body: {
              "userId": '1',
              "id": '1',
              "title": "delectus aut autem",
              "completed": 'false',
            },
          ),
    ),
    (
      title: 'DELETE todo request',
      onPressed: () =>
          client.delete(Uri.https("jsonplaceholder.typicode.com", "/todos/1")),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Talker + Http Example'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        children: [
          const Text(
            'Check result in console or open Talker Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          for (final ({String title, VoidCallback onPressed}) button
              in _buttons)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: button.onPressed,
                child: Text(button.title),
              ),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(
                    talker: _talker,
                    isLogsExpanded: true,
                    isLogOrderReversed: true,
                  ),
                ),
              );
            },
            child: Text('Go to Talker Screen'),
          ),
        ],
      ),
    );
  }
}
