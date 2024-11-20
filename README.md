<p align="center">
    <a href="https://github.com/Frezyx/talker" align="center">
        <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/logo/full_logo.png?raw=true" width="250px">
    </a>
</p>
<!-- <h1 align="center">Talker</h1> -->
<h2 align="center"> Advanced error handler and logger for dart and flutter apps</h2>

<p align="center">
    Log your app actions, catch and handle exceptions and errors, show alerts and share log reports
   <br>
   <span style="font-size: 0.9em"> Show some ❤️ and <a href="https://github.com/Frezyx/talker">star the repo</a> to support the project! </span>
</p>

<p align="center">
    <a href="https://github.com/Frezyx/talker" align="center">
        <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/talker.jpg?raw=true">
    </a>
</p>

<p align="center">
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Frezyx/talker"><img src="https://hits.dwyl.com/Frezyx/talker.svg?style=flat" alt="Repository views"></a>
    <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

<p align="center">For better understanding how it works check <a href="https://frezyx.github.io/talker">
Web Demo</a> page</p>
<p align="center">
<a href="https://frezyx.github.io/talker">
  <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/check_web_demo.png?raw=true" width="250px">
</a>
</p>


## Motivation
🚀 &nbsp;The main goal of the project is provide ability to understand where the error occurs in a shortest possible time <br>
✅ &nbsp;Compatible with any state managements <br>
✅ &nbsp;Works with any crash reporting tool (Firebase Crashlytics, Sentry, custom tools, etc.) <br>
✅ &nbsp;Logs UI output of Flutter app on the screen <br>
✅ &nbsp;Allows sharing and saving logs history and error crash reports <br>
✅ &nbsp;Displays alerts for UI exceptions. <br>
✅ &nbsp;Built-in support for dio [HTTP logs](#talker-dio-logger) <br>
✅ &nbsp;Built-in support for [BLoC logs](#talker-bloc-logger) <br>
✅ &nbsp;Built-in support for [Riverpod logs](#talker-riverpod-logger) <br>
✅ &nbsp;[Check all features](#features-list)

## Packages
Talker is designed for any level of customization. <br>

| Package | Version | Description | 
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [talker](https://github.com/Frezyx/talker/tree/master/packages/talker) | [![Pub](https://img.shields.io/pub/v/talker.svg?style=flat-square)](https://pub.dev/packages/talker) | Main dart package for logging and error handling |
| [talker_flutter](https://github.com/Frezyx/talker/tree/master/packages/talker_flutter) | [![Pub](https://img.shields.io/pub/v/talker_flutter.svg?style=flat-square)](https://pub.dev/packages/talker_flutter) | Flutter extensions for talker <br>Colored Flutter app logs (iOS and Android), logs list screen, showing error messages at UI out of the box, route observer, etc |
| [talker_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_logger) | [![Pub](https://img.shields.io/pub/v/talker_logger.svg?style=flat-square)](https://pub.dev/packages/talker_logger) | Customizable pretty logger for dart/flutter apps |
| [talker_dio_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_dio_logger) | [![Pub](https://img.shields.io/pub/v/talker_dio_logger.svg?style=flat-square)](https://pub.dev/packages/talker_dio_logger) | Best logger for [dio](https://pub.dev/packages/dio) http calls |
| [talker_bloc_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_bloc_logger) | [![Pub](https://img.shields.io/pub/v/talker_bloc_logger.svg?style=flat-square)](https://pub.dev/packages/talker_bloc_logger) | Best logger for [BLoC](https://pub.dev/packages/bloc) state management library |
| [talker_riverpod_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_riverpod_logger) | [![Pub](https://img.shields.io/pub/v/talker_riverpod_logger.svg?style=flat-square)](https://pub.dev/packages/talker_riverpod_logger) | Best logger for [Riverpod](https://pub.dev/packages/riverpod) state management library |
| [talker_http_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_http_logger) | [![Pub](https://img.shields.io/pub/v/talker_http_logger.svg?style=flat-square)](https://pub.dev/packages/talker_http_logger) | Best logger for [http](https://pub.dev/packages/http) package |

## Table of contents

- [Motivation](#motivation)
- [Packages](#packages)
- [Talker](#talker)
  - [Get Started](#get-started)
  - [Customization](#⚙️-customization)
    - [Custom logs](#custom-logs)
    - [Change log colors](#change-log-colors)
    - [Change log titles](#change-log-titles)
  - [TalkerObserver](#talkerobserver)
- [Talker Flutter](#talker-flutter)
  - [Get Started](#get-started-flutter)
  - [TalkerScreen](#talkerscreen)
  - [Customization](#customization)
    - [How to set custom color?](#how-to-set-custom-colors)
    - [TalkerScreenTheme](#talkerscreentheme)
  - [TalkerRouteObserver](#talkerrouteobserver)
    - [Navigator](#navigator)
    - [auto_route](#auto_route)
    - [auto_route v7](#auto_route-v7)
    - [go_router](#go_router)
  - [TalkerMonitor](#talkermonitor)
  - [TalkerWrapper](#talkerwrapper)
  - [More Features And Examples](#more-features-and-examples)
- [Integrations](#integrations)
- [Talker Dio Logger](#talker-dio-logger)
  - [Customization](#customization-1)
    - [Off/On http request or reposnse logs](#offon-http-request-or-reposnse-logs)
    - [Change http logs colors](#change-http-logs-colors)
    - [Filter http logs](#filter-http-logs)
  - [Using with Talker](#using-with-talker)
- [Talker BLoC Logger](#talker-bloc-logger)
  - [Customization](#customization-2)
    - [Off/on events, transitions, changes, creation, close](#offon-events-transitions-changes-creation-close)
    - [Full/truncated state and event data](#fulltruncated-state-and-event-data)
    - [Filter bloc logs](#filter-bloc-logs)
  - [Using with Talker](#using-with-talker-1)
- [Talker Riverpod Logger](#talker-riverpod-logger)
  - [Customization](#customization-3)
    - [Off/on events, add, update, dispose, fail](#offon-events-add-update-dispose-fail)
    - [Full/truncated state data](#fulltruncated-state-data)
    - [Filter riverpod logs](#filter-riverpod-logs)
  - [Using with Talker](#using-with-talker-2)
- [Crashlytics integration](#crashlytics-integration)
- [Features list](#features-list)
- [Coverage](#coverage)
- [Additional information](#additional-information)
- [Contributors](#contributors)


# Talker

## Get Started
<!-- See all documentation at [talker web site](https://frezyx.github.io/talker/guide/get-started.html#instalation) or -->
Follow these steps to the coolest experience in error handling

### Add dependency
```yaml
dependencies:
  talker: ^4.4.7
```

### Easy to use
You can use Talker instance everywhere in your app <br>
Simple and concise syntax will help you with this

```dart
  import 'package:talker/talker.dart';

  final talker = Talker();

  /// Just logs
  talker.warning('The pizza is over 😥');
  talker.debug('Thinking about order new one 🤔');

  // Handling Exception's and Error's
  try {
    throw Exception('The restaurant is closed ❌');
  } catch (e, st) {
    talker.handle(e, st);
  }

  /// Just logs
  talker.info('Ordering from other restaurant...');
  talker.info('Payment started...');
  talker.good('Payment completed. Waiting for pizza 🍕');
```
More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart)

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker/console.jpg?raw=true"></a></p>

## ⚙️ Customization
Configure the error handler and logger for yourself
```dart
final talker = Talker(
    settings: const TalkerSettings(
      /// You can enable/disable all talker processes with this field
      enabled: true,
      /// You can enable/disable saving logs data in history
      useHistory: true,
      /// Length of history that saving logs data
      maxHistoryItems: 100,
      /// You can enable/disable console logs
      useConsoleLogs: true,
    ),
    /// Setup your implementation of logger
    logger: TalkerLogger(),
    ///etc...
  );
```
More examples you can get [here](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart)

### Custom logs

With Talker you can create your custom log message types.<br>
And you have **full customization control** over them!

```dart
class YourCustomLog extends TalkerLog {
  YourCustomLog(String message) : super(message);

  /// Your custom log title
  @override
  String get title => 'CUSTOM';

  /// Your custom log color
  @override
  AnsiPen get pen => AnsiPen()..xterm(121);
}

final talker = Talker();
talker.logCustom(YourCustomLog('Something like your own service message'));
```

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/logger/custom_log.png?raw=true"></a></p>

### Change log colors

Starting from version 4.0.0, you have the ability to fully customize all logs colors. You can set **your own color for any type of logs**. For example, you can choose red for HTTP responses and green for errors—whatever suits your preference 😁

The Map is structured as **{TalkerLogType: AnsiPen}**.

**TalkerLogType** is an identifier for a specific log type (e.g., HTTP, error, info, etc.), and each log type in Talker has its own field in the enum. And **AnsiPen** is model to console colors customization

```dart
final talker = Talker(
  settings: TalkerSettings(
    colors: {
      TalkerLogType.httpResponse: AnsiPen()..red(),
      TalkerLogType.error: AnsiPen()..green(),
      TalkerLogType.info: AnsiPen()..yellow(),
      // Other colors...
    },
  ),
);
```

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/logger/custom_logs_colors.jpg?raw=true"></a></p>

Talker have default color scheme. You can check it in [TalkerSettings](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/settings.dart) class

### Change log titles

Starting from version 4.0.0, you have the ability to fully customize all logs titles. You can set **your own title for any type of logs**.

The Map is structured as **{TalkerLogType: String}**.

**TalkerLogType** is an identifier for a specific log type (e.g., HTTP, error, info, etc.), and each log type in Talker has its own field in the enum.

```dart
final talker = Talker(
  settings: TalkerSettings(
    titles: {
      TalkerLogType.exception: 'Whatever you want',
      TalkerLogType.error: 'E',
      TalkerLogType.info: 'i',
      // Other titles...
    },
  ),
);
```

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/logger/custom_log_titles.png?raw=true"></a></p>

Talker have default titles scheme. You can check it in [TalkerSettings](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/settings.dart) class

## TalkerObserver

TalkerObserver is a mechanism that allows observing what is happening inside Talker from the outside.

```dart
import 'package:talker/talker.dart';

class ExampleTalkerObserver extends TalkerObserver {
  ExampleTalkerObserver();

  @override
  void onError(TalkerError err) {
    /// Send data to your error tracking system like Sentry or backend
    super.onError(err);
  }

  @override
  void onException(TalkerException exception) {
    /// Send Exception to your error tracking system like Sentry or backend
    super.onException(exception);
  }

  @override
  void onLog(TalkerDataInterface log) {
    /// Send log message to Grafana or backend
    super.onLog(log);
  }
}

final observer = ExampleTalkerObserver();
final talker = Talker(observer: observer);
```

You can use it to transmit data about logs to external sources such as **[Crashlytics](#crashlytics-integration)**, **Sentry**, **Grafana**, or your own analytics service, etc.

# Talker Flutter

## Get Started Flutter

Talker Flutter is an extension for the Dart Talker package that adds extra functionality to make it easier for you to handle logs, errors, and exceptions in your Flutter applications.

### Add dependency
```yaml
dependencies:
  talker_flutter: ^4.4.7
```

### Setup

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

// Handle exceptions and errors
try {
  // your code...
} catch (e, st) {
    talker.handle(e, st, 'Exception with');
}

// Log your app info
talker.info('App is started');
talker.critical('❌ Houston, we have a problem!');
talker.error('🚨 The service is not available');
```

### ❗️ Log messages integrity
Most of flutter logging packages either cut messages in the console, or cant dope colored messages in the iOS console. But Talker is not one of them...

Talker uses the optimal method for logging depending on the Operating system on which it runs

But to do this, you need to use the initialization given in the example. Only with TalkerFlutter.init() 

As result of this method you will get the same instance of Talker as when creating it through the Talker() constructor but with logging default initialization

## TalkerScreen 
Often you need to check what happening in the application when there is no console at hand. <br>
There is a TalkerScreen widget from [talker_flutter](https://pub.dev/packages/talker_flutter) package for this situations.<br>

For better understanding how it works check [Web Demo](https://frezyx.github.io/talker) page

| <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/start.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/filter.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/actions.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/settings.png?raw=true" width="250px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| TalkerScreen | TalkerFilter | TalkerActions | TalkerSettings |

### Easy to use
You can use TalkerScreen everywhere in your app<br>
At Screen, BottomSheet, ModalDialog, etc...

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  )
);
```
See more in TalkerScreen [usage example](https://github.com/Frezyx/talker/blob/master/packages/talker_flutter/example/lib/main.dart)

## Customization

Starting from version 4.0.0, you have the ability to fully customize your TalkerScreen display. You can set **your own color for any type of logs**. For example, you can choose red for HTTP responses and green for errors—whatever suits your preference 😁

| <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/customization/custom_logs4.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/customization/custom_logs1.png" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/customization/custom_logs2.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/customization/custom_logs3.png?raw=true" width="250px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

### How to set custom colors ?

To set your custom colors, you need to pass a TalkerScreenTheme object to the TalkerScreen constructor, with a Map containing the desired colors. 

The Map is structured as **{log type: color}**. **TalkerLogType** is an identifier for a specific log type (e.g., HTTP, error, info, etc.), and each log type in Talker has its own field in the enum.

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

TalkerScreen(
  talker: talker,
  theme: TalkerScreenTheme(
    /// Your custom log colors
    logColors: {
      TalkerLogType.httpResponse: Color(0xFF26FF3C),
      TalkerLogType.error: Colors.redAccent,
      TalkerLogType.info: Color.fromARGB(255, 0, 255, 247),
    },
  )
)
```

### TalkerScreenTheme

You can set custom backagroud, card and text colors for  TalkerScreen with TalkerScreenTheme

```dart
TalkerScreenTheme(
  cardColor: Colors.grey[700]!,
  backgroundColor: Colors.grey[800]!,
  textColor: Colors.white,
  logColors: {
    /// Your logs colors...
  },
)
```

## TalkerRouteObserver
Observer for a navigator.<br>
If you want to keep a record of page transitions in your application, you've found what you're looking for.

You can use TalkerRouteObserver with **any routing package**<br>
From auto_route to basic Flutter Navigator

### Navigator

```dart
final talker = Talker();

MaterialApp(
  navigatorObservers: [
    TalkerRouteObserver(talker),
  ],
)
```

### auto_route

```dart
final talker = Talker();

MaterialApp.router(
  routerDelegate: AutoRouterDelegate(
    appRouter,
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
),
```

### auto_route v7

```dart
final talker = Talker();

MaterialApp.router(
  routerConfig: _appRouter.config(
    navigatorObservers: () => [
      TalkerRouteObserver(talker),
    ],
  ),
),
```

### go_router

```dart
final talker = Talker();

GoRouter(
  observers: [TalkerRouteObserver(talker)],
)
```


## TalkerMonitor 
If you want to check the status of your application in a short time<br> 
**TalkerMonitor** will be the best solution for you 

Monitor is a filtered quick information about http requests, exceptions, errors, warnings, etc... count

You will find Monitor at the TalkerScreen page

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/monitor.jpg?raw=true"></a></p>

For better understanding how it works check [Web Demo](https://frezyx.github.io/talker) page

## TalkerWrapper
In addition 
talker_flutter is able to show default and custom error messages and another status messages via TalkerWrapper

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/v3/talker_flutter/wrapper.jpg?raw=true"></a></p>

```dart
import 'package:talker_flutter/talker_flutter.dart';

final talker = TalkerFlutter.init();

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
  ),
  child: /// Application or the screen where you need to show messages
),
```

## More Features And Examples

### Custom UI error messages

In order to understand in more details - you can check this article ["Showing Flutter custom error messages"](https://dev.to/frezyx/showing-flutter-custom-error-messages-109o)

TalkerWrapper [usage example](https://github.com/Frezyx/talker/blob/master/packages/talker_flutter/example/lib/talker_wrapper_example/talker_wrapper_example.dart)

### ShopApp example
See full application example with BLoC and navigation [here](https://github.com/Frezyx/talker/blob/master/examples/shop_app_example)

The talker_flutter package have a lot of another widgets like TalkerBuilder, TalkerListener, etc. You can find all of them in code documentation.

## Integrations

In addition to the basic functionality, talker was conceived as a tool for creating lightweight loggers for the main activities of your application

You can use ready out of the box packages like [talker_dio_logger](https://pub.dev/packages/talker_dio_logger), [talker_bloc_logger](https://pub.dev/packages/talker_bloc_logger) and [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger) or create your own packages.

## Talker Dio Logger

Lightweight, simple and pretty solution for logging if your app use [dio](https://pub.dev/packages/dio) as http-client 

This is how the logs of your http requests will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_dio_logger/preview_new.png?raw=true)

### Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_dio_logger: ^4.4.7
```

### Usage
Just add **TalkerDioLogger** to your dio instance and it will work

```dart
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

## Customization

To provide hight usage exp here are a lot of settings and customization fields in TalkerDioLoggerSettings. You can setup all wat you want. For example: 

### Off/on http request or reposnse logs

You can toggle reponse / request printing and headers including

```dart
final dio = Dio();
dio.interceptors.add(
    TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          // All http responses enabled for console logging
          printResponseData: true,
          // All http requests disabled for console logging
          printRequestData: false,
          // Reposnse logs including http - headers
          printResponseHeaders: true,
          // Request logs without http - headersa
          printRequestHeaders: false,
        ),
    ),
);
```

### Change http logs colors

Setup your custom http-log colors. You can set color for requests, responses and errors in TalkerDioLoggerSettings

```dart
TalkerDioLoggerSettings(
  // Blue http requests logs in console
  requestPen: AnsiPen()..blue(),
  // Green http responses logs in console
  responsePen: AnsiPen()..green(),
  // Error http logs in console
  errorPen: AnsiPen()..red(),
);
```

### Filter http logs

For example if your app has a private functionality and you don't need to store this functionality logs in talker - you can use filters

```dart
TalkerDioLoggerSettings(
  // All http request without "/secure" in path will be printed in console 
  requestFilter: (RequestOptions options) => !options.path.contains('/secure'),
  // All http responses with status codes different than 301 will be printed in console 
  responseFilter: (response) => response.statusCode != 301,
)
```

## Using with Talker
You can add your talker instance for TalkerDioLogger if your app already uses Talker.
In this case, all logs and errors will fall into your unified tracking system

```dart
final talker = Talker();
final dio = Dio();
dio.interceptors.add(TalkerDioLogger(talker: talker));
```

## Talker BLoC Logger

Lightweight, simple and pretty solution for logging if your app use [BLoC](https://pub.dev/packages/bloc) as state management

This is how the logs of your BLoC's event calling and state emits will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_bloc_logger/preview.png?raw=true)

### Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_bloc_logger: ^4.4.7
```

### Usage
Just set **TalkerBlocObserver** as Bloc.observer field and it will work

```dart
import 'package:talker_bloc_observer/talker_bloc_observer.dart';

Bloc.observer = TalkerBlocObserver();
```

## Customization

To provide hight usage exp here are a lot of settings and customization fields in TalkerBlocLoggerSettings. You can setup all wat you want. For example:

### Off/on events, transitions, changes, creation, close

You can toggle all bloc event types printing

```dart
Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      enabled: true,
      printChanges: true,
      printClosings: true,
      printCreations: true,
      printEvents: true,
      printTransitions: true,
    ),
  );
```

### Full/truncated state and event data

You can choose to have the logs of events and states in the BLoC displayed in the console in either full or truncated form

```dart
Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );
```

### Filter bloc logs

You can output logs to the console for specific events and states only, using a filter

```dart
Bloc.observer = TalkerBlocObserver(
    settings: TalkerBlocLoggerSettings(
      // If you want log only AuthBloc transitions
      transitionFilter: (bloc, transition) =>
          bloc.runtimeType.toString() == 'AuthBloc',
      // If you want log only AuthBloc events
      eventFilter: (bloc, event) => bloc.runtimeType.toString() == 'AuthBloc',
    ),
  );
```

## Using with Talker!
You can add your talker instance for TalkerBlocLogger if your Appication already uses Talker.

In this case, all logs and errors will fall into your unified tracking system

```dart
import 'package:talker_bloc_observer/talker_bloc_observer.dart';
import 'package:talker/talker.dart';

final talker = Talker();
Bloc.observer = TalkerBlocObserver(talker: talker);
```

## Talker Riverpod Logger

Lightweight, simple and pretty solution for logging if your app use [Riverpod](https://pub.dev/packages/riverpod) as state management

This is how the logs of your Riverpod's event calling and state emits will look in the console
![](https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_riverpod_logger/preview.png?raw=true)

### Getting started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker_riverpod_logger: ^4.4.7
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

## Customization

To provide hight usage exp here are a lot of settings and customization fields in TalkerRiverpodLoggerSettings. You can setup all wat you want. For example:

### Off/on events, add, update, dispose, fail

You can toggle all riverpod event types printing

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

### Full/truncated state data

You can choose to have the logs of states in the Riverpod displayed in the console in either full or truncated form

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    printStateFullData: false,
  ),
)
```

### Filter Riverpod logs

You can output logs to the console for specific events only, using a filter

```dart
TalkerRiverpodObserver(
  settings: TalkerRiverpodLoggerSettings(
    // If you want log only AuthProvider events
      eventFilter: (provider) => provider.runtimeType == 'AuthProvider<User>',
  ),
)
```

## Using with Talker!
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

## Crashlytics integration

If you add CrashlyticsTalkerObserver to your application, you will receive notifications about all application errors in the Crashlytics dashboard. <br>

Additionally, you can **configure it to send only specific errors** to Crashlytics from within TalkerObserver.

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker/talker.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  CrashlyticsTalkerObserver();

  @override
  void onError(err) {
      FirebaseCrashlytics.instance.recordError(
        err.error,
        err.stackTrace,
        reason: err.message,
      );
  }

  @override
  void onException(err) {
      FirebaseCrashlytics.instance.recordError(
        err.exception,
        err.stackTrace,
        reason: err.message,
      );
  }
}

final crashlyticsTalkerObserver = CrashlyticsTalkerObserver();
final talker = Talker(observer: crashlyticsTalkerObserver);
```

## Features list

✅ Logging
- ✅ Filtering

- ✅ Formatting
- ✅ Color logs
- ✅ LogLevels (info, verbose, warning, debug, error, critical, fine, good) 
- ✅ Customization for filtering, formatting and colors
- 🚧 Separation from system's and another flutter logs
- 🚧 Collapsible feature for huge logs
- 🚧 Logs grouping

✅ Errors handling
- ✅ Errors and Exceptions identification
- ✅ StackTrace
- 🚧 Error level identification 

✅ Flutter
- ✅ Application logs sharing

- ✅ HTTP cals logging
- ✅ TalkerScreen - Showing logs list in Flutter app UI
- ✅ TalkerMonitor - A short summary of your application status. How much errors, how much warnings in Flutter app UI
- ✅ TalkerRouteObserver - router logging (which screen is opened, which is closed)
- ✅ TalkerWrapper - Showing errors and exceptions messages at UI
- ✅ TalkerListener - Listen logs data at application UI
- ✅ TalkerBuilder - UI builder to Logs List showing custom UI
- ✅ Android/Windows/Web application logs colors
- ✅ iOS/MacOS application logs colors
- ✅ Talker configuration chnages from TalkerFlutter 

✅ Logs and errors history saving

✅ TalkerObserver - handle all logs, errors, exceptions for integrations (Sentry, Crashlytics)


## Coverage
Error handling is a very important task <br>
You need to choose carefully if you want to use a package for exceptions handling solution <br>
Therefore, the project is 100% covered by tests

[![](https://codecov.io/gh/Frezyx/talker/branch/master/graphs/sunburst.svg)](https://codecov.io/gh/Frezyx/talker/branch/master)

## Additional information
The project is under development and ready for your pull-requests and issues 👍<br>
Thank you for support ❤️

## Contributors

<br>
<div align="center" >
  <p>Thanks to all contributors of this package</p>
  <a href="https://github.com/Frezyx/talker/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Frezyx/talker" />
  </a>
</div>
<br>

For help getting started with 😍 Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference. 
