import 'dart:js_interop';

import 'package:web/web.dart';

void outputLog(String message) =>
    message.split('\n').forEach((it) => console.log(it.toJS));
