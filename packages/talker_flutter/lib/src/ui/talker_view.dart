import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor.dart';
import 'package:talker_flutter/src/ui/widgets/talker_view_appbar.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_actions/talker_actions.dart';

class TalkerView extends StatefulWidget {
  const TalkerView({
    Key? key,
    required this.talker,
    this.controller,
    this.scrollController,
    this.theme = const TalkerScreenTheme(),
    this.appBarTitle,
    this.itemsBuilder,
    this.appBarLeading,
    required this.customSettings,
    this.isLogsExpanded = true,
    this.isLogOrderReversed = true,
  }) : super(key: key);

  /// Talker implementation
  final Talker talker;

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Screen [AppBar] title
  final String? appBarTitle;

  /// Screen [AppBar] leading
  final Widget? appBarLeading;

  /// Optional Builder to customize
  /// log items cards in list
  final TalkerDataBuilder? itemsBuilder;

  final TalkerViewController? controller;

  final ScrollController? scrollController;

  /// Optional custom settings
  final ValueNotifier<List<CustomSettingsGroup>>? customSettings;

  /// {@template talker_flutter_is_log_exapanded}
  /// If true, all logs will be initially expanded
  /// {@endtemplate}
  final bool isLogsExpanded;

  /// {@template talker_flutter_is_log_order_reversed}
  /// if true, latest logs will be on the top of the list
  /// {@endtemplate}
  final bool isLogOrderReversed;

  @override
  State<TalkerView> createState() => _TalkerViewState();
}

class _TalkerViewState extends State<TalkerView> {
  final _titlesController = GroupButtonController();
  late final _controller = widget.controller ??
      TalkerViewController(
        expandedLogs: widget.isLogsExpanded,
        isLogOrderReversed: widget.isLogOrderReversed,
      );

  @override
  Widget build(BuildContext context) {
    final talkerTheme = widget.theme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return TalkerBuilder(
            talker: widget.talker,
            builder: (context, data) {
              final filteredElements = filteredLogs(data);
              final titles = data.map((e) => e.title).toList();
              final uniqTitles = titles.toSet().toList();

              return CustomScrollView(
                controller: widget.scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  TalkerViewAppBar(
                    title: widget.appBarTitle,
                    leading: widget.appBarLeading,
                    talker: widget.talker,
                    talkerTheme: talkerTheme,
                    titlesController: _titlesController,
                    titles: titles,
                    uniqTitles: uniqTitles,
                    controller: _controller,
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
                        final data = _getListItem(filteredElements, i);
                        if (widget.itemsBuilder != null) {
                          return widget.itemsBuilder!.call(context, data);
                        }
                        return TalkerDataCard(
                          data: data,
                          backgroundColor: widget.theme.cardColor,
                          onCopyTap: () => _copyTalkerDataItemText(data),
                          expanded: _controller.expandedLogs,
                          color: data.getFlutterColor(widget.theme),
                        );
                      },
                      childCount: filteredElements.length,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<TalkerData> filteredLogs(List<TalkerData> data) =>
      data.where((e) => _controller.filter.filter(e)).toList();

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      _controller.addFilterTitle(title);
    } else {
      _controller.removeFilterTitle(title);
    }
  }

  TalkerData _getListItem(
    List<TalkerData> filteredElements,
    int i,
  ) {
    final data = filteredElements[
        _controller.isLogOrderReversed ? filteredElements.length - 1 - i : i];
    return data;
  }

  void _openTalkerSettings(BuildContext context, TalkerScreenTheme theme) {
    final talker = ValueNotifier(widget.talker);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return ValueListenableBuilder<List<CustomSettingsGroup>>(
            valueListenable: widget.customSettings ?? ValueNotifier([]),
            builder: (context, customSettings, child) {
              return TalkerSettingsBottomSheet(
                talkerScreenTheme: theme,
                talker: talker,
                customSettings: customSettings,
              );
            });
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

  void _copyTalkerDataItemText(TalkerData data) {
    final text =
        data.generateTextMessage(timeFormat: widget.talker.settings.timeFormat);
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
              onTap: _controller.toggleLogOrder,
              title: 'Reverse logs',
              icon: Icons.swap_vert,
            ),
            TalkerActionItem(
              onTap: () => _copyAllLogs(context),
              title: 'Copy all logs',
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: () => _copyFilteredLogs(context),
              title: 'Copy filtered logs',
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: _toggleLogsExpanded,
              title: _controller.expandedLogs ? 'Collapse logs' : 'Expand logs',
              icon: _controller.expandedLogs
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
    await _controller.downloadLogsFile(
      widget.talker.history.text(timeFormat: widget.talker.settings.timeFormat),
    );
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    _controller.update();
  }

  void _toggleLogsExpanded() {
    _controller.toggleExpandedLogs();
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(
        text: widget.talker.history
            .text(timeFormat: widget.talker.settings.timeFormat)));
    _showSnackBar(context, 'All logs copied in buffer');
  }

  void _copyFilteredLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(
        text: filteredLogs(widget.talker.history)
            .text(timeFormat: widget.talker.settings.timeFormat)));
    _showSnackBar(context, 'All filtered logs copied in buffer');
  }
}
