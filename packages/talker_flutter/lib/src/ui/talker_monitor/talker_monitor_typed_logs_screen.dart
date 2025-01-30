import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorTypedLogsScreen extends StatelessWidget {
  const TalkerMonitorTypedLogsScreen({
    super.key,
    required this.exceptions,
    required this.theme,
    required this.typeName,
  });

  final String typeName;
  final TalkerScreenTheme theme;
  final List<TalkerData> exceptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: Text('Talker Monitor $typeName'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final data = exceptions[index];
                return TalkerDataCard(
                  data: data,
                  onCopyTap: () => _copyTalkerDataItemText(context, data),
                  color: data.getFlutterColor(theme),
                  backgroundColor: theme.cardColor,
                );
              },
              childCount: exceptions.length,
            ),
          ),
        ],
      ),
    );
  }

  void _copyTalkerDataItemText(BuildContext context, TalkerData data) {
    final text = data.generateTextMessage();
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(context, 'Log item is copied in clipboard');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
