import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/extensions/iterable.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorHttpScreen extends StatelessWidget {
  const TalkerMonitorHttpScreen({
    Key? key,
    required this.talker,
    required this.theme,
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerScreenTheme theme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Http Monitor'),
      ),
      backgroundColor: theme.backgroudColor,
      body: TalkerHistoryBuilder(
        talker: talker,
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
                          TalkerDataCard(data: pair.value!),
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
}
