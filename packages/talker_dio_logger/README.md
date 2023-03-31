# talker_dio_logger
Lightweight and customizable [dio](https://pub.dev/packages/dio) http client logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_dio_logger"><img src="https://img.shields.io/pub/v/talker_dio_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Preview
This is how the logs of your http requests will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_dio_logger/preview_new.png?raw=true)

## Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_dio_logger: ^1.3.0
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
          printResponseMessage: true,
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

