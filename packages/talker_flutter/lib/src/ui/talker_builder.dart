import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef TalkerWidgetBuilder = Widget Function(
  BuildContext context,
  List<TalkerData> data,
);

class TalkerBuilder extends StatelessWidget {
  const TalkerBuilder({
    super.key,
    required this.talker,
    required this.builder,
  });

  final Talker talker;
  final TalkerWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: talker.stream,
      builder: (BuildContext context, _) {
        return builder(context, talker.history);
      },
    );
  }
}
