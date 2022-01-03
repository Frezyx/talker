import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'extensions/extensions.dart';

class TalkerScreen extends StatelessWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: StreamBuilder(
        stream: talker.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: talker.history.length,
            itemBuilder: (_, i) {
              final data = talker.history[i];
              return TalkerDataCard(data: data);
            },
          );
        },
      ),
    );
  }
}

class TalkerDataCard extends StatelessWidget {
  const TalkerDataCard({Key? key, required this.data}) : super(key: key);

  final TalkerDataInterface data;

  @override
  Widget build(BuildContext context) {
    final title = _getTitle(data);

    return Container(
      margin: const EdgeInsets.all(5).copyWith(bottom: 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: data.logLevel.color,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.message ?? '',
            style: TextStyle(
              color: data.logLevel.color,
            ),
          ),
          Text(
            data.logLevel.toString(),
            style: TextStyle(
              color: data.logLevel.color,
            ),
          ),
          Text(
            DateTime.now().toString(),
            style: TextStyle(
              color: data.logLevel.color,
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle(TalkerDataInterface data) {
    switch (data.runtimeType) {
      case TalkerError:
        return 'ERROR';
      case TalkerException:
        return 'EXCEPTION';
      case TalkerLog:
        return 'LOG';
      default:
        return 'DEAFULT';
    }
  }
}
