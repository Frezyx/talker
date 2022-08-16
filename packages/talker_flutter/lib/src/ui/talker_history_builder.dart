import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef TalkerHistoryWidgetBuilder = Widget Function(
    BuildContext context, List<TalkerDataInterface> data);

class TalkerHistoryBuilder extends StatelessWidget {
  const TalkerHistoryBuilder({
    Key? key,
    required this.talker,
    required this.builder,
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerHistoryWidgetBuilder builder;

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
