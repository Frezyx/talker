import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor_typed_logs_screen.dart';
import 'package:talker_flutter/src/ui/talker_monitor/widgets/widgets.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitor extends StatelessWidget {
  const TalkerMonitor({
    Key? key,
    required this.talker,
    required this.logColors,
  }) : super(key: key);

  /// Talker implementation
  final Talker talker;

  final LogColors logColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Talker Monitor'),
        ),
      ),
      body: TalkerBuilder(
        talker: talker,
        builder: (context, data) {
          final logs = data.whereType<TalkerLog>().toList();
          final errors = data.whereType<TalkerError>().toList();
          final exceptions = data.whereType<TalkerException>().toList();
          final warnings =
              logs.where((e) => e.logLevel == LogLevel.warning).toList();

          final infos = logs.where((e) => e.logLevel == LogLevel.info).toList();
          final verboseDebug = logs
              .where((e) =>
                  e.logLevel == LogLevel.verbose ||
                  e.logLevel == LogLevel.debug)
              .toList();

          final httpRequests = data
              .where((e) => e.key == TalkerLogType.httpRequest.key)
              .toList();
          final httpErrors =
              data.where((e) => e.key == TalkerLogType.httpError.key).toList();
          final httpResponses = data
              .where((e) => e.key == TalkerLogType.httpResponse.key)
              .toList();

          return CustomScrollView(
            slivers: [
              if (httpRequests.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: httpRequests,
                    title: 'Http Requests',
                    color: Colors.green,
                    icon: Icons.wifi,
                    onTap: () => _openHttpMonitor(context),
                    subtitleWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '${httpRequests.length}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
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
                              TextSpan(text: ' responses received'),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: '${httpErrors.length} failure',
                            style: const TextStyle(color: Colors.red),
                            children: const [
                              TextSpan(text: ' responses received'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (errors.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: errors,
                    title: 'Errors',
                    color: logColors.getByType(TalkerLogType.error),
                    icon: Icons.error_outline_rounded,
                    subtitle:
                        'Application has ${errors.length} unresolved errors',
                    onTap: () =>
                        _openTypedLogsScreen(context, errors, 'Errors'),
                  ),
                ),
              ],
              if (exceptions.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: exceptions,
                    title: 'Exceptions',
                    color: logColors.getByType(TalkerLogType.exception),
                    icon: Icons.error_outline_rounded,
                    subtitle:
                        'Application has ${exceptions.length} unresolved exceptions',
                    onTap: () =>
                        _openTypedLogsScreen(context, exceptions, 'Exceptions'),
                  ),
                ),
              ],
              if (warnings.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: warnings,
                    title: 'Warnings',
                    color: logColors.getByType(TalkerLogType.warning),
                    icon: Icons.warning_amber_rounded,
                    subtitle: 'Application has ${warnings.length} warnings',
                    onTap: () =>
                        _openTypedLogsScreen(context, warnings, 'Warnings'),
                  ),
                ),
              ],
              if (infos.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: infos,
                    title: 'Infos',
                    color: logColors.getByType(TalkerLogType.info),
                    icon: Icons.info_outline_rounded,
                    subtitle: 'Info logs count: ${infos.length}',
                    onTap: () => _openTypedLogsScreen(context, infos, 'Infos'),
                  ),
                ),
              ],
              if (verboseDebug.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: verboseDebug,
                    title: 'Verbose & debug',
                    color: logColors.getByType(TalkerLogType.verbose),
                    icon: Icons.remove_red_eye_outlined,
                    subtitle:
                        'Verbose and debug logs count: ${verboseDebug.length}',
                    onTap: () => _openTypedLogsScreen(
                      context,
                      verboseDebug,
                      'Verbose & debug',
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

  void _openHttpMonitor(BuildContext context) {}

  void _openTypedLogsScreen(
    BuildContext context,
    List<TalkerData> logs,
    String typeName,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerMonitorTypedLogsScreen(
          exceptions: logs,
          typeName: typeName,
          logColors: logColors,
        ),
      ),
    );
  }
}
