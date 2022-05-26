import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerRouteObserver extends NavigatorObserver {
  TalkerRouteObserver(this.talker);

  final TalkerInterface talker;

  @override
  void didPush(Route route, Route? previousRoute) {
    talker.logTyped(TalkerRouteLog(route));
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    talker.logTyped(TalkerRouteLog(route));
    super.didPop(route, previousRoute);
  }
}

class TalkerRouteLog extends TalkerLog {
  TalkerRouteLog(Route route) : super(route.settings.name ?? '');
}
