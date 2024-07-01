import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorTypedLogsScreen extends StatelessWidget {
  const TalkerMonitorTypedLogsScreen({
    Key? key,
    required this.exceptions,
    required this.logColors,
    required this.typeName,
  }) : super(key: key);

  final String typeName;
  final List<TalkerData> exceptions;

  final LogColors logColors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: logColors.fromTalkerData(data),
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
