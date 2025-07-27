# talker_chopper_logger
A lightweight, flexible HTTP client logger for [Chopper](https://pub.dev/packages/chopper) built on the [Talker](https://pub.dev/packages/talker) platform,
offering advanced exception handling and logging for Dart and Flutter applications.

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_chopper_logger"><img src="https://img.shields.io/pub/v/talker_chopper_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Preview
This is how the logs of your http requests will look in the console
![](/docs/assets/talker_chopper_logger/preview.png?raw=true)

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
  talker_chopper_logger: ^5.0.0-dev.10
```

### Usage
Simply include the **TalkerChopperLogger** in your Chopper client’s interceptors list to enable it.

```dart
final client = ChopperClient(
  /// ... other chopper settings
  interceptors: [
    TalkerChopperLogger(
      settings: const TalkerChopperLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  ],
);
```

## Customization

To offer extensive functionality, [TalkerChopperLoggerSettings](lib/talker_chopper_logger_settings.dart) provides 
numerous configuration settings and customization options. You can adjust everything to suit your needs. For example:

### Enable or disable HTTP request or response logs

You can toggle response / request printing and headers including

```dart
final client = ChopperClient(
  /// ... other chopper settings
  interceptors: [
    TalkerChopperLogger(
      talker: _talker,
      settings: const TalkerChopperLoggerSettings(
        // All HTTP responses enabled for console logging
        printResponseData: true,
        // All HTTP requests disabled for console logging
        printRequestData: false,
        // Response logs including HTTP - headers
        printResponseHeaders: true,
        // Request logs without HTTP - headers
        printRequestHeaders: false,
      ),
    ),
  ],
);
```

### Print HTTP request curl command

You can print the curl command for the HTTP request in the console.
This is useful for debugging and testing purposes.

```dart
final client = ChopperClient(
  /// ... other chopper settings
  interceptors: [
    TalkerChopperLogger(
      talker: _talker,
      settings: const TalkerChopperLoggerSettings(
        // Print curl command for HTTP request
        printRequestCurl: true,
      ),
    ),
  ],
);
```

### Hiding sensitive HTTP request headers

You can hide sensitive HTTP request headers such as `Authorization` or `Cookie` in the console logs.
This is useful for security purposes.

```dart
final client = ChopperClient(
  /// ... other chopper settings
  interceptors: [
    TalkerChopperLogger(
      talker: _talker,
      settings: const TalkerChopperLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        // Hide sensitive HTTP request headers
        hiddenHeaders: {
          'authorization',
          'cookie',
        },
      ),
    ),
  ],
);
```

### Change HTTP logs colors

Customize your HTTP log colors by defining specific colors for requests, responses, and errors in 
[TalkerChopperLoggerSettings](lib/talker_chopper_logger_settings.dart)

```dart
TalkerChopperLoggerSettings(
  // Blue HTTP requests logs in console
  requestPen: AnsiPen()..blue(),
  // Green HTTP responses logs in console
  responsePen: AnsiPen()..green(),
  // Error HTTP logs in console
  errorPen: AnsiPen()..red(),
);
```

### Filter HTTP logs

For instance, if your app includes private functionality that you prefer not to log with talker, you can apply filters.

```dart
TalkerChopperLoggerSettings(
  // All http request without "/secure" in path will be printed in console 
  requestFilter: (Request request) => !request.url.path.contains('/secure'),
  // All http responses with status codes different than 301 will be printed in console 
  responseFilter: (Response response) => response.statusCode != 301,
)
```

## Using with existing Talker instance

If your application already uses Talker, simply inject your Talker instance into TalkerChopperLogger so that all logs 
and errors integrate into your centralized tracking system.

```dart
final talker = Talker();
final client = ChopperClient(
  /// ... other chopper settings
  interceptors: [
    TalkerChopperLogger(
      talker: talker,
      settings: const TalkerChopperLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  ],
);
```

## Additional information

This project is actively being developed and welcomes your pull-requests and issue submissions.
Thank you for your support. ❤️

