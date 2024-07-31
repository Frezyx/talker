import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatelessWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Talker',
    this.itemsBuilder,
    this.appBarLeading,
    LogColors? logColors,
  })  : logColors = logColors ?? defaultColors,
        super(key: key);

  /// Talker implementation
  final Talker talker;

  /// Screen [AppBar] title
  final String appBarTitle;

  /// Screen [AppBar] leading
  final Widget? appBarLeading;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  final LogColors logColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerView(
        talker: talker,
        appBarTitle: appBarTitle,
        appBarLeading: appBarLeading,
        logColors: logColors,
      ),
    );
  }
}
