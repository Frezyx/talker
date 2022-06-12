import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerListener extends StatefulWidget {
  const TalkerListener({
    Key? key,
    required this.child,
    required this.talker,
    required this.listener,
  }) : super(key: key);

  final Talker talker;
  final Widget child;
  final Function(TalkerDataInterface data) listener;

  @override
  State<TalkerListener> createState() => _TalkerListenerState();
}

class _TalkerListenerState extends State<TalkerListener> {
  StreamSubscription<TalkerDataInterface>? _talkerSubscription;

  @override
  void initState() {
    _talkerSubscription = widget.talker.stream.listen((data) {
      widget.listener.call(data);
    });
    super.initState();
  }

  @override
  void dispose() {
    _talkerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
