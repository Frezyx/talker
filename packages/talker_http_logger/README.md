# talker_http_logger
Lightweight and customizable [http_interceptor](https://pub.dev/packages/http_interceptor) client logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_http_logger"><img src="https://img.shields.io/pub/v/talker_http_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Preview
This is how the logs of your http requests will look in the console
![](/docs/assets/talker_http_logger/preview.png?raw=true)

## Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_http_logger: ^4.9.3
```

### Usage
Just add **TalkerHttpLogger** to your [**InterceptedClient**](https://pub.dev/packages/http_interceptor) instance and it will work

```dart
import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';

void main() async {
  final client = InterceptedClient.build(interceptors: [
    TalkerHttpLogger(
      settings: const TalkerHttpLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  ]);

  await client.get("https://google.com".toUri());
}
```

## Using with Talker
You can add your talker instance for TalkerHttpLogger if your app already uses Talker.

In this case, all logs and errors will fall into your unified tracking system

```dart
import 'package:http_interceptor/http_interceptor.dart';
import 'package:talker_http_logger/talker_http_logger.dart';

void main() async {
  final _talker = Talker();
  final client = InterceptedClient.build(
    /// ... other settings
    interceptors: [
      TalkerHttpLogger(
        /// ... other Talker HTTP Logger settings
        talker: _talker,
      ),
    ]
  );

  await client.get("https://google.com".toUri());
```

### Print HTTP request curl command

You can print the curl command for the HTTP request in the console.
This is useful for debugging and testing purposes.

```dart
final client = InterceptedClient.build(
  /// ... other settings
  interceptors: [
    TalkerHttpLogger(
      talker: _talker,
      settings: const TalkerHttpLoggerSettings(
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
final client = InterceptedClient(
  /// ... other settings
  interceptors: [
    TalkerHttpLogger(
      talker: _talker,
      settings: const TalkerHttpLoggerSettings(
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
[TalkerHttpLoggerSettings](lib/talker_http_logger_settings.dart)

```dart
TalkerHttpLoggerSettings(
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
TalkerHttpLoggerSettings(
  // All http requests without "/secure" in path will be printed in console 
  requestFilter: (Request request) => !request.url.path.contains('/secure'),
  // All http responses with status codes different than 301 will be printed in console 
  responseFilter: (Response response) => response.statusCode != 301,
)
```

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️

