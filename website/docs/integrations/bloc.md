# BLoC Logger

<a href="https://pub.dev/packages/talker_bloc_logger"><img src="https://img.shields.io/pub/v/talker_bloc_logger.svg" alt="Pub"></a>

Lightweight and customizable [BLoC](https://pub.dev/packages/bloc) state management logger built on Talker.

## Installation

```yaml
dependencies:
  talker_bloc_logger: ^5.1.13
```

## Basic Usage

Set `TalkerBlocObserver` as the global BLoC observer:

```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

Bloc.observer = TalkerBlocObserver();
```

That's it! All BLoC events, transitions, state changes, creations, and closings will be logged.

## Using with Talker

Pass your existing Talker instance:

```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker/talker.dart';

final talker = Talker();
Bloc.observer = TalkerBlocObserver(talker: talker);
```

## Customization

### Toggle Event Types

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    enabled: true,
    printEvents: true,
    printTransitions: true,
    printChanges: true,
    printCreations: true,
    printClosings: true,
  ),
);
```

### Truncate State/Event Data

By default, full data is printed. You can truncate it:

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    printEventFullData: false,
    printStateFullData: false,
  ),
);
```

### Filter Logs

Log only specific BLoCs:

```dart
Bloc.observer = TalkerBlocObserver(
  settings: TalkerBlocLoggerSettings(
    // Only log AuthBloc transitions
    transitionFilter: (bloc, transition) =>
        bloc.runtimeType.toString() == 'AuthBloc',
    // Only log AuthBloc events
    eventFilter: (bloc, event) =>
        bloc.runtimeType.toString() == 'AuthBloc',
  ),
);
```

## Settings Reference

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `enabled` | `bool` | `true` | Enable/disable logging |
| `printEvents` | `bool` | `true` | Log BLoC events |
| `printTransitions` | `bool` | `true` | Log state transitions |
| `printChanges` | `bool` | `true` | Log state changes |
| `printCreations` | `bool` | `true` | Log BLoC creations |
| `printClosings` | `bool` | `true` | Log BLoC closings |
| `printEventFullData` | `bool` | `true` | Print full event data |
| `printStateFullData` | `bool` | `true` | Print full state data |
| `transitionFilter` | `Function?` | `null` | Filter transitions to log |
| `eventFilter` | `Function?` | `null` | Filter events to log |
