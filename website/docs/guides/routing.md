# Route Logging

Log navigation events in your Flutter app with `TalkerRouteObserver`. Works with Navigator, go_router, auto_route, and any NavigatorObserver-compatible router.

## Setup

### Navigator 1.0

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
  home: HomeScreen(),
)
```

### go_router

```dart
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

final router = GoRouter(
  observers: [TalkerRouteObserver(talker)],
  routes: [
    GoRoute(path: '/', builder: (_, __) => HomeScreen()),
    GoRoute(path: '/profile', builder: (_, __) => ProfileScreen()),
  ],
);

MaterialApp.router(routerConfig: router)
```

### auto_route v7+

```dart
import 'package:auto_route/auto_route.dart';
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

MaterialApp.router(
  routerConfig: _appRouter.config(
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
)
```

### auto_route (legacy)

```dart
MaterialApp.router(
  routerDelegate: AutoRouterDelegate(
    appRouter,
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
  routeInformationParser: appRouter.defaultRouteParser(),
)
```

## What Gets Logged

`TalkerRouteObserver` logs the following events:

| Event | Description | Example |
|-------|-------------|---------|
| **Push** | New route pushed onto the stack | `Route pushed: /profile` |
| **Pop** | Route popped from the stack | `Route popped: /profile` |
| **Replace** | Route replaced | `Route replaced: /login → /home` |
| **Remove** | Route removed | `Route removed: /splash` |

All navigation logs appear in the console, TalkerScreen, and history with the default route color (purple).

## Viewing in TalkerScreen

Navigate to `TalkerScreen` to see all route events alongside other logs:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

Route logs are color-coded and easily distinguishable from other log types. You can filter them in TalkerScreen by selecting the "Route" filter.

## Customization

### Custom Route Color

Change the color of route logs in the console:

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.route.key: AnsiPen()..cyan(),
    },
  ),
);
```

### Custom Route Title

```dart
final talker = Talker(
  settings: TalkerSettings(
    titles: {
      TalkerLogType.route.key: 'NAV',
    },
  ),
);
```

## Best Practices

1. **Use the same Talker instance** across your entire app — route logs, HTTP logs, BLoC events, and error reports all in one place.

2. **Combine with TalkerScreen** — during development, add a debug button or shake gesture to open `TalkerScreen` and see the full navigation history.

3. **Use with Crashlytics** — route logs make excellent breadcrumbs for crash reports. When combined with `TalkerObserver`, every navigation event is sent as a breadcrumb to Crashlytics or Sentry.
