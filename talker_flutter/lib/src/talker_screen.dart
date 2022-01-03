import 'package:flutter/material.dart';
import 'package:talker/talker.dart';

class TalkerScreen extends StatelessWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () => talker.handleError('Test error', ArgumentError()),
            child: const Text('Make test error'),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: talker.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: talker.history.length,
            itemBuilder: (_, i) {
              return Text(
                talker.history[i].toString(),
              );
            },
          );
        },
      ),
    );
  }
}
