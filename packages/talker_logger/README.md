# talker_logger
### [Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

Core [talker](https://github.com/Frezyx/talker) package <br>
The package is designed to to make simple and extended logs <br>
Can be used separately from the main parent package <br>
In order to use all the functionality - go to the [main page](https://github.com/Frezyx/talker)

<p>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_logger"><img src="https://img.shields.io/pub/v/talker_logger.svg" alt="Pub"></a>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Get Started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_logger: ^2.2.1
```

### Easy to use
Create TalkerLogger instance and call prepared methods

```dart
// Create instance
final logger = TalkerLogger();
// Log messages
logger.debug('debug');
logger.info('info');
logger.critical('critical');
logger.error('error');
logger.fine('fine');
logger.good('good');
logger.warning('warning');
logger.verbose('verbose');
logger.log('log with level info', level: LogLevel.info);
logger.log('custom pen log', pen: AnsiPen()..xterm(49));
```

**Result** <br>
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logger/extended_logs_example.png?raw=true">

More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker_logger/example/talker_logger_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker_logger/lib/src/talker_logger_interface.dart)

## Customization
This logger has simple settings that can change output

### 1. Filtering
```dart
  final logger = TalkerLogger(
    settings: const TalkerLoggerSettings(
      // Set current logging level
      level: LogLevel.critical,
    ),
  );

  // Works as before
  logger.critical('critical');
  // Does not work
  logger.info('info');
```

**Result** <br>
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logger/only_critical_example.png?raw=true">

### 2. Formating

Create your own LoggerFormatter implementation
For example - ColoredLoggerFormatter that makes messages only with colors
```dart
class ColoredLoggerFormatter implements LoggerFormatter {
  @override
  String fmt(LogDetails details, TalkerLoggerSettings settings) {
    final msg = details.message?.toString() ?? '';
    final coloredMsg =
        msg.split('\n').map((e) => details.pen.write(e)).toList().join('\n');
    return coloredMsg;
  }
}
```

And add formatter for TalkerLogger constructor
```dart
  final logger = TalkerLogger(
    formatter: ColoredLoggerFormatter(),
  );

  logger.debug('debug');
  logger.info('info');
  logger.warning('warning');
  logger.error('error');
```

**Result** <br>
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logger/example_custom_impl_formatter.png?raw=true">

Or you can make simple customization with default formatters
```dart
  final logger = TalkerLogger(
    settings: TalkerLoggerSettings(
      colors: {
        LogLevel.critical: AnsiPen()..yellow(),
        LogLevel.error: AnsiPen()..yellow(),
        LogLevel.info: AnsiPen()..yellow(),
        LogLevel.fine: AnsiPen()..yellow(),
      },
      maxLineWidth: 20,
      lineSymbol: '#',
      enableColors: true,
    ),
  );

  logger.info('info');
  logger.critical('critical');
  logger.error('error');
  logger.fine('fine');
```

**Result** <br>
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logger/formated_example.png?raw=true">

## Coverage
[![](https://codecov.io/gh/Frezyx/talker/branch/master/graphs/sunburst.svg)](https://codecov.io/gh/Frezyx/talker/branch/master)


More examples you can get [here](https://github.com/Frezyx/talker/blob/master/packages/talker_logger/example/talker_logger_example.dart)

