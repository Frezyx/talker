import 'dart:developer';
import 'dart:js_interop';

import 'package:web/web.dart';

void outputLog(String message) {
  try {
    // Note: \uFFFD is a special character that can cause a crash on web when logged
    // Encountered while logging some italian stuff with accents (èéàùìò)
    message
        .split('\n')
        .forEach((it) => console.log(it.replaceAll('\uFFFD', '').toJS));
  } catch (e) {
    message.split('\n').forEach((it) => log(it, name: 'Talker'));
  }
}
