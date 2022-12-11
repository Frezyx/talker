import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/extensions/iterable.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorHttpScreen extends StatelessWidget {
  const TalkerMonitorHttpScreen({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final TalkerInterface talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerHistoryBuilder(
        talker: talker,
        builder: (context, data) {
          final httpRequests = data.whereType<HttpRequestLog>().toList();
          final httpErrors = data.whereType<HttpErrorLog>().toList();
          final httpResponses = data.whereType<HttpResponseLog>().toList();

          final reqRespPairMap = httpRequests.map((e) {
            final httpReponse =
                httpResponses.firstWhereOrNull((r) => e.title == r.title);
            if (httpReponse != null) {
              return MapEntry(e, httpReponse);
            }
            final httpError =
                httpErrors.firstWhereOrNull((err) => e.title == err.title);
            if (httpReponse != null) {
              return MapEntry(e, httpError);
            }
            return MapEntry(e, null);
          }).toList();

          return Text(reqRespPairMap.toString());
        },
      ),
    );
  }
}
