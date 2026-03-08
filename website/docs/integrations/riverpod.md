# Riverpod Logger

<a href="https://pub.dev/packages/talker_riverpod_logger"><img src="https://img.shields.io/pub/v/talker_riverpod_logger.svg" alt="Pub"></a>

Lightweight and customizable [Riverpod](https://pub.dev/packages/riverpod) state management logger built on Talker.

## Installation

```yaml
dependencies:
  talker_riverpod_logger: ^5.1.13
```

## Basic Usage

Add `TalkerRiverpodObserver` to your `ProviderScope`:

```dart
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

runApp(
  ProviderScope(
    observers: [TalkerRiverpodObserver()],
    child: MyApp(),
  ),
);
```

All provider lifecycle events — add, update, dispose, and fail — will be logged automatically.

## Using with Talker

Pass your existing Talker instance:

```dart
final talker = Talker();

runApp(
  ProviderScope(
    observers: [TalkerRiverpodObserver(talker: talker)],
    child: MyApp(),
  ),
);
```

## Customization

### Toggle Event Types

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    enabled: true,
    printProviderAdded: true,
    printProviderUpdated: true,
    printProviderDisposed: true,
    printProviderFailed: true,
  ),
)
```

### Truncate Data

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    printStateFullData: false,
  ),
)
```

### Filter Logs

Only log specific providers:

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    // Only log specific providers
    providerFilter: (provider) =>
        provider.name?.contains('auth') ?? false,
  ),
)
```

## Settings Reference

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enabled` | `bool` | `true` | Enable/disable logging |
| `printProviderAdded` | `bool` | `true` | Log provider additions |
| `printProviderUpdated` | `bool` | `true` | Log provider updates |
| `printProviderDisposed` | `bool` | `true` | Log provider disposals |
| `printProviderFailed` | `bool` | `true` | Log provider failures |
| `printStateFullData` | `bool` | `true` | Print full state data |
| `providerFilter` | `Function?` | `null` | Filter which providers to log |
