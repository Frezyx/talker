import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatelessWidget {
  // TODO: make me const again when theme is removed. Theme cannot be remove rightn now for backward compability reasons.
  TalkerScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Talker',
    this.itemsBuilder,
    this.appBarLeading,
    LogColors? logColors,
    @Deprecated("theme is depricated use logColors instead") this.theme,
  })  : logColors = logColors ?? theme?.logColors ?? defaultColors,
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

  final TalkerScreenTheme? theme;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      body: TalkerView(
        talker: talker,
        appBarTitle: appBarTitle,
        appBarLeading: appBarLeading,
        logColors: logColors,
      ),
    );

    if (theme == null) return scaffold;

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          cardColor: theme!.cardColor,
          backgroundColor: theme!.backgroundColor,
        ),
      ),
      child: scaffold,
    );
  }
}
