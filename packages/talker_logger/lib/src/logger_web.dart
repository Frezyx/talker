import 'dart:js_interop';

import 'package:web/web.dart';

// Note: \uFFFD is a special character that can cause a crash on web when logged
// Encountered while logging some italian stuff with accents (èéàùìò), not always happening
// Probably related to enconding issues.
void outputLog(String message) => message
    .split('\n')
    .forEach((it) => console.log(it.replaceAll('\uFFFD', '').toJS));
