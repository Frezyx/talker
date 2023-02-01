import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/src/extensions/iterable.dart';
import 'package:talker_flutter/src/ui/talker_actions/talker_actions_bottom_sheet.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorHttpScreen extends StatefulWidget {
  const TalkerMonitorHttpScreen({
    Key? key,
    required this.talker,
    required this.talkerScreenTheme,
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerScreenTheme talkerScreenTheme;

  @override
  State<TalkerMonitorHttpScreen> createState() =>
      _TalkerMonitorHttpScreenState();
}

class _TalkerMonitorHttpScreenState extends State<TalkerMonitorHttpScreen> {
  var _expandRequestLogs = true;
  final _controller = TalkerScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Http Monitor'),
        actions: [
          IconButton(
            onPressed: () => _showBottomSheet(context),
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      backgroundColor: widget.talkerScreenTheme.backgroudColor,
      body: TalkerHistoryBuilder(
        talker: widget.talker,
        builder: (context, data) {
          final reqRespPairMap = _mapHttpLogsToPairs(data);
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pair = reqRespPairMap[index];
                    return Column(
                      children: [
                        TalkerDataCard(
                          data: pair.key,
                          margin: EdgeInsets.zero,
                          expanded: _expandRequestLogs,
                          onTap: () =>
                              _copyTalkerDataItemText(context, pair.key),
                        ),
                        if (pair.value != null) ...[
                          Container(
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 28),
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                vertical: BorderSide(
                                  width: 1.5,
                                  color: pair.value is HttpErrorLog
                                      ? LogLevel.error.color
                                      : pair.value is HttpResponseLog
                                          ? httpResponseLogColor
                                          : Colors.white,
                                ),
                              ),
                            ),
                          ),
                          TalkerDataCard(
                            data: pair.value!,
                            expanded: _expandRequestLogs,
                            onTap: () =>
                                _copyTalkerDataItemText(context, pair.value!),
                          ),
                        ],
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                  childCount: reqRespPairMap.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _copyTalkerDataItemText(BuildContext context, TalkerDataInterface data) {
    final text = data is FlutterTalkerDataInterface
        ? data.generateFlutterTextMessage()
        : data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  List<MapEntry<HttpRequestLog, TalkerLog?>> _mapHttpLogsToPairs(
      List<TalkerDataInterface> data) {
    final httpRequests = data.whereType<HttpRequestLog>().toList();
    final httpErrors = data.whereType<HttpErrorLog>().toList();
    final httpResponses = data.whereType<HttpResponseLog>().toList();

    final reqRespPairMap = httpRequests.map((e) {
      final httpReponse =
          httpResponses.firstWhereOrNull((r) => e.message == r.message);
      if (httpReponse != null) {
        return MapEntry(e, httpReponse);
      }
      final httpError =
          httpErrors.firstWhereOrNull((err) => e.message == err.message);
      if (httpError != null) {
        return MapEntry(e, httpError);
      }
      return MapEntry(e, null);
    }).toList();
    return reqRespPairMap;
  }

  void _showBottomSheet(BuildContext context) async {
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
              onTap: () => _toggleRequestLogsExpanded(!_expandRequestLogs),
              title: _expandRequestLogs ? 'Collapse logs' : 'Expand logs',
              icon: _expandRequestLogs
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
            ),
            TalkerActionItem(
              onTap: _shareLogsInFile,
              title: 'Share logs file',
              icon: Icons.ios_share_outlined,
            ),
          ],
          talkerScreenTheme: widget.talkerScreenTheme,
        );
      },
    );
  }

  void _toggleRequestLogsExpanded(bool value) {
    setState(() => _expandRequestLogs = value);
  }

  Future<void> _shareLogsInFile() async {
    final path = await _controller.saveLogsInFile(
      _httpLogs.text,
    );
    // ignore: deprecated_member_use
    await Share.shareFilesWithResult([path]);
  }

  List<TalkerDataInterface> get _httpLogs => widget.talker.history
      .where((e) =>
          e is HttpRequestLog || e is HttpErrorLog || e is HttpResponseLog)
      .toList();

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _httpLogs.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }
}
