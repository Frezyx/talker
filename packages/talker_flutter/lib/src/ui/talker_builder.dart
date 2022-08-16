import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef TalkerWidgetBuilder = Widget Function(
  BuildContext context,
  TalkerDataInterface data,
);

class TalkerBuilder extends StatelessWidget {
  const TalkerBuilder({
    Key? key,
    required this.talker,
    required this.builder,
    this.placeholder = const SizedBox(),
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerWidgetBuilder builder;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TalkerDataInterface>(
      stream: talker.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<TalkerDataInterface> snapshot,
      ) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return builder(
              context,
              snapshot.requireData,
            );
          default:
            return placeholder;
        }
      },
    );
  }
}
