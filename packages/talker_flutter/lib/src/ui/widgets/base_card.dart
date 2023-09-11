import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';

class TalkerBaseCard extends StatelessWidget {
  const TalkerBaseCard({
    Key? key,
    required this.child,
    required this.color,
    this.padding = const EdgeInsets.all(8),
    this.backgroundColor = defaultCardBackgroundColor,
  }) : super(key: key);

  final Widget child;
  final Color color;
  final EdgeInsets? padding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
