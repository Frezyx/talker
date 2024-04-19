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

<p align="center">For better understanding how it works check <a href="https://frezyx.github.io/talker">
Web Demo</a> page</p>
<p align="center">
<a href="https://frezyx.github.io/talker">
  <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/check_web_demo.png?raw=true" width="250px">
</a>
</p>

### Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_dio_logger: ^4.2.0
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

## Customization

To provide hight usage exp here are a lot of settings and customization fields in TalkerDioLoggerSettings. You can setup all wat you want. For example: 

### Off/on http request or reposnse logs

You can toggle reponse / request printing and headers including

```dart
final dio = Dio();
dio.interceptors.add(
    TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          // All http responses enabled for console logging
          printResponseData: true,
          // All http requests disabled for console logging
          printRequestData: false,
          // Reposnse logs including http - headers
          printResponseHeaders: true,
          // Request logs without http - headersa
          printRequestHeaders: false,
        ),
    ),
);
```

### Change http logs colors

Setup your custom http-log colors. You can set color for requests, responses and errors in TalkerDioLoggerSettings

```dart
TalkerDioLoggerSettings(
  // Blue http requests logs in console
  requestPen: AnsiPen()..blue(),
  // Green http responses logs in console
  responsePen: AnsiPen()..green(),
  // Error http logs in console
  errorPen: AnsiPen()..red(),
);
```

### Filter http logs

For example if your app has a private functionality and you don't need to store this functionality logs in talker - you can use filters

```dart
TalkerDioLoggerSettings(
  // All http request without "/secure" in path will be printed in console 
  requestFilter: (RequestOptions options) => !options.path.contains('/secure'),
  // All http responses with status codes different than 301 will be printed in console 
  responseFilter: (response) => response.statusCode != 301,
)
```

## Using with Talker
You can add your talker instance for TalkerDioLogger if your app already uses Talker.
In this case, all logs and errors will fall into your unified tracking system

```dart
final talker = Talker();
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```


## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️

