import 'dart:io';

/// Saves logs to a temporary file in the system temp directory.
///
/// May throw [FileSystemException] while creating or writing the file.
Future<String> downloadFile(String logs, DateTime timestamp) async {
  final dirPath = Directory.systemTemp.path;
  final formattedDate = timestamp.toIso8601String().replaceAll(':', '-');
  final file = await File('$dirPath/talker_logs_$formattedDate.txt').create(
    recursive: true,
  );
  await file.writeAsString(logs);
  return file.path;
}
