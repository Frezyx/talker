# Dio Logger

<a href="https://pub.dev/packages/talker_dio_logger"><img src="https://img.shields.io/pub/v/talker_dio_logger.svg" alt="Pub"></a>

Lightweight and customizable HTTP logger for [Dio](https://pub.dev/packages/dio) built on Talker.

## Installation

```yaml
dependencies:
  talker_dio_logger: ^5.1.13
```

## Basic Usage

Add `TalkerDioLogger` to your Dio interceptors:

```dart
import 'package:talker_dio_logger/talker_dio_logger.dart';

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

Pass your existing Talker instance to unify all logs:

```dart
final talker = Talker();
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```

Now all HTTP logs will appear in `TalkerScreen`, history, and stream alongside your other logs.

## Customization

### Toggle Request/Response Logging

```dart
TalkerDioLoggerSettings(
  // Enable response body logging
  printResponseData: true,
  // Disable request body logging
  printRequestData: false,
  // Include response headers
  printResponseHeaders: true,
  // Exclude request headers
  printRequestHeaders: false,
)
```

### Custom Colors

```dart
TalkerDioLoggerSettings(
  requestPen: AnsiPen()..blue(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Filtering

Only log specific requests/responses:

```dart
TalkerDioLoggerSettings(
  // Skip requests to /secure endpoints
  requestFilter: (RequestOptions options) =>
      !options.path.contains('/secure'),
  // Skip 301 redirects
  responseFilter: (response) =>
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
| `requestPen` | `AnsiPen?` | pink | Console color for requests |
| `responsePen` | `AnsiPen?` | green | Console color for responses |
| `errorPen` | `AnsiPen?` | red | Console color for errors |
| `requestFilter` | `Function?` | `null` | Filter which requests to log |
| `responseFilter` | `Function?` | `null` | Filter which responses to log |
