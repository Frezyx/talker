# Talker

## Setup
First of all you need to [setup talker for dart](../guide/get-started)

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

## Exceptions and Errors handling
To catch errors, talker has 3 methods for different signatures

 - **handle()** Handle everything (Errors and Exceptions)
```dart
try {
  // your code...
} catch (e, st) {
  talker.handle(e, 'Eception in ...', st);
}
```

 - **handleException()** Handle only Exceptions
```dart
try {
  // your code...
} on Exception catch (e, st) {
  talker.handleException(e, 'Exception in ...', st);
}
```

 - **handleError()** Handle only Errors
```dart
try {
  // your code...
} on Error catch (e, st) {
  talker.handleError(e, 'Error in ...', st);
}
```

## Stream
Common stream to sent all processed events **TalkerDataInterface**
occurred errors **TalkerError**'s, exceptions **TalkerException**'s
and logs **TalkerLog**'s that have been sent
You can connect a listener to it and catch the received errors

Or you can add your observer **TalkerObserver** in the settings
```dart
talker.stream.listen((event) {
    if (event is TalkerException) {}
    if (event is TalkerError) {}
    if (event is TalkerLog) {}
}
```

## History
The history stores all information about all events like
occurred errors **TalkerError**'s, exceptions **TalkerException**'s
and logs **TalkerLog**s that have been sent
```dart
/// Displays all logs text from the history
print(talker.history.text);
```