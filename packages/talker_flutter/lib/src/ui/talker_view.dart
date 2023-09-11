import 'package:flutter/foundation.dart';
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
    required this.talker,
    super.key,
    this.theme = const TalkerScreenTheme(),
    this.appBarTitle,
    this.itemsBuilder,
    this.appBarLeading,
  });

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

  @override
  State<TalkerView> createState() => _TalkerViewState();
}

class _TalkerViewState extends State<TalkerView> {
  final GroupButtonController _titlesController = GroupButtonController();
  late final TalkerViewController _controller = TalkerViewController();
  late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TalkerScreenTheme talkerTheme = widget.theme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => TalkerBuilder(
        talker: widget.talker,
        builder: (BuildContext context, List<TalkerDataInterface> data) {
          final List<TalkerDataInterface> filteredElements = data
              .where(
                (TalkerDataInterface e) => _controller.filter.filter(e),
              )
              .toList();
          final List<String> titles =
              data.map((TalkerDataInterface e) => e.title).toList();
          final List<String> unicTitles = titles.toSet().toList();
          return CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              TalkerViewAppBar(
                title: widget.appBarTitle,
                leading: widget.appBarLeading,
                talker: widget.talker,
                talkerTheme: talkerTheme,
                titilesController: _titlesController,
                titles: titles,
                unicTitles: unicTitles,
                controller: _controller,
                onMonitorTap: () => _openTalkerMonitor(context),
                onActionsTap: () => _showActionsBottomSheet(context),
                onSettingsTap: () => _openTalkerSettings(context, talkerTheme),
                onToggleTitle: _onToggleTitle,
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 8)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    final TalkerDataInterface data =
                        _getListItem(filteredElements, i);
                    if (widget.itemsBuilder != null) {
                      return widget.itemsBuilder!.call(context, data);
                    }
                    return TalkerDataCard(
                      data: data,
                      backgroundColor: widget.theme.cardColor,
                      onTap: () => _copyTalkerDataItemText(data),
                      expanded: _controller.expandedLogs,
                    );
                  },
                  childCount: filteredElements.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onToggleTitle({
    required bool selected,
    required String title,
  }) {
    if (selected) {
      _controller.addFilterTitle(title);
    } else {
      _controller.removeFilterTitle(title);
    }
  }

  TalkerDataInterface _getListItem(
    List<TalkerDataInterface> filteredElements,
    int i,
  ) {
    final TalkerDataInterface data = filteredElements[
        _controller.isLogOrderReversed ? filteredElements.length - 1 - i : i];
    return data;
  }

  void _openTalkerSettings(BuildContext context, TalkerScreenTheme theme) {
    final ValueNotifier<Talker> talker = ValueNotifier<Talker>(widget.talker);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => TalkerSettingsBottomSheet(
        talkerScreenTheme: theme,
        talker: talker,
      ),
    );
  }

  void _openTalkerMonitor(
    BuildContext context,
  ) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TalkerMonitor(
            theme: widget.theme,
            talker: widget.talker,
          ),
        ),
      );

  void _copyTalkerDataItemText(
    TalkerDataInterface data,
  ) {
    final String text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(
    BuildContext context,
    String text,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _showActionsBottomSheet(
    BuildContext context,
  ) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) => TalkerActionsBottomSheet(
          actions: <TalkerActionItem>[
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
        ),
      );

  Future<void> _shareLogsInFile() async {
    if (kIsWeb) {
      _controller.downloadLogsFile(widget.talker.history.text);
    } else {
      final String path = await _controller.saveLogsInFile(
        widget.talker.history.text,
      );
      await Share.shareXFiles(
        <XFile>[
          XFile(path),
        ],
      );
    }
  }

  void _cleanHistory() {
    widget.talker.cleanHistory();
    _controller.update();
  }

  void _toggleLogsExpanded() =>
      _controller.expandedLogs = !_controller.expandedLogs;

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: widget.talker.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }
}
