import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class PresentationWidget extends StatelessWidget {
  const PresentationWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        Expanded(child: TalkerScreen(talker: GetIt.instance<Talker>())),
      ],
    );
  }
}
