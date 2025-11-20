# talker_riverpod_logger
Lightweight and customizable [Riverpod](https://pub.dev/packages/riverpod) state management library logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_riverpod_logger"><img src="https://img.shields.io/pub/v/talker_riverpod_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Preview
This is how the logs of your Riverpod's state will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_riverpod_logger/preview.png?raw=true)

<p align="center">For better understanding how it works check <a href="https://frezyx.github.io/talker">
Web Demo</a> page</p>
<p align="center">
<a href="https://frezyx.github.io/talker">
  <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/check_web_demo.png?raw=true" width="250px">
</a>
</p>

## Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_riverpod_logger: ^5.1.0
```

### Usage
Just pass **TalkerRiverpodObserver** to either `ProviderScope` or `ProviderContainer` and it will work

```dart
import 'package:talker_riverpod_observer/talker_riverpod_observer.dart';

runApp(
  ProviderScope(
    observers: [
      TalkerRiverpodObserver(),
    ],
    child: MyApp(),
  )
);
```

or

```dart
import 'package:talker_riverpod_observer/talker_riverpod_observer.dart';

final container = ProviderContainer(
  observers: [
    TalkerRiverpodObserver(),
  ],
);
```

## Using with Talker
You can add your talker instance for TalkerRiverpodLogger if your Appication already uses Talker.

In this case, all logs and errors will fall into your unified tracking system

```dart
import 'package:talker_riverpod_observer/talker_riverpod_observer.dart';
import 'package:talker/talker.dart';

final talker = Talker();

runApp(
  ProviderScope(
    observers: [
      TalkerRiverpodObserver(
        talker: talker,
      ),
    ],
    child: MyApp(),
  )
);
```

or

```dart
import 'package:talker_riverpod_observer/talker_riverpod_observer.dart';
import 'package:talker/talker.dart';

final talker = Talker();

final container = ProviderContainer(
  observers: [
    TalkerRiverpodObserver(
      talker: talker,
    ),
  ],
);
```

## Settings

This package has a lot of customization options
You can enable/disable somethings events, Provider add, update, dispose, fail logs, etc...

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    enabled: true,
    printStateFullData: false,
    printProviderAdded: true,
    printProviderUpdated: true,
    printProviderDisposed: true,
    printProviderFailed: true,
    // If you want log only AuthProvider events
    eventFilter: (provider) => provider.runtimeType == 'AuthProvider<User>',
  ),
)
```

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️

