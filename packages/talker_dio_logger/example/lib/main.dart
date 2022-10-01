import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

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
    _dio = Dio();
    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );
    _dio.get('https://jsonplaceholder.typicode.com/todos/1');
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
                  _dio.get('htt://jsonplaceholder.typicode.com/todos');
                },
                child: const Text('Invalid request with exception'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
