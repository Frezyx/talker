import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerAppScreen extends StatelessWidget {
  const TalkerAppScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TalkerScreen(
      talker: GetIt.instance<Talker>(),
    );
  }
}
