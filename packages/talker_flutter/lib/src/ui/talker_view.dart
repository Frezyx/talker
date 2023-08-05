import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor.dart';
import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';
import 'package:talker_flutter/src/ui/widgets/talker_view_appbar.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_actions/talker_actions.dart';

class TalkerView extends StatefulWidget {
  const TalkerView({
    Key? key,
    required this.talker,
    required this.theme,
    required this.appBarTitle,
    required this.controller,
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

  final TalkerScreenController controller;

  @override
  State<TalkerView> createState() => _TalkerViewState();
}

class _TalkerViewState extends State<TalkerView> {
  final _titilesController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    final talkerTheme = widget.theme;
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return TalkerBuilder(
          talker: widget.talker,
          builder: (context, data) {
            final filtredElements =
                data.where((e) => widget.controller.filter.filter(e)).toList();
            final titles = data.map((e) => e.title).toList();
            final unicTitles = titles.toSet().toList();
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                TalkerViewAppBar(
                  title: widget.appBarTitle,
                  talker: widget.talker,
                  talkerTheme: talkerTheme,
                  titilesController: _titilesController,
                  titles: titles,
                  unicTitles: unicTitles,
                  controller: widget.controller,
                  onMonitorTap: () => _openTalkerMonitor(context),
                  onActionsTap: () => _showActionsBottomSheet(context),
                  onSettingsTap: () =>
                      _openTalkerSettings(context, talkerTheme),
                  onToggleTitle: _onToggleTitle,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 8)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final data = _getListItem(filtredElements, i);
                      if (widget.itemsBuilder != null) {
                        return widget.itemsBuilder!.call(context, data);
                      }
                      return TalkerDataCard(
                        data: data,
                        onTap: () => _copyTalkerDataItemText(data),
                        expanded: widget.controller.expandedLogs,
                      );
                    },
                    childCount: filtredElements.length,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      widget.controller.addFilterTitle(title);
    } else {
      widget.controller.removeFilterTitle(title);
    }
  }

  TalkerDataInterface _getListItem(
    List<TalkerDataInterface> filtredElements,
    int i,
  ) {
    final data = filtredElements[widget.controller.isLogOrderReversed
        ? filtredElements.length - 1 - i
        : i];
    return data;
  }

  void _openTalkerSettings(BuildContext context, TalkerScreenTheme theme) {
    final talker = ValueNotifier(widget.talker);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return TalkerSettingsBottomSheet(
          talkerScreenTheme: theme,
          talker: talker,
        );
      },
    );
  }

  void _openTalkerMonitor(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerMonitor(
          theme: widget.theme,
          talker: widget.talker,
        ),
      ),
    );
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _showActionsBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TalkerActionsBottomSheet(
          actions: [
            TalkerActionItem(
              onTap: widget.controller.toggleLogOrder,
              title: 'Reverse logs',
              icon: Icons.swap_vert,
            ),
            TalkerActionItem(
              onTap: () => _copyAllLogs(context),
              title: 'Copy all logs',
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: _toggleLogsExpanded,
              title: widget.controller.expandedLogs
                  ? 'Collapse logs'
                  : 'Expand logs',
              icon: widget.controller.expandedLogs
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            TalkerActionItem(
              onTap: _cleanHistory,
              title: 'Clean history',
              icon: Icons.delete_outline,
            ),
            TalkerActionItem(
              onTap: _shareLogsInFile,
              title: 'Share logs file',
              icon: Icons.ios_share_outlined,
            ),
          ],
          talkerScreenTheme: widget.theme,
        );
      },
    );
  }

  Future<void> _shareLogsInFile() async {
    final path = await widget.controller.saveLogsInFile(
      widget.talker.history.text,
    );
    // ignore: deprecated_member_use
    await Share.shareFilesWithResult([path]);
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    widget.controller.update();
  }

  void _toggleLogsExpanded() {
    widget.controller.expandedLogs = widget.controller.expandedLogs;
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.talker.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }
}
