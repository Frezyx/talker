import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PresentationWidget extends StatelessWidget {
  const PresentationWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(flex: 2),
        Expanded(
          flex: 4,
          child: Stack(
            children: [
              child,
              Image.asset('assets/iphone_mockup.png'),
            ],
          ),
        ),
        const Spacer(flex: 1),
        Expanded(
          flex: 4,
          child: TalkerScreen(talker: GetIt.instance<Talker>()),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
