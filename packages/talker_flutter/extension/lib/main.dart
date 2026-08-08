import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

import 'src/talker_logs_screen.dart';

void main() {
  runApp(const TalkerDevToolsExtension());
}

class TalkerDevToolsExtension extends StatelessWidget {
  const TalkerDevToolsExtension({super.key});

  @override
  Widget build(BuildContext context) {
    return const DevToolsExtension(
      child: TalkerLogsScreen(),
    );
  }
}
