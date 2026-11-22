# HTTP Logger

<a href="https://pub.dev/packages/talker_http_logger"><img src="https://img.shields.io/pub/v/talker_http_logger.svg" alt="Pub"></a>

Lightweight HTTP logger for the [http_interceptor](https://pub.dev/packages/http_interceptor) package built on Talker.

## Installation

```yaml
dependencies:
  talker_http_logger: ^5.1.13
```

## Basic Usage

Add `TalkerHttpLogger` to your `InterceptedClient`:

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

```dart
final talker = Talker();
final client = InterceptedClient.build(
  interceptors: [
    TalkerHttpLogger(talker: talker),
  ],
);
```

## Customization

### Print curl Command

```dart
TalkerHttpLoggerSettings(
  printRequestCurl: true,
)
```

### Hide Sensitive Headers

```dart
TalkerHttpLoggerSettings(
  printRequestHeaders: true,
  printResponseHeaders: true,
  hiddenHeaders: {
    'authorization',
    'cookie',
  },
)
```

### Custom Colors

```dart
TalkerHttpLoggerSettings(
  requestPen: AnsiPen()..blue(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Filtering

```dart
TalkerHttpLoggerSettings(
  requestFilter: (Request request) =>
      !request.url.path.contains('/secure'),
  responseFilter: (Response response) =>
      response.statusCode != 301,
)
```

## Settings Reference

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `printRequestData` | `bool` | `true` | Print request body |
| `printResponseData` | `bool` | `true` | Print response body |
| `printRequestHeaders` | `bool` | `false` | Print request headers |
| `printResponseHeaders` | `bool` | `false` | Print response headers |
| `printResponseMessage` | `bool` | `true` | Print response status message |
| `printRequestCurl` | `bool` | `false` | Print curl command for requests |
| `hiddenHeaders` | `Set<String>` | `{}` | Headers to hide from output |
| `requestPen` | `AnsiPen?` | pink | Console color for requests |
| `responsePen` | `AnsiPen?` | green | Console color for responses |
| `errorPen` | `AnsiPen?` | red | Console color for errors |
| `requestFilter` | `Function?` | `null` | Filter which requests to log |
| `responseFilter` | `Function?` | `null` | Filter which responses to log |
