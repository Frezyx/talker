import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> downloadFile(String logs) async {
  final dir = await getTemporaryDirectory();
  final dirPath = dir.path;
  final fmtDate = DateTime.now().toString().replaceAll(":", " ");
  final file =
      await File('$dirPath/talker_logs_$fmtDate.txt').create(recursive: true);
  await file.writeAsString(logs);
  await Share.shareXFiles(
    <XFile>[
      XFile(file.path),
    ],
  );
}
