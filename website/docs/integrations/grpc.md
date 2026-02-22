# gRPC Logger

<a href="https://pub.dev/packages/talker_grpc_logger"><img src="https://img.shields.io/pub/v/talker_grpc_logger.svg" alt="Pub"></a>

Lightweight and customizable [gRPC](https://pub.dev/packages/grpc) logger built on Talker.

## Installation

```yaml
dependencies:
  talker_grpc_logger: ^5.1.13
```

## Basic Usage

Add `TalkerGrpcLogger` as a gRPC client interceptor:

```dart
import 'package:talker_grpc_logger/talker_grpc_logger.dart';

final channel = ClientChannel(
  'localhost',
  port: 50051,
  options: ChannelOptions(
    credentials: const ChannelCredentials.insecure(),
  ),
);

final client = YourServiceClient(
  channel,
  interceptors: [TalkerGrpcLogger()],
);
```

## Using with Talker

```dart
final talker = Talker();
final client = YourServiceClient(
  channel,
  interceptors: [
    TalkerGrpcLogger(talker: talker),
  ],
);
```

## Customization

### Token Obfuscation

gRPC metadata often contains sensitive tokens. Talker can obfuscate them:

```dart
TalkerGrpcLogger(
  settings: TalkerGrpcLoggerSettings(
    // Token will show as "eyJh***" instead of the full value
    printRequestHeaders: true,
    hideTokens: true,
  ),
)
```

### Toggle Request/Response Logging

```dart
TalkerGrpcLoggerSettings(
  printRequestData: true,
  printResponseData: true,
  printRequestHeaders: true,
  printResponseHeaders: true,
)
```

### Custom Colors

```dart
TalkerGrpcLoggerSettings(
  requestPen: AnsiPen()..cyan(),
  responsePen: AnsiPen()..green(),
  errorPen: AnsiPen()..red(),
)
```

## Settings Reference

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `printRequestData` | `bool` | `true` | Print request message data |
| `printResponseData` | `bool` | `true` | Print response message data |
| `printRequestHeaders` | `bool` | `false` | Print request metadata |
| `printResponseHeaders` | `bool` | `false` | Print response trailers |
| `hideTokens` | `bool` | `false` | Obfuscate tokens in metadata |
| `requestPen` | `AnsiPen?` | pink | Console color for requests |
| `responsePen` | `AnsiPen?` | green | Console color for responses |
| `errorPen` | `AnsiPen?` | red | Console color for errors |
