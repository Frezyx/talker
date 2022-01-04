import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreen extends StatefulWidget {
  const TalkerScreen({
    Key? key,
    required this.talker,
  }) : super(key: key);

  final Talker talker;

  @override
  State<TalkerScreen> createState() => _TalkerScreenState();
}

class _TalkerScreenState extends State<TalkerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter talker'),
        actions: [
          SizedBox(
            width: 40,
            child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 28,
              onPressed: _cleanHistory,
              icon: const Icon(
                Icons.delete,
              ),
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
              return TalkerDataCard(data: data);
            },
          );
        },
      ),
    );
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
