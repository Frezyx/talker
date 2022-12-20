<p align="center">
    <a href="https://github.com/Frezyx/talker" align="center">
        <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/logo/full_logo.png?raw=true" width="250px">
    </a>
</p>
<!-- <h1 align="center">Talker</h1> -->
<h2 align="center"> Advanced error handler and logger for dart and flutter apps ☎️</h2>

<p align="center">
    Log your app actions, catch and handle exceptions and errors, show alerts and share log reports
   <br>
   <span style="font-size: 0.9em"> Show some ❤️ and <a href="https://github.com/Frezyx/talker">star the repo</a> to support the project! </span>
</p>

<p align="center">
    <a href="https://github.com/Frezyx/talker/blob/dev/docs/assets/banner/banner.png?raw=true" align="center">
        <img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/banner/banner.png?raw=true">
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
✅ &nbsp;Can work with different state managements <br>
✅ &nbsp;Can work with any crash reporting tool (Firebase Crashlytics, Sentry, Your own, etc) <br>
✅ &nbsp;Flutter app logs UI output at screen <br>
✅ &nbsp;Sharing and saving logs history and error crash reports<br>
✅ &nbsp;Showing UI exception alerts<br> 
✅ &nbsp;Http logs available out of the box<br>
✅ [Check all features](#features-list)

## Packages
Talker is designed for any level of customization. <br>

| Package | Version | Description | 
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [talker](https://github.com/Frezyx/talker/tree/master/packages/talker) | [![Pub](https://img.shields.io/pub/v/talker.svg?style=flat-square)](https://pub.dev/packages/talker) | Main dart package for logging and error handling |
| [talker_flutter](https://github.com/Frezyx/talker/tree/master/packages/talker_flutter) | [![Pub](https://img.shields.io/pub/v/talker_flutter.svg?style=flat-square)](https://pub.dev/packages/talker_flutter) | Flutter extensions for talker <br>Colored Flutter app logs (iOS and Android), logs list screen, showing error messages at UI out of the box, route observer, etc |
| [talker_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_logger) | [![Pub](https://img.shields.io/pub/v/talker_logger.svg?style=flat-square)](https://pub.dev/packages/talker_logger) | Customizable pretty logger for dart/flutter apps |
| [talker_dio_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_dio_logger) | [![Pub](https://img.shields.io/pub/v/talker_dio_logger.svg?style=flat-square)](https://pub.dev/packages/talker_dio_logger) | Best logger for dio http calls |

## Table of contents

- [Motivation](#motivation)
- [Packages](#packages)
- [Get Started](#get-started)
- [Customization](#⚙️-customization)
- [Talker Flutter](#talker-flutter)
  - [Get Started](#get-started-flutter)
  - [TalkerScreen](#talkerscreen)
  - [TalkerWrapper](#talkerwrapper)
  - [More Features And Examples](#more-features-and-examples)
- [Features list](#features-list)
- [Coverage](#coverage)
- [Additional information](#additional-information)

## Get Started
<!-- See all documentation at [talker web site](https://frezyx.github.io/talker/guide/get-started.html#instalation) or -->
Follow these steps to the coolest experience in error handling

### Add dependency
```yaml
dependencies:
  talker: ^2.2.0
```

### Easy to use
You can use Talker instance everywhere in your app <br>
Simple and concise syntax will help you with this

```dart
import 'package:talker/talker.dart';

final talker = Talker();

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
More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart)

## ⚙️ Customization
Configure the error handler and logger for yourself
```dart
final talker = Talker(
    /// Your own observers to handle errors's exception's and log's
    /// like Crashlytics or Sentry observer
    observers: [],
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

# Talker Flutter

## Get Started Flutter

Talker Flutter is extension for dart talker package with additional functionality which will help you to simplify work with Flutter application logs, errors and exceptions.

### Add dependency
```yaml
dependencies:
  talker_flutter: ^2.2.0
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

| <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_flutter/talker_screen.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_flutter/talker_screen_actions.png?raw=true" width="250px"></a></p> | <p align="left"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_flutter/talker_screen_filter.png?raw=true" width="250px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |

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

## TalkerMonitor 
If you want to check the status of your application in a short time<br> 
**TalkerMonitor** will be the best solution for you 

Monitor is a filtered quick information about http requests, exceptions, errors, warnings, etc... count

You will find Monitor at the TalkerScreen page

For better understanding how it works check [Web Demo](https://frezyx.github.io/talker) page

<p align="center"><a href="https://frezyx.github.io/talker" align="center"><img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/talker_flutter/talker_screen_filter.png?raw=true" width="250px"></a></p>


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

## TalkerWrapper
In addition 
talker_flutter is able to show default and custom error messages and another status messages via TalkerWrapper
| <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_wrapper_app_example.gif?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_wrapper_app_example.gif?raw=true" width="350px"></a></p> | <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_wrapper_storage_view.jpeg?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_wrapper_storage_view.jpeg?raw=true" width="1130px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

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

In order to understand in more details - you can check this article ["Showing Flutter custom error messages"](https://dev.to/frezyx/showing-flutter-custom-error-messages-109o)

TalkerWrapper [usage example](https://github.com/Frezyx/talker/blob/master/packages/talker_flutter/example/lib/talker_wrapper_example/talker_wrapper_example.dart)

See full application example with BLoC and navigation [here](https://github.com/Frezyx/talker/blob/master/examples/shop_app_example)

The talker_flutter package have a lot of another widgets like TalkerBuilder, TalkerListener, etc. You can find all of them in code documentation.

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