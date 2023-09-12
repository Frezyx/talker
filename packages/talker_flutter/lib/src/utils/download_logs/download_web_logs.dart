import 'package:universal_html/html.dart';

void downloadFile(String logs) {
  final Blob blob = Blob(<String>[logs], 'text/plain', 'native');
  final String fmtDate = DateTime.now().toString().replaceAll(':', ' ');

  AnchorElement(
    href: Url.createObjectUrlFromBlob(blob),
  )
    ..setAttribute('download', 'talker_logs_$fmtDate.txt')
    ..click();
}
