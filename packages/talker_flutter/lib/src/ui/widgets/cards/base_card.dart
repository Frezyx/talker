import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theem.dart';

class TalkerBaseCard extends StatelessWidget {
  const TalkerBaseCard({
    Key? key,
    required this.child,
    required this.color,
  }) : super(key: key);

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
