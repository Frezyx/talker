import 'package:flutter/material.dart';

class TalkerBaseCard extends StatelessWidget {
  const TalkerBaseCard({
    Key? key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(8),
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: color?.withOpacity(.1),
        border: Border.all(
          color: color ?? Theme.of(context).colorScheme.onSurface,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
