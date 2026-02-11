import 'dart:js_interop';

import 'package:web/web.dart';

Future<void> downloadFile(String logs) async {
  final jsArray = [logs.toJS].toJS;
  final blob = Blob(jsArray, BlobPropertyBag(type: 'text/plain'));

  final fmtDate = DateTime.now().toString().replaceAll(':', ' ');

  final anchor = HTMLAnchorElement()
    ..href = URL.createObjectURL(blob)
    ..download = 'talker_logs_$fmtDate.txt'
    ..click()
    ..remove();

  URL.revokeObjectURL(anchor.href);
}
