import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// This class is used to override the default scroll behavior of the
/// [MaterialApp] widget.
///
/// The default scroll behavior of the [MaterialApp] widget is to only
/// scroll when the user is using a touch device. This class overrides
/// that behavior to allow scrolling when the user is using a mouse
/// device.
///
/// This class is used in the [MaterialApp.scrollBehavior] property.
///
/// See: https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag
class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.unknown,
      };
}
