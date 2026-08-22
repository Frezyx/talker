import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef TalkerWidgetBuilder = Widget Function(
  BuildContext context,
  List<TalkerData> data,
);

/// Listens to [Talker.stream] and rebuilds with throttling to prevent
/// excessive widget rebuilds during high-frequency logging.
class TalkerBuilder extends StatefulWidget {
  const TalkerBuilder({
    Key? key,
    required this.talker,
    required this.builder,
  }) : super(key: key);

  final Talker talker;
  final TalkerWidgetBuilder builder;

  @override
  State<TalkerBuilder> createState() => _TalkerBuilderState();
}

class _TalkerBuilderState extends State<TalkerBuilder> {
  StreamSubscription<TalkerData>? _subscription;
  Timer? _throttleTimer;

  /// Trailing-edge throttle window. During high-frequency logging,
  /// at most one rebuild fires per window (after the burst settles).
  static const _throttleDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant TalkerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.talker != widget.talker) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.talker.stream.listen((_) {
      // Trailing-edge throttle: reset the timer on every event,
      // so setState fires only once after the burst settles.
      _throttleTimer?.cancel();
      _throttleTimer = Timer(_throttleDuration, () {
        if (mounted) setState(() {});
      });
    });
  }

  void _unsubscribe() {
    _throttleTimer?.cancel();
    _throttleTimer = null;
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.talker.history);
  }
}
