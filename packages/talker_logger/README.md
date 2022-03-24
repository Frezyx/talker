# talker_logger
### [Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

Core [talker](https://github.com/Frezyx/talker) package <br>
The package is designed to to make simple and extended logs <br>
Can be used separately from the main parent package <br>
In order to use all the functionality - go to the [main page](https://github.com/Frezyx/talker)

## Get Started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_logger: ^0.7.0
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
logger.log('info', level: LogLevel.info);
logger.log('custom pen log', pen: AnsiPen()..xterm(49));
```

**Result** <br>
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logger/base_example.png?raw=true">

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


More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker_logger/example/talker_logger_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker_logger/lib/src/talker_logger_interface.dart)

