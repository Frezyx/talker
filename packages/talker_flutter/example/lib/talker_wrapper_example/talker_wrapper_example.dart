import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CustomErrorMessagesExample extends StatelessWidget {
  const CustomErrorMessagesExample({Key? key, required this.talker})
      : super(key: key);

  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talker Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: _Home(talker: talker),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerWrapper(
        talker: talker,
        options: const TalkerWrapperOptions(
          enableErrorAlerts: true,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _handleException,
                child: const Text('Handle exception'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _handleError,
                child: const Text('Handle error'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleError() {
    try {
      throw ArgumentError('-6 is not positive number');
    } catch (e, st) {
      talker.handle(e, st, 'Something wrong in calculation');
    }
  }

  void _handleException() {
    try {
      throw Exception('Test service exception');
    } catch (e, st) {
      talker.handle(e, st);
    }
  }
}

class ExceptionSnackbar extends StatelessWidget {
  const ExceptionSnackbar({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TalkerException data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(2, 4),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.warning, color: Colors.white),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Oh no !',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                data.exception.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Text("Undo"),
          )
        ],
      ),
    );
  }
}
