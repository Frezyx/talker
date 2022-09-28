import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/talker_screen_controller.dart';
import 'package:talker_flutter/src/ui/ui.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'widgets/actions_bottom_sheet/actions_bottom_sheet.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Flutter talker',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
  }) : super(key: key);

  /// Talker implementation
  final TalkerInterface talker;

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
            title: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(widget.appBarTitle),
            ),
            actions: [
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ActionsBottomSheet(
                          actions: [
                            BottomSheetAction(
                              onTap: _controller.toggleLogOrder,
                              title: 'Reverse logs',
                              icon: Icons.swap_vert,
                            ),
                            BottomSheetAction(
                              onTap: _toggleLogsExpanded,
                              title: 'Cut logs',
                              icon: _controller.expandedLogs
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            BottomSheetAction(
                              onTap: _cleanHistory,
                              title: 'Clean history',
                              icon: Icons.delete_outline,
                            ),
                            BottomSheetAction(
                              onTap: () => _copyAllLogs(context),
                              title: 'Copy all logs',
                              icon: Icons.copy,
                            ),
                            BottomSheetAction(
                              onTap: () => _showFilter(context),
                              title: 'Filter',
                              icon: Icons.filter_alt_outlined,
                            ),
                          ],
                          talkerScreenTheme: widget.theme,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert_rounded),
                ),
              ),

              // SizedBox(
              //   width: 40,
              //   child: Transform(
              //     alignment: Alignment.center,
              //     transform: _controller.isLogOrderReversed
              //         ? Matrix4.rotationX(pi)
              //         : Matrix4.identity(),
              //     child: IconButton(
              //       padding: EdgeInsets.zero,
              //       iconSize: 28,
              //       onPressed: _controller.toggleLogOrder,
              //       icon: const Icon(
              //         Icons.swap_vert,
              //       ),
              //     ),
              //   ),
              // ),

              // SizedBox(
              //   width: 40,
              //   child: IconButton(
              //     padding: EdgeInsets.zero,
              //     iconSize: 28,
              //     onPressed: _toggleLogsExpanded,
              //     icon: Icon(
              //       _controller.expandedLogs
              //           ? Icons.visibility_outlined
              //           : Icons.visibility_off_outlined,
              //     ),
              //   ),
              // ),

              // SizedBox(
              //   width: 40,
              //   child: IconButton(
              //     padding: EdgeInsets.zero,
              //     iconSize: 28,
              //     onPressed: _cleanHistory,
              //     icon: const Icon(Icons.delete_outline),
              //   ),
              // ),
              // SizedBox(
              //   width: 40,
              //   child: IconButton(
              //     padding: EdgeInsets.zero,
              //     iconSize: 24,
              //     onPressed: () => _copyAllLogs(context),
              //     icon: const Icon(Icons.copy),
              //   ),
              // ),
              // SizedBox(
              //   width: 40,
              //   child: IconButton(
              //     padding: EdgeInsets.zero,
              //     iconSize: 28,
              //     onPressed: () => _showFilter(context),
              //     icon: const Icon(Icons.filter_alt_outlined),
              //   ),
              // ),
            ],
          ),
          body: TalkerHistoryBuilder(
            talker: widget.talker,
            builder: (context, data) {
              final filtredElements =
                  data.where((e) => _controller.filter.filter(e)).toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: filtredElements.length,
                itemBuilder: (_, i) {
                  final data = filtredElements[_controller.isLogOrderReversed
                      ? filtredElements.length - 1 - i
                      : i];
                  if (widget.itemsBuilder != null) {
                    return widget.itemsBuilder!.call(context, data);
                  }
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

  Future<void> _showFilter(BuildContext context) async {
    await showModalBottomSheet(
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
