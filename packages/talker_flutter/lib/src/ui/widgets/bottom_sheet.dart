import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class BaseBottomSheet extends StatelessWidget {
  const BaseBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.child,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: talkerScreenTheme.backgroudColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
