import 'dart:async';

import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// It should be used for app functionality like
/// showing [SnackBar] or [Dialog] about error or exception
///
/// The [listener] be called when [Talker.stream] recive new message
///
///```dart
///TalkerListener(
///  talker: talker,
///  listener: (data) => _talkerListener(context, data),
///  child: Text('Your app or app screen'),
///),
///
/// void _talkerListener(BuildContext context, TalkerDataInterface data) {
///  if (data is TalkerException || data is TalkerError) {
///    ScaffoldMessenger.of(context).showSnackBar(
///      SnackBar(
///        content: Text(data.displayMessage),
///      ),
///    );
///  }
///}
///```
///
class TalkerListener extends StatefulWidget {
  const TalkerListener({
    Key? key,
    required this.child,
    required this.talker,
    required this.listener,
  }) : super(key: key);

  /// An [Talker] implementation
  final Talker talker;

  /// All application or screen of your application,
  /// where you need to listen [Talker] events
  final Widget child;

  /// Responsible for notify about [Talker] events.
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
