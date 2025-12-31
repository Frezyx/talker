import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.customSettings = const [],
    this.isLogsExpanded = true,
    this.isLogOrderReversed = true,
    this.enableSettings = true,
    this.enableMonitor = true,
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
  final List<CustomSettingsGroup> customSettings;

  /// {@template talker_flutter_is_log_exapanded}
  /// If true, all logs will be initially expanded
  /// {@endtemplate}
  final bool isLogsExpanded;

  /// {@template talker_flutter_is_log_order_reversed}
  /// if true, latest logs will be on the top of the list
  /// {@endtemplate}
  final bool isLogOrderReversed;

  /// Enable or disable buttons in AppBar
  final bool enableSettings;

  /// Enable or disable buttons in AppBar
  final bool enableMonitor;

  @override
  State<TalkerView> createState() => _TalkerViewState();
}

class _TalkerViewState extends State<TalkerView> {
  late final _controller = widget.controller ??
      TalkerViewController(
        talker: widget.talker,
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
              final filteredElements = _getFilteredLogs(data);
              final keys = data.map((e) => e.key).toList();
              final uniqKeys = keys.toSet().toList();

              return CustomScrollView(
                controller: widget.scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  TalkerViewAppBar(
                    keys: keys,
                    uniqKeys: uniqKeys,
                    title: widget.appBarTitle,
                    leading: widget.appBarLeading,
                    talker: widget.talker,
                    talkerTheme: talkerTheme,
                    controller: _controller,
                    onMonitorTap: widget.enableMonitor
                        ? () => _openTalkerMonitor(context)
                        : null,
                    onActionsTap: () => _openActions(context),
                    onSettingsTap: widget.enableSettings
                        ? () => _openSettings(context, talkerTheme)
                        : null,
                    onToggleKey: _onToggleKey,
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

  List<TalkerData> _getFilteredLogs(List<TalkerData> data) =>
      data.where((e) => _controller.filter.filter(e)).toList();

  void _onToggleKey(String key, bool selected) {
    final action =
        selected ? _controller.addFilterKey : _controller.removeFilterKey;
    action(key);
  }

  TalkerData _getListItem(
    List<TalkerData> filteredElements,
    int i,
  ) {
    final data = filteredElements[
        _controller.isLogOrderReversed ? filteredElements.length - 1 - i : i];
    return data;
  }

  void _openSettings(BuildContext context, TalkerScreenTheme theme) {
    final talker = ValueNotifier(widget.talker);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return TalkerSettingsBottomSheet(
          talkerScreenTheme: theme,
          talker: talker,
          customSettings: widget.customSettings,
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

  void _copyTalkerDataItemText(TalkerData data) {
    final text =
        data.generateTextMessage(timeFormat: widget.talker.settings.timeFormat);
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, context.l10n.logItemCopied);
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  Future<void> _openActions(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TalkerActionsBottomSheet(
          actions: [
            TalkerActionItem(
              onTap: _controller.toggleLogOrder,
              title: context.l10n.reverseLogs,
              icon: Icons.swap_vert,
            ),
            TalkerActionItem(
              onTap: () => _copyAllLogs(context),
              title: context.l10n.copyAllLogs,
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: () => _copyFilteredLogs(context),
              title: context.l10n.copyFilteredLogs,
              icon: Icons.copy,
            ),
            TalkerActionItem(
              onTap: _toggleLogsExpanded,
              title: _controller.expandedLogs
                  ? context.l10n.collapseLogs
                  : context.l10n.expandLogs,
              icon: _controller.expandedLogs
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            TalkerActionItem(
              onTap: _cleanHistory,
              title: context.l10n.cleanHistory,
              icon: Icons.delete_outline,
            ),
            TalkerActionItem(
              onTap: _shareLogsInFile,
              title: context.l10n.shareLogsFile,
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
    _showSnackBar(context, context.l10n.allLogsCopied);
  }

  void _copyFilteredLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(
        text: _getFilteredLogs(widget.talker.history)
            .text(timeFormat: widget.talker.settings.timeFormat)));
    _showSnackBar(context, context.l10n.filteredLogsCopied);
  }
}
