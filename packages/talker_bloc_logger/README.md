# talker_bloc_logger
Lightweight and customizable [BLoC](https://pub.dev/packages/bloc) state management library logger on [talker](https://pub.dev/packages/talker) base.<br>
[Talker](https://github.com/Frezyx/talker) - Advanced exception handling and logging for dart/flutter applications 🚀

<p>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker_bloc_logger"><img src="https://img.shields.io/pub/v/talker_bloc_logger.svg" alt="Pub"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Preview
This is how the logs of your BLoC's event callign and state emits will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_bloc_logger/preview.png?raw=true)

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
  talker_bloc_logger: ^4.6.0
```

### Usage
Just set **TalkerBlocObserver** as Bloc.observer field and it will work

```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';


Bloc.observer = TalkerBlocObserver();
```

## Using with Talker
You can add your talker instance for TalkerBlocObserver if your app already uses Talker.

In this case, all logs and errors will fall into your unified tracking system

```dart
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker/talker.dart';

final talker = Talker();
Bloc.observer = TalkerBlocObserver(talker: talker);
```

## Settings

This package has a lot of customization options
You can enable/disable somethings events, Bloc creation, changes, closing logs, etc...

```dart
Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      enabled: true,
      printEventFullData: false,
      printStateFullData: false,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
      // If you want log only AuthBloc transitions
      transitionFilter: (bloc, transition) =>
          bloc.runtimeType.toString() == 'AuthBloc',
      // If you want log only AuthBloc events
      eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'AuthBloc',
    ),
  );
```

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️

