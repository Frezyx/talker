import 'package:flutter/material.dart';
import 'package:talker_flutter/src/controller/talker_screen_controller.dart';
import 'package:talker_flutter/src/ui/talker_view.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Talker',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
  }) : super(key: key);

  /// Talker implementation
  final Talker talker;

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Screen [AppBar] title
  final String appBarTitle;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  @override
  State<TalkerScreen> createState() => _TalkerScreenState();
}

class _TalkerScreenState extends State<TalkerScreen> {
  final _controller = TalkerScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.backgroundColor,
      body: TalkerView(
        talker: widget.talker,
        theme: widget.theme,
        appBarTitle: widget.appBarTitle,
        controller: _controller,
      ),
    );
  }
}
