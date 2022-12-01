import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Dio _dio;

  @override
  void initState() {
    // Disable flutter logs cut by the console
    final talker = Talker(loggerOutput: debugPrint);
    // Disable flutter logs cut by the console

    _dio = Dio();
    _dio.interceptors.add(
      TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'talker_dio_logger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Check result in console',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _dio.get('https://jsonplaceholder.typicode.com/todos/1');
                },
                child: const Text('GET todo request'),
              ),
              ElevatedButton(
                onPressed: () {
                  _dio.get('https://jsonplaceholder.typicode.com/todos');
                },
                child: const Text('GET todos list request'),
              ),
              ElevatedButton(
                onPressed: () {
                  _dio.put('https://dummyjson.com/products/1');
                },
                child: const Text('PUT products request'),
              ),
              ElevatedButton(
                onPressed: () {
                  _dio.post('https://dummyjson.com/products/add');
                },
                child: const Text('POST products request'),
              ),
              ElevatedButton(
                onPressed: () {
                  _dio.delete('https://dummyjson.com/products/1');
                },
                child: const Text('DELETE products request'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  _dio.get('htt://jsonplaceholder.typicode.com/todos');
                },
                child: const Text('Invalid GET request with error'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
