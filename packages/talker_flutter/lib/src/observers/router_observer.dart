import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

/// Logging NavigatorObserver working on [Talker] base
/// This observer displays which routes were opened and closed in the application
class TalkerRouteObserver extends NavigatorObserver {
  TalkerRouteObserver(this.talker);

  final TalkerInterface talker;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(TalkerRouteLog(route: route));
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) {
      return;
    }
    talker.logTyped(TalkerRouteLog(route: route, isPush: false));
  }
}

class TalkerRouteLog extends FlutterTalkerLog {
  TalkerRouteLog({
    required Route route,
    bool isPush = true,
  }) : super(_createMessage(route, isPush));

  @override
  AnsiPen get pen => AnsiPen()..xterm(135);

  @override
  Color get color => const Color(0xFFAF5FFF);

  @override
  String get title => 'ROUTE';

  static String _createMessage(
    Route<dynamic> route,
    bool isPush,
  ) {
    final buffer = StringBuffer();
    buffer.write(isPush ? 'Open' : 'Close');
    buffer.write(' route named ');
    buffer.write(route.settings.name ?? 'null');

    final args = route.settings.arguments;
    if (args != null) {
      buffer.write('\nArguments: $args');
    }
    return buffer.toString();
  }
}
