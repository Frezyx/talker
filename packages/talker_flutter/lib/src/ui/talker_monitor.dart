import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitor extends StatelessWidget {
  const TalkerMonitor({Key? key, required this.theme}) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroudColor,
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Talker Monitor'),
        ),
      ),
      body: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
