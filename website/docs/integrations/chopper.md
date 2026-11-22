# Chopper Logger

<a href="https://pub.dev/packages/talker_chopper_logger"><img src="https://img.shields.io/pub/v/talker_chopper_logger.svg" alt="Pub"></a>

Lightweight and customizable HTTP logger for [Chopper](https://pub.dev/packages/chopper) built on Talker.

## Installation

```yaml
dependencies:
  talker_chopper_logger: ^5.1.13
```

## Basic Usage

Add `TalkerChopperLogger` as a Chopper interceptor:

```dart
import 'package:talker_chopper_logger/talker_chopper_logger.dart';

final chopper = ChopperClient(
  baseUrl: Uri.parse('https://api.example.com'),
  interceptors: [
    TalkerChopperLogger(
      settings: const TalkerChopperLoggerSettings(),
    ),
  ],
);
```

## Using with Talker

```dart
final talker = Talker();
final chopper = ChopperClient(
  interceptors: [
    TalkerChopperLogger(talker: talker),
  ],
);
```

## Customization

### Toggle Request/Response Logging

```dart
TalkerChopperLoggerSettings(
  printRequestData: true,
  printRequestHeaders: true,
  printResponseData: true,
  printResponseHeaders: true,
  printResponseMessage: true,
)
```

### Print curl Command

```dart
TalkerChopperLoggerSettings(
  printRequestCurl: true,
)
```

### Hide Sensitive Headers

```dart
TalkerChopperLoggerSettings(
  printRequestHeaders: true,
  printResponseHeaders: true,
  hiddenHeaders: {
    'authorization',
    'cookie',
    'x-api-key',
  },
)
```

### Custom Colors

```dart
TalkerChopperLoggerSettings(
  requestPen: AnsiPen()..cyan(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

### Filtering

```dart
TalkerChopperLoggerSettings(
  requestFilter: (request) =>
      !request.url.path.contains('/health'),
  responseFilter: (response) =>
      response.statusCode != 304,
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
