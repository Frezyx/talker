# talker_flutter

<a href="https://pub.dev/packages/talker_flutter"><img src="https://img.shields.io/pub/v/talker_flutter.svg" alt="Pub"></a>

Flutter extensions for Talker — colored logs, in-app log viewer, error alerts, route observer, and more.

## Installation

```yaml
dependencies:
  talker_flutter: ^5.1.13
```

## Setup

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();
```

::: tip Why TalkerFlutter.init()?
This method uses the optimal logging output for each platform:
- **Web** — `print()`
- **iOS / macOS** — `dart:developer.log` (preserves colored output)
- **Android / Windows / Linux** — `debugPrint` (avoids message truncation)
:::

You get the same `Talker` instance as `Talker()` but with platform-optimized logging.

## TalkerScreen

A full-featured log viewer widget. View, filter, search, and share all logs directly in your app.

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

### TalkerScreen Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `talker` | `Talker` | _required_ | Talker instance to display logs from |
| `theme` | `TalkerScreenTheme` | `TalkerScreenTheme()` | Visual theme configuration |
| `appBarTitle` | `String` | `'Talker'` | Custom title for the app bar |
| `appBarLeading` | `Widget?` | `null` | Custom leading widget for the app bar |
| `itemsBuilder` | `TalkerDataBuilder?` | `null` | Custom builder for log item cards |
| `customSettings` | `List<CustomSettingsGroup>` | `[]` | Additional settings groups |
| `isLogsExpanded` | `bool` | `true` | Whether logs are initially expanded |
| `isLogOrderReversed` | `bool` | `true` | Whether latest logs appear on top |

### Custom Theme Colors

Customize colors for any log type in TalkerScreen:

```dart
TalkerScreen(
  talker: talker,
  theme: const TalkerScreenTheme(
    logColors: {
      // Override default log type colors
      TalkerLogType.httpResponse.key: Color(0xFF26FF3C),
      TalkerLogType.error.key: Colors.redAccent,
      TalkerLogType.info.key: Color.fromARGB(255, 0, 255, 247),

      // Custom log keys
      'custom_log_key': Colors.green,
    },
  ),
)
```

### TalkerScreenTheme

```dart
TalkerScreenTheme(
  backgroundColor: Colors.grey[800]!,
  cardColor: Colors.grey[700]!,
  textColor: Colors.white,
  logColors: {
    // Your log colors...
  },
)
```

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `backgroundColor` | `Color` | Dark gray | Screen background color |
| `cardColor` | `Color` | Gray | Log card background color |
| `textColor` | `Color` | White | Log text color |
| `logColors` | `Map<String, Color>` | _(defaults)_ | Custom colors for log types |

## TalkerView

Same as `TalkerScreen` but without `Scaffold` — for embedding in your own layouts:

```dart
Scaffold(
  appBar: AppBar(title: Text('My Custom Screen')),
  body: TalkerView(
    talker: talker,
    theme: const TalkerScreenTheme(),
  ),
)
```

## TalkerMonitor

A quick status overview showing counts of HTTP requests, exceptions, errors, warnings, etc.

`TalkerMonitor` is accessible from the `TalkerScreen` settings page. It provides a filtered summary of your application's health at a glance.

## TalkerWrapper

Show error alerts and status messages automatically in your UI:

```dart
TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
  ),
  child: MyApp(),
)
```

### TalkerWrapperOptions

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enableErrorAlerts` | `bool` | `true` | Show SnackBars for errors |
| `enableExceptionAlerts` | `bool` | `true` | Show SnackBars for exceptions |

## TalkerListener

Listen to Talker events in the widget tree:

```dart
TalkerListener(
  talker: talker,
  listener: (data) {
    if (data is TalkerException || data is TalkerError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data.displayMessage)),
      );
    }
  },
  child: MyApp(),
)
```

## TalkerBuilder

Build UI reactively based on Talker logs:

```dart
TalkerBuilder(
  talker: talker,
  builder: (context, data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(data[index].message));
      },
    );
  },
)
```

## TalkerRouteObserver

Log navigation events. Works with any routing package.

### Navigator

```dart
MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
)
```

### go_router

```dart
GoRouter(
  observers: [TalkerRouteObserver(talker)],
)
```

### auto_route v7+

```dart
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
)
```

See the full [Route Logging](/guides/routing) guide for more details.

## runTalkerZonedGuarded

Catch all uncaught errors in your app zone:

```dart
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();

  runTalkerZonedGuarded(
    talker,
    () => runApp(MyApp()),
  );
}
```

## API Reference

Full API documentation is available on [pub.dev](https://pub.dev/documentation/talker_flutter/latest/).
