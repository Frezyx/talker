import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
    this.options = const TalkerScreenOptions(),
  }) : super(key: key);

  final TalkerInterface talker;
  final TalkerScreenOptions options;

  @override
  State<TalkerScreen> createState() => _TalkerScreenState();
}

class _TalkerScreenState extends State<TalkerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.options.backgroudColor,
      appBar: AppBar(
        title: const Text('Flutter talker'),
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 28,
              onPressed: _cleanHistory,
              icon: const Icon(Icons.delete_outline),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 24,
              onPressed: () => _copyAllLogs(context),
              icon: const Icon(Icons.copy),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 28,
              onPressed: _cleanHistory,
              icon: const Icon(Icons.filter_alt_outlined),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: widget.talker.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.talker.history.length,
            itemBuilder: (_, i) {
              final data = widget.talker.history[i];
              return TalkerDataCard(
                data: data,
                onTap: () => _copyTalkerDataItemText(data),
                options: widget.options,
              );
            },
          );
        },
      ),
    );
  }

  void _copyTalkerDataItemText(TalkerDataInterface data) {
    Clipboard.setData(
      ClipboardData(
        text: data.generateTextMessage(),
      ),
    );
    _showSnackBar(context, 'Log item is copied for console');
  }

  void _cleanHistory() {
    Talker.instance.cleanHistory();
    setState(() {});
  }

  void _copyAllLogs(BuildContext context) {
    Clipboard.setData(ClipboardData(text: Talker.instance.history.text));
    _showSnackBar(context, 'All logs copied in buffer');
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }
}
