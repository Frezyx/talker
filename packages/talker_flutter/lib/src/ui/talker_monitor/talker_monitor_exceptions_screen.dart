import 'package:flutter/material.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/src/ui/ui.dart';
import 'package:talker_flutter/src/ui/widgets/cards/talker_data_card.dart';

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
                return TalkerDataCard(data: data);
              },
              childCount: exceptions.length,
            ),
          ),
        ],
      ),
    );
  }
}
