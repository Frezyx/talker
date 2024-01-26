import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

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
          child: TalkerScreen(talker: DI<Talker>()),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
