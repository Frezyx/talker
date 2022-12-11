import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/src/ui/widgets/cards/talker_data_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorExceptionsScreen extends StatelessWidget {
  const TalkerMonitorExceptionsScreen({
    Key? key,
    required this.exceptions,
    required this.theme,
  }) : super(key: key);

  final TalkerScreenTheme theme;
  final List<TalkerDataInterface> exceptions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroudColor,
      appBar: AppBar(
        title: const Text('Talker Monitor Exceptions'),
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
                  onTap: () => _copyTalkerDataItemText(context, data),
                );
              },
              childCount: exceptions.length,
            ),
          ),
        ],
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
}
