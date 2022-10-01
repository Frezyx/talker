# talker_dio_logger
Lightweight and customizable [dio](https://pub.dev/packages/dio) http client logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀
## Preview
This is how the logs of your http requests will look in the console
![](../../docs/assets/talker_dio_logger/preview.png)

## Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_dio_logger: ^0.1.0
```

### Usage
Just add **TalkerDioLogger** to your dio instance and it will work

```dart
final dio = Dio();
dio.interceptors.add(
    TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
    ),
);
```

## Using with Talker
You can add your talker instance for TalkerDioLogger if your app already uses Talker.

In this case, all logs and errors will fall into your unified tracking system

```dart
final talker = Talker();
final dio = Dio();
dio.interceptors.add(
    TalkerDioLogger(
        talker: talker,
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
    ),
);
```

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️
