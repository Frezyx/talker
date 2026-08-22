# Quick Start

## Basic Usage (Dart)

Create a Talker instance and start logging:

```dart
import 'package:talker/talker.dart';

final talker = Talker();

void main() {
  // Log messages with different levels
  talker.info('App started');
  talker.debug('Loading configuration...');
  talker.warning('Cache is almost full');
  talker.good('User profile loaded!');
  talker.verbose('Detailed trace info');
  talker.critical('Database connection lost!');

  // Handle exceptions
  try {
    throw Exception('Something went wrong');
  } catch (e, st) {
    talker.handle(e, st, 'Failed to process data');
  }
}
```

## Flutter Usage

For Flutter apps, use `TalkerFlutter.init()` for optimal platform-specific logging:

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

void main() {
  // Handle exceptions and errors
  try {
    // your code...
  } catch (e, st) {
    talker.handle(e, st, 'Exception in ...');
  }

  // Log your app info
  talker.info('App is started');
  talker.critical('Houston, we have a problem!');
  talker.error('The service is not available');
}
```

::: tip Why TalkerFlutter.init()?
Most Flutter logging packages either cut messages in the console or can't display colored messages on iOS. `TalkerFlutter.init()` uses the optimal logging method for each platform:
- **Web** — uses `print()`
- **iOS / macOS** — uses `dart:developer.log`
- **Android / Windows / Linux** — uses `debugPrint`
:::

## View Logs In-App

Use `TalkerScreen` to browse logs directly in your app:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  ),
);
```

## Add HTTP Logging

If you use Dio, add logging with one line:

```dart
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```

## What's Next?

- Learn about [Talker core features](/packages/talker) — custom logs, colors, titles, observer
- Explore [Flutter widgets](/packages/talker-flutter) — TalkerScreen, TalkerMonitor, TalkerWrapper
- Set up [integrations](/integrations/dio) — Dio, BLoC, Riverpod, and more
- Read [guides](/guides/custom-logs) — custom log types, Crashlytics integration
