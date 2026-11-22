# talker

<a href="https://pub.dev/packages/talker"><img src="https://img.shields.io/pub/v/talker.svg" alt="Pub"></a>

The core Dart package for logging and error handling. Works in any Dart project — server-side, CLI, or Flutter.

## Installation

```yaml
dependencies:
  talker: ^5.1.13
```

## Basic Logging

```dart
import 'package:talker/talker.dart';

final talker = Talker();

// Log messages with different levels
talker.info('App started');
talker.debug('Loading configuration...');
talker.warning('Cache is almost full');
talker.error('Failed to save file');
talker.critical('Database connection lost!');
talker.verbose('Detailed trace information');
talker.good('Operation completed successfully!');
```

## Error Handling

Handle exceptions and errors with full `StackTrace` support:

```dart
try {
  throw Exception('Something went wrong');
} catch (e, st) {
  talker.handle(e, st, 'Exception in data processing');
}
```

The `handle()` method automatically distinguishes between `Exception` and `Error` types.

## Advanced Logging

Use the `log()` method for maximum control:

```dart
talker.log(
  'Server error',
  logLevel: LogLevel.critical,
  exception: Exception('Connection timeout'),
  stackTrace: stackTrace,
  pen: AnsiPen()..red(),
);
```

## TalkerSettings

Configure Talker behavior through `TalkerSettings`:

```dart
final talker = Talker(
  settings: TalkerSettings(
    /// Enable/disable all talker processes
    enabled: true,
    /// Enable/disable saving logs in history
    useHistory: true,
    /// Maximum number of history items
    maxHistoryItems: 1000,
    /// Enable/disable console output
    useConsoleLogs: true,
    /// Time format for log timestamps
    timeFormat: TimeFormat.timeAndSeconds,
  ),
);
```

### Settings Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enabled` | `bool` | `true` | Master switch for all Talker operations |
| `useHistory` | `bool` | `true` | Whether to save logs in history |
| `maxHistoryItems` | `int` | `1000` | Maximum number of stored history items |
| `useConsoleLogs` | `bool` | `true` | Whether to print logs to console |
| `timeFormat` | `TimeFormat` | `timeAndSeconds` | Timestamp format for logs |
| `titles` | `Map<String, String>` | _(defaults)_ | Custom titles for log types |
| `colors` | `Map<String, AnsiPen>` | _(defaults)_ | Custom colors for log types |

## Custom Log Colors

Set your own color for any type of log:

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.httpResponse.key: AnsiPen()..red(),
      TalkerLogType.error.key: AnsiPen()..green(),
      TalkerLogType.info.key: AnsiPen()..blue(),

      // Custom log keys
      'custom_log_key': AnsiPen()..yellow(),
    },
  ),
);
```

### Default Color Scheme

| Log Type | Color |
|----------|-------|
| `critical` | Red |
| `error` | Red |
| `exception` | Red |
| `warning` | Yellow |
| `info` | Blue |
| `debug` | Gray |
| `verbose` | Gray |
| `httpRequest` | Pink (xterm 219) |
| `httpResponse` | Green (xterm 46) |
| `httpError` | Red |
| `route` | Purple (xterm 135) |

## Custom Log Titles

Override the default titles for any log type:

```dart
final talker = Talker(
  settings: TalkerSettings(
    titles: {
      TalkerLogType.exception.key: 'Whatever you want',
      TalkerLogType.error.key: 'E',
      TalkerLogType.info.key: 'i',

      // Custom log keys
      'custom_log_key': 'My Custom Title',
    },
  ),
);
```

## Custom Log Types

Create your own log type by extending `TalkerLog`:

```dart
class HttpLog extends TalkerLog {
  HttpLog(String super.message);

  static const logKey = 'http_log';
  static final logTitle = 'HTTP';
  static final logPen = AnsiPen()..cyan();

  @override
  String get title => logTitle;

  @override
  String get key => logKey;

  @override
  AnsiPen get pen => logPen;
}

// Usage
talker.logCustom(HttpLog('GET /api/users — 200 OK'));
```

See the full guide on [Custom Log Types](/guides/custom-logs).

## TalkerObserver

Observe all Talker events from the outside — perfect for sending data to external services:

```dart
class MyTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    // Send to Crashlytics, Sentry, etc.
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    // Send to error tracking service
    super.onException(exception);
  }

  @override
  void onLog(TalkerDataInterface log) {
    // Send to Grafana, analytics backend, etc.
    super.onLog(log);
  }
}

final talker = Talker(observer: MyTalkerObserver());
```

See the [Crashlytics Integration](/guides/crashlytics) guide for a full example.

## Stream

Listen to all Talker events via a broadcast stream:

```dart
talker.stream.listen((data) {
  print('New event: ${data.message}');
});
```

## History

Access the full log history:

```dart
// Get all history
final logs = talker.history;

// Clear history
talker.cleanHistory();
```

## Filtering

Use `TalkerFilter` to select specific logs:

```dart
final talker = Talker(
  filter: BaseTalkerFilter(
    titles: ['error', 'exception'],
    types: [TalkerError, TalkerException],
  ),
);
```

## Enable / Disable

Control Talker at runtime:

```dart
// Stop all logging and error handling
talker.disable();

// Resume operations
talker.enable();
```

## Runtime Configuration

Reconfigure Talker after creation:

```dart
talker.configure(
  settings: TalkerSettings(enabled: true),
  logger: TalkerLogger(),
  observer: MyTalkerObserver(),
);
```

## API Reference

Full API documentation is available on [pub.dev](https://pub.dev/documentation/talker/latest/).
