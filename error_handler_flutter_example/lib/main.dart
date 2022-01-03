import 'package:talker_error_handler/talker_error_handler.dart';
import 'package:flutter/material.dart';

final errorHandler = ErrorHandler();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error handler demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () =>
                errorHandler.handleError('Test error', ArgumentError()),
            child: const Text('Make test error'),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: errorHandler.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: errorHandler.history.length,
            itemBuilder: (_, i) {
              return Text(
                errorHandler.history[i].toString(),
              );
            },
          );
        },
      ),
    );
  }
}
