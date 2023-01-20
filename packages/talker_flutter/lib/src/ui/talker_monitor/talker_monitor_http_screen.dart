import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/extensions/iterable.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
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
  var _expandResponseLogs = true;
  var _expandRequestLogs = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Http Monitor'),
        actions: [
          IconButton(
            onPressed: () => _showBottomSheet(context),
            icon: const Icon(Icons.tune),
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
                            expanded: _expandResponseLogs,
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
        return HttpMonitorSettingsBottomSheet(
          talkerScreenTheme: widget.talkerScreenTheme,
          onRequestLogsExpandToggled: _toggleRequestLogsExpanded,
          onResponseLogsExpandToggled: _toggleResponseLogsExpanded,
          initialExpandRequestLogs: _expandRequestLogs,
          initialExpandResponseLogs: _expandResponseLogs,
        );
      },
    );
  }

  void _toggleRequestLogsExpanded(bool value) {
    setState(() => _expandRequestLogs = value);
  }

  void _toggleResponseLogsExpanded(bool value) {
    setState(() => _expandResponseLogs = value);
  }
}

class HttpMonitorSettingsBottomSheet extends StatefulWidget {
  const HttpMonitorSettingsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.onResponseLogsExpandToggled,
    required this.onRequestLogsExpandToggled,
    required this.initialExpandResponseLogs,
    required this.initialExpandRequestLogs,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final bool initialExpandResponseLogs;
  final bool initialExpandRequestLogs;
  final ValueChanged<bool> onResponseLogsExpandToggled;
  final ValueChanged<bool> onRequestLogsExpandToggled;

  @override
  State<HttpMonitorSettingsBottomSheet> createState() =>
      _HttpMonitorSettingsBottomSheetState();
}

class _HttpMonitorSettingsBottomSheetState
    extends State<HttpMonitorSettingsBottomSheet> {
  late var _expandResponseLogs = widget.initialExpandResponseLogs;
  late var _expandRequestLogs = widget.initialExpandRequestLogs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseBottomSheet(
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Talker Http Monitor Settings',
                style: theme.textTheme.headline6
                    ?.copyWith(color: widget.talkerScreenTheme.textColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            value: _expandRequestLogs,
            title: Text(
              '${_expandRequestLogs ? 'Collapse' : 'Expand'} http-request logs',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: widget.talkerScreenTheme.textColor,
                fontSize: 18,
              ),
            ),
            onChanged: (value) => _toggleRequestLogsExpanded(value ?? false),
          ),
          Divider(
            height: 1,
            color: widget.talkerScreenTheme.iconsColor.withOpacity(0.5),
            endIndent: 10,
            indent: 10,
          ),
          CheckboxListTile(
            value: _expandResponseLogs,
            title: Text(
              '${_expandResponseLogs ? 'Collapse' : 'Expand'} http-response logs',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: widget.talkerScreenTheme.textColor,
                fontSize: 18,
              ),
            ),
            onChanged: (value) => _toggleResponseLogsExpanded(value ?? false),
          ),
        ],
      ),
    );
  }

  void _toggleRequestLogsExpanded(bool value) {
    setState(() => _expandRequestLogs = value);
    widget.onRequestLogsExpandToggled(value);
  }

  void _toggleResponseLogsExpanded(bool value) {
    setState(() => _expandResponseLogs = value);
    widget.onResponseLogsExpandToggled(value);
  }
}
