import 'dart:js_interop';

import 'package:web/web.dart';

Future<String> downloadFile(String logs, DateTime timestamp) async {
  final jsArray = [logs.toJS].toJS;
  final blob = Blob(jsArray, BlobPropertyBag(type: 'text/plain'));

  final formattedDate = timestamp.toIso8601String().replaceAll(':', '-');
  final fileName = 'talker_logs_$formattedDate.txt';

  final anchor = HTMLAnchorElement()
    ..href = URL.createObjectURL(blob)
    ..download = fileName
    ..click()
    ..remove();

  URL.revokeObjectURL(anchor.href);
  return fileName;
}
