import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_monitor/talker_monitor_typed_logs_screen.dart';
import 'package:talker_flutter/src/ui/talker_monitor/widgets/widgets.dart';
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
  final Talker talker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(context.l10n.talkerMonitor),
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

          final httpRequests =
              data.where((e) => e.key == TalkerKey.httpRequest).toList();
          final httpErrors =
              data.where((e) => e.key == TalkerKey.httpError).toList();
          final httpResponses =
              data.where((e) => e.key == TalkerKey.httpResponse).toList();

          return CustomScrollView(
            slivers: [
              if (httpRequests.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    logs: httpRequests,
                    title: context.l10n.httpRequests,
                    color: Colors.green,
                    theme: theme,
                    icon: Icons.wifi,
                    subtitleWidget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: context.l10n
                                .httpRequestsExecuted(httpRequests.length),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.l10n
                                .successfulResponses(httpResponses.length),
                            style: const TextStyle(color: Colors.green),
                            children: [
                              TextSpan(
                                text: context.l10n.responsesReceived,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: context.l10n
                                .failureResponses(httpErrors.length),
                            style: const TextStyle(color: Colors.red),
                            children: [
                              TextSpan(
                                text: context.l10n.responsesReceived,
                                style: const TextStyle(color: Colors.white),
                              ),
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
                    theme: theme,
                    logs: errors,
                    title: context.l10n.errors,
                    color: theme.logColors.getByKey(TalkerKey.error),
                    icon: Icons.error_outline_rounded,
                    subtitle: context.l10n.unresolvedErrors(errors.length),
                    onTap: () => _openTypedLogsScreen(
                        context, errors, context.l10n.errors),
                  ),
                ),
              ],
              if (exceptions.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    theme: theme,
                    logs: exceptions,
                    title: context.l10n.exceptions,
                    color: theme.logColors.getByKey(TalkerKey.exception),
                    icon: Icons.error_outline_rounded,
                    subtitle:
                        context.l10n.unresolvedExceptions(exceptions.length),
                    onTap: () => _openTypedLogsScreen(
                        context, exceptions, context.l10n.exceptions),
                  ),
                ),
              ],
              if (warnings.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    theme: theme,
                    logs: warnings,
                    title: context.l10n.warnings,
                    color: theme.logColors.getByKey(TalkerKey.warning),
                    icon: Icons.warning_amber_rounded,
                    subtitle: context.l10n.warningsCount(warnings.length),
                    onTap: () => _openTypedLogsScreen(
                        context, warnings, context.l10n.warnings),
                  ),
                ),
              ],
              if (infos.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    theme: theme,
                    logs: infos,
                    title: context.l10n.infos,
                    color: theme.logColors.getByKey(TalkerKey.info),
                    icon: Icons.info_outline_rounded,
                    subtitle: context.l10n.infoLogsCount(infos.length),
                    onTap: () => _openTypedLogsScreen(
                        context, infos, context.l10n.infos),
                  ),
                ),
              ],
              if (verboseDebug.isNotEmpty) ...[
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: TalkerMonitorCard(
                    theme: theme,
                    logs: verboseDebug,
                    title: context.l10n.verboseDebug,
                    color: theme.logColors.getByKey(TalkerKey.verbose),
                    icon: Icons.remove_red_eye_outlined,
                    subtitle:
                        context.l10n.verboseDebugLogsCount(verboseDebug.length),
                    onTap: () => _openTypedLogsScreen(
                      context,
                      verboseDebug,
                      context.l10n.verboseDebug,
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

  void _openTypedLogsScreen(
    BuildContext context,
    List<TalkerData> logs,
    String typeName,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TalkerMonitorTypedLogsScreen(
          exceptions: logs,
          theme: theme,
          typeName: typeName,
        ),
      ),
    );
  }
}
