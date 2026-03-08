# talker_logger

<a href="https://pub.dev/packages/talker_logger"><img src="https://img.shields.io/pub/v/talker_logger.svg" alt="Pub"></a>

Customizable pretty logger for Dart/Flutter apps. Can be used as a standalone package or as part of the Talker ecosystem.

## Installation

```yaml
dependencies:
  talker_logger: ^5.1.13
```

## Basic Usage

```dart
import 'package:talker_logger/talker_logger.dart';

final logger = TalkerLogger();

logger.debug('debug');
logger.info('info');
logger.warning('warning');
logger.error('error');
logger.critical('critical');
logger.good('good');
logger.verbose('verbose');
```

## Custom Log Level

Use the `log()` method to specify level and color:

```dart
logger.log('custom message', level: LogLevel.info);
logger.log('colored log', pen: AnsiPen()..xterm(49));
```

## Log Levels

| Level | Description |
|-------|-------------|
| `LogLevel.critical` | Critical errors that require immediate attention |
| `LogLevel.error` | Runtime errors |
| `LogLevel.warning` | Potential issues |
| `LogLevel.info` | Informational messages |
| `LogLevel.debug` | Debug information |
| `LogLevel.verbose` | Detailed tracing information |
| `LogLevel.good` | Positive status messages |

## Filtering

Filter logs by setting the minimum log level:

```dart
final logger = TalkerLogger(
  settings: const TalkerLoggerSettings(
    level: LogLevel.critical,
  ),
);

// This will print
logger.critical('critical error');

// This will NOT print (level is below critical)
logger.info('info message');
```

## Custom Formatting

### Built-in Formatter Customization

```dart
final logger = TalkerLogger(
  settings: TalkerLoggerSettings(
    colors: {
      LogLevel.critical: AnsiPen()..yellow(),
      LogLevel.error: AnsiPen()..yellow(),
      LogLevel.info: AnsiPen()..yellow(),
    },
    maxLineWidth: 20,
    lineSymbol: '#',
    enableColors: true,
  ),
);
```

### Custom Formatter

Implement your own `LoggerFormatter`:

```dart
class ColoredLoggerFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final coloredMsg = msg
        .split('\n')
        .map((e) => details.pen.write(e))
        .toList()
        .join('\n');
    return coloredMsg;
  }
}

final logger = TalkerLogger(
  formatter: ColoredLoggerFormatter(),
);

logger.debug('debug');
logger.info('info');
logger.warning('warning');
logger.error('error');
```

## TalkerLoggerSettings

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `level` | `LogLevel` | `LogLevel.verbose` | Minimum log level to output |
| `enableColors` | `bool` | `true` | Whether to use ANSI colors in output |
| `maxLineWidth` | `int` | `110` | Maximum width of log line decorations |
| `lineSymbol` | `String` | `'─'` | Character used for line decorations |
| `colors` | `Map<LogLevel, AnsiPen>` | _(defaults)_ | Custom colors for each log level |

## Custom Output

You can redirect where logs are printed:

```dart
final logger = TalkerLogger(
  output: (message) {
    // Send to file, remote server, etc.
    myCustomOutput(message);
  },
);
```

## API Reference

Full API documentation is available on [pub.dev](https://pub.dev/documentation/talker_logger/latest/).
