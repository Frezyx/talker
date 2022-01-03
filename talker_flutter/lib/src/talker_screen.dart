import 'package:flutter/material.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:talker_flutter/talker_flutter.dart';

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
        title: const Text('Flutter talker'),
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 28,
              onPressed: () {
                //TODO: clean history
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 24,
              onPressed: () {
                //TODO: copy all logs
              },
              icon: const Icon(Icons.copy),
            ),
          ),
        ],
      ),
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

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Container(
            margin: const EdgeInsets.all(5).copyWith(bottom: 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: data.logLevel.color,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Message  ',
                          style: TextStyle(
                            color: data.logLevel.color,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: data.message ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Time  ',
                          style: TextStyle(
                            color: data.logLevel.color,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: DateTime.now().toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (data.additional != null)
                        RichText(
                          text: TextSpan(
                            text: 'Additional  ',
                            style: TextStyle(
                              color: data.logLevel.color,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: data.additional!.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 26,
                  child: IconButton(
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(
                      Icons.copy,
                      color: data.logLevel.color,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 15,
            child: Container(
              transform: Matrix4.translationValues(0, -8, 0),
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Text(
                title,
                style: TextStyle(
                  color: data.logLevel.color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        return data.logLevel.title;
      default:
        return 'DEAFULT';
    }
  }
}
