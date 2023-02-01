import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_button/group_button.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/src/controller/talker_screen_controller.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor.dart';
import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';
import 'package:talker_flutter/src/ui/ui.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'talker_actions/talker_actions.dart';

/// UI view for output of all Talker logs and errors
class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.appBarTitle = 'Flutter talker',
    this.theme = const TalkerScreenTheme(),
    this.itemsBuilder,
    this.aditionalSettings,
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

  /// Additional settings for talker extensions
  /// like talker_dio_logger [https://pub.dev/packages/talker_dio_logger],
  /// talker_bloc_logger [https://pub.dev/packages/talker_bloc_logger], etc
  final List<AdditionalTalkerSetting>? aditionalSettings;

  @override
  State<TalkerScreen> createState() => _TalkerScreenState();
}

class _TalkerScreenState extends State<TalkerScreen> {
  final _controller = TalkerScreenController();
  final _typesController = GroupButtonController();
  final _titilesController = GroupButtonController();

  @override
  Widget build(BuildContext context) {
    final talkerScreenTheme = widget.theme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: talkerScreenTheme.backgroudColor,
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
                  onPressed: () => _openTalkerSettings(
                    context,
                    talkerScreenTheme,
                  ),
                  icon: const Icon(Icons.settings_rounded),
                ),
              ),
              SizedBox(
                width: 40,
                child: _MonitorButton(
                  talker: widget.talker,
                  onPressed: () => _openTalkerMonitor(context),
                ),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 28,
                  onPressed: () => _showFilter(context),
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: SizedBox(
                  width: 28,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 28,
                    onPressed: () => _showActionsBottomSheet(context),
                    icon: const Icon(Icons.more_vert_rounded),
                  ),
                ),
              ),
            ],
          ),
          body: TalkerHistoryBuilder(
            talker: widget.talker,
            builder: (context, data) {
              final filtredElements =
                  data.where((e) => _controller.filter.filter(e)).toList();
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
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
                    // options: talkerScreenTheme,
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
    final path = await _controller.saveLogsInFile(
      widget.talker.history.text,
    );
    // ignore: deprecated_member_use
    await Share.shareFilesWithResult([path]);
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    final text = data is FlutterTalkerDataInterface
        ? data.generateFlutterTextMessage()
        : data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  Future<void> _showFilter(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
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

class _MonitorButton extends StatelessWidget {
  const _MonitorButton({
    Key? key,
    required this.talker,
    required this.onPressed,
  }) : super(key: key);

  final TalkerInterface talker;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TalkerHistoryBuilder(
      talker: talker,
      builder: (context, data) {
        final haveErrors = data
            .where((e) => e is TalkerError || e is TalkerException)
            .isNotEmpty;
        return Stack(
          children: [
            Center(
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 28,
                onPressed: onPressed,
                icon: const Icon(Icons.monitor_heart_outlined),
              ),
            ),
            if (haveErrors)
              Positioned(
                right: 6,
                top: 15,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  height: 5,
                  width: 5,
                ),
              ),
          ],
        );
      },
    );
  }
}
