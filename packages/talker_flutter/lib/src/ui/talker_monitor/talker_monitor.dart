import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor_item.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitor extends StatelessWidget {
  const TalkerMonitor({
    Key? key,
    required this.theme,
    required this.talker,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme theme;

  /// Talker implementation
  final TalkerInterface talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroudColor,
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Talker Monitor'),
        ),
      ),
      body: TalkerHistoryBuilder(
        talker: talker,
        builder: (context, data) {
          final errors = data.whereType<TalkerError>().toList();
          final exceptions = data.whereType<TalkerException>().toList();
          final httpRequests = data.whereType<HttpRequestLog>().toList();
          final httpErrors = data.whereType<HttpErrorLog>().toList();
          final httpResponses = data.whereType<HttpResponseLog>().toList();

          return CustomScrollView(
            slivers: [
              if (errors.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorItem(
                    logs: errors,
                    title: 'Errors',
                    color: Colors.red,
                    icon: Icons.error_outline_rounded,
                    subtitle:
                        'Application has ${errors.length} unresolved errors',
                  ),
                ),
              ],
              if (exceptions.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorItem(
                    logs: exceptions,
                    title: 'Exceptions',
                    color: Colors.red,
                    icon: Icons.error_outline_rounded,
                    subtitle:
                        'Application has ${exceptions.length} unresolved exceptions',
                  ),
                ),
              ],
              if (httpRequests.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorItem(
                    logs: httpRequests,
                    title: 'Http Requests',
                    color: Colors.green,
                    icon: Icons.wifi,
                    subtitleWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${httpRequests.length}',
                            style: const TextStyle(color: Colors.white),
                            children: const [
                              TextSpan(text: ' http requests executed')
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${httpResponses.length} successful',
                            style: const TextStyle(color: Colors.green),
                            children: const [
                              TextSpan(
                                text: ' responses recived',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${httpErrors.length} failure',
                            style: const TextStyle(color: Colors.red),
                            children: const [
                              TextSpan(
                                text: ' responses recived',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
