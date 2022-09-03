import 'dart:convert';

import 'package:talker/talker.dart';

final talker = Talker();
const encoder = JsonEncoder.withIndent('  ');

void main() {
  talker.error('It looks like this button is not working');
  talker.info('The food for lunch has already arrived');
  talker.warning('Something bad has happened, but the app is still working');
  talker.logTyped(
    HttpLog(
      'User id is loaded',
      data: {'userId': 1234},
    ),
  );
}

class HttpLog extends TalkerLog {
  HttpLog(
    String message, {
    this.data,
  }) : super(message);

  final dynamic data;

  @override
  AnsiPen get pen => AnsiPen()..cyan();

  @override
  String get title => 'HTTP';

  @override
  String generateTextMessage() {
    var msg = '[$displayTitle] $message';

    if (data != null) {
      final prettyData = encoder.convert(data);
      msg += '\nDATA:$prettyData';
    }
    return msg;
  }
}
