# Talker

## Setup
First of all you need to [setup talker for dart](../guide/get-started)

## Methods
Talker have logging and error/exception handling methods

## Logging

 - **log()**  Default log method. You can pass all custom arguments.
```dart
talker.log(
    'Server error',
    logLevel: LogLevel.critical,
    additional: {
      "status": 500,
      "error": "Internal Server Error",
    },
    exception: Exception('...'),
    stackTrace: stackTrace,
    pen: AnsiPen()..red(),
);
```

 - **critical()**  Critical log method. For the most terrible situations.
```dart
talker.critical('❌ Houston, we have a problem!');
```

 - **error()**  Error log method. For report an error.
```dart
talker.error('🚨 The service is not available');
```

 - **debug()**  Debug log method. Logs for debugging.
```dart
talker.debug('We have a 🪲, but user can`t see this message');
```

 - **warning()**  Warning log method. For report an warning.
```dart
talker.warning('❗ It`s not an error, but not good situation ');
```

 - **verbose()**  Verbose log method. For report as much information as you possibly can.
```dart
talker.verbose('The application is running in debug mode');
```

 - **info()**  Info log method. For important information.
```dart
talker.info('Recive token from firebase');
```

 - **good()**  Good log method. For very good news.
```dart
talker.good('✅ Big calculation is finished without exceptions!');
```

 - **logTyped()** Custom log messaging method. You can implement your own custom log type and send it to Talker. 
```dart
class HttpTalkerLog extends TalkerLog {
  HttpTalkerLog(String message) : super(message);

  @override
  AnsiPen get pen => AnsiPen()..xterm(49);

  @override
  String generateTextMessage() {
    return pen.write(message);
  }

  //You can add here response model of your request
  final httpLog = HttpTalkerLog('Http status: 200');
  talker.logTyped(httpLog);
```