import 'dart:js_interop';

import 'package:web/web.dart';

Future<void> downloadFile(String logs) async {
  final jsArray = JSArray.from<JSString>(logs.toJS as JSObject);
  final blob = Blob(jsArray, BlobPropertyBag(type: 'text/plain'));

  final fmtDate = DateTime.now().toString().replaceAll(':', ' ');

  final anchor = document.createElement('a') as HTMLAnchorElement
    ..href = URL.createObjectURL(blob)
    ..download = 'talker_logs_$fmtDate.txt'
    ..click();

  URL.revokeObjectURL(anchor.href);
}
