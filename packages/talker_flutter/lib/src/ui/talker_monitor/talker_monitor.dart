import 'package:flutter/material.dart';
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

          return CustomScrollView(
            slivers: [
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
              )
            ],
          );
        },
      ),
    );
  }
}

class TalkerMonitorItem extends StatelessWidget {
  const TalkerMonitorItem({
    Key? key,
    required this.logs,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final List<TalkerDataInterface> logs;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 49, 49, 49),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
