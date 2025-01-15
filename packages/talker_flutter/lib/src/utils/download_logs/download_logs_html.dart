// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

Future<void> downloadFile(String logs) async {
  final Blob blob = Blob(<String>[logs], 'text/plain', 'native');
  final String fmtDate = DateTime.now().toString().replaceAll(':', ' ');

  AnchorElement(
    href: Url.createObjectUrlFromBlob(blob),
  )
    ..setAttribute('download', 'talker_logs_$fmtDate.txt')
    ..click();
}
