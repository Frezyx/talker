import 'dart:io';

Future<void> downloadFile(String logs) async {
  final dir = await Directory.systemTemp.createTemp('talker_logs');
  final dirPath = dir.path;
  final fmtDate = DateTime.now().toString().replaceAll(":", " ");
  final file =
      await File('$dirPath/talker_logs_$fmtDate.txt').create(recursive: true);
  await file.writeAsString(logs);
}
