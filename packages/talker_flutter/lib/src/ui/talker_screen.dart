import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/talker_screen_controller.dart';
import 'package:talker_flutter/src/ui/ui.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.theme = const TalkerScreenTheme(),
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerScreenTheme theme;

  @override
  State<TalkerScreen> createState() => _TalkerScreenState();
}

class _TalkerScreenState extends State<TalkerScreen> {
  final _controller = TalkerScreenController();
  final _typesController = GroupButtonController();
  final _titilesController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: widget.theme.backgroudColor,
          appBar: AppBar(
            title: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('Flutter talker'),
            ),
            actions: [
              SizedBox(
                width: 40,
                child: Transform(
                  alignment: Alignment.center,
                  transform: _controller.isLogOrderReversed
                      ? Matrix4.rotationX(pi)
                      : Matrix4.identity(),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 28,
                    onPressed: _controller.toggleLogOrder,
                    icon: const Icon(
                      Icons.swap_vert,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  onPressed: _toggleLogsExpanded,
                  icon: Icon(
                    _controller.expandedLogs
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  onPressed: _cleanHistory,
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 24,
                  onPressed: () => _copyAllLogs(context),
                  icon: const Icon(Icons.copy),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  onPressed: _showFilter,
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ),
            ],
          ),
          body: StreamBuilder(
            stream: widget.talker.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final filtredElements = widget.talker.history
                  .where((e) => _controller.filter.filter(e))
                  .toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filtredElements.length,
                itemBuilder: (_, i) {
                  final data = filtredElements[_controller.isLogOrderReversed
                      ? filtredElements.length - 1 - i
                      : i];
                  return TalkerDataCard(
                    data: data,
                    onTap: () => _copyTalkerDataItemText(data),
                    options: widget.theme,
                    expanded: _controller.expandedLogs,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    Clipboard.setData(
      ClipboardData(
        text: data.generateTextMessage(),
      ),
    );
    _showSnackBar(context, 'Log item is copied for console');
  }

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TalkerScreenFilter(
          controller: _controller,
          talkerScreenTheme: widget.theme,
          talker: widget.talker,
          typesController: _typesController,
          titlesController: _titilesController,
        );
      },
    );
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    _controller.update();
  }

  void _toggleLogsExpanded() {
    _controller.expandedLogs = !_controller.expandedLogs;
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.talker.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
