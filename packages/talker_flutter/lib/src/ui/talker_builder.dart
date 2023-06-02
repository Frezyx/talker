import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef TalkerWidgetBuilder = Widget Function(
  BuildContext context,
  List<TalkerDataInterface> data,
);

class TalkerBuilder extends StatelessWidget {
  const TalkerBuilder({
    Key? key,
    required this.talker,
    required this.builder,
  }) : super(key: key);

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
