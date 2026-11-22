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
    this.maxDisplayedLogs = 500,
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

  /// Maximum number of log entries to display in the list.
  /// Older entries beyond this limit are not rendered, which prevents
  /// UI freezes when the log history grows large.
  /// Set to 0 to display all logs (not recommended for large histories).
  /// Defaults to 500.
  final int maxDisplayedLogs;

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

  // Cached filtered results to avoid recomputing on every build
  List<TalkerData> _cachedFiltered = [];
  int _lastSourceLength = -1;
  int _lastFilterHash = -1;

  int get _filterHash => Object.hash(
        _controller.filter.enabledKeys.length,
        _controller.filter.searchQuery,
        _controller.isPaused,
        _controller.filter.enabledKeys.hashCode,
      );

  List<TalkerData> _getFilteredLogs(List<TalkerData> source) {
    final currentHash = _filterHash;
    if (source.length == _lastSourceLength && currentHash == _lastFilterHash) {
      return _cachedFiltered;
    }

    _lastSourceLength = source.length;
    _lastFilterHash = currentHash;

    // Cap the source list to prevent processing thousands of entries
    final maxLogs = widget.maxDisplayedLogs;
    final capped = maxLogs > 0 && source.length > maxLogs
        ? source.sublist(source.length - maxLogs)
        : source;

    _cachedFiltered =
        capped.where((e) => _controller.filter.filter(e)).toList();
    return _cachedFiltered;
  }

  @override
  Widget build(BuildContext context) {
    final talkerTheme = widget.theme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // When paused, use frozen snapshot; otherwise use live history
          // via TalkerBuilder which throttles stream updates.
          if (_controller.isPaused) {
            return _buildLogList(
              _controller.frozenLogs,
              talkerTheme,
            );
          }
          return TalkerBuilder(
            talker: widget.talker,
            builder: (context, data) {
              return _buildLogList(data, talkerTheme);
            },
          );
        },
      ),
    );
  }

  Widget _buildLogList(List<TalkerData> data, TalkerScreenTheme talkerTheme) {
    final filteredElements = _getFilteredLogs(data);

    // Compute keys from capped source for accurate filter chip counts
    final maxLogs = widget.maxDisplayedLogs;
    final cappedData = maxLogs > 0 && data.length > maxLogs
        ? data.sublist(data.length - maxLogs)
        : data;
    final keys = cappedData.map((e) => e.key).toList();
    final uniqKeys = keys.toSet().toList();

    return CustomScrollView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        TalkerViewAppBar(
          keys: keys,
          uniqKeys: uniqKeys,
          title: _controller.isPaused
              ? '${widget.appBarTitle ?? 'Interrupted'} (Paused)'
              : widget.appBarTitle,
          leading: widget.appBarLeading,
          talker: widget.talker,
          talkerTheme: talkerTheme,
          controller: _controller,
          onMonitorTap: () => _openTalkerMonitor(context),
          onActionsTap: () => _openActions(context),
          onSettingsTap: () => _openSettings(context, talkerTheme),
          onToggleKey: _onToggleKey,
          onPauseTap: _controller.togglePause,
          isPaused: _controller.isPaused,
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final index = _controller.isLogOrderReversed
                  ? filteredElements.length - 1 - i
                  : i;
              final data = filteredElements[index];
              if (widget.itemsBuilder != null) {
                return RepaintBoundary(
                  child: widget.itemsBuilder!.call(context, data),
                );
              }
              return RepaintBoundary(
                child: TalkerDataCard(
                  key: ValueKey(index),
                  data: data,
                  backgroundColor: widget.theme.cardColor,
                  onCopyTap: () => _copyTalkerDataItemText(data),
                  expanded: _controller.expandedLogs,
                  color: data.getFlutterColor(widget.theme),
                ),
              );
            },
            childCount: filteredElements.length,
          ),
        ),
      ],
    );
  }

  void _onToggleKey(String key, bool selected) {
    final action =
        selected ? _controller.addFilterKey : _controller.removeFilterKey;
    action(key);
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
    _showSnackBar(context, 'Log item is copied in clipboard');
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
    _lastSourceLength = -1; // Invalidate cache
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
        text: _cachedFiltered.text(
            timeFormat: widget.talker.settings.timeFormat)));
    _showSnackBar(context, 'All filtered logs copied in buffer');
  }
}
