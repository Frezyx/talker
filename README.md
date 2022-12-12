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
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker?style=social" alt="GitHub"></a>
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Frezyx/talker"><img src="https://hits.dwyl.com/Frezyx/talker.svg?style=flat" alt="Repository views"></a>
  <br>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Motivation
🚀 &nbsp;The main goal of the project provide ability to understand where the error occurs in a short time <br>
✅ &nbsp;Can work with different state managements <br>
✅ &nbsp;Can work with any crash reporting tool (Firebase Crashlytics, Sentry, Your own, etc) <br>
✅ &nbsp;Flutter app logs UI output at screen <br>
✅ &nbsp;Integrated logs and exceptions history <br>
✅ &nbsp;Showing UI exception alerts 

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
- [Packages](#Packages)
- [Get Started](#get-started)
- [Get Started Flutter](#get-started-flutter)
- [Customization](#customization)
- [Talker Flutter](#talker-flutter)
- [Features list](#features-list)
- [Coverage](#coverage)
- [Additional information](#additional-information)

## Get Started
<!-- See all documentation at [talker web site](https://frezyx.github.io/talker/guide/get-started.html#instalation) or -->
Follow these steps to the coolest experience in error handling

### Add dependency
```yaml
dependencies:
  talker: ^2.1.0
```

### Easy to use
You can use Talker instance everywhere in your app <br>
Simple and concise syntax will help you with this

```dart
final talker = Talker();
// Handle exceptions and errors
try {
  // your code...
} on Exception catch (e, st) {
    talker.handle(e, st, 'Exception with');
}

// Log your app info
talker.info('App is started');
talker.critical('❌ Houston, we have a problem!');
talker.error('🚨 The service is not available');
```
More examples you can get [here](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart)

## Get Started Flutter
//TODO:

## ❗️ Attention ❗️

### Logs are truncated / cut by the console

Latest Flutter stable release have print method bug [issues/110236](https://github.com/flutter/flutter/issues/110236) <br>
But with Talker you can solve it with passing your own output/print method 


If you want to see full logs in console - pass debugPrint as ouput callback method in Talker constructor
```dart
final talker = Talker(
  loggerOutput: debugPrint,
);
```

### iOS logs colors 
There is a problem with the color palette of logs when launching the app on iOS.
In this case, the console cannot read the ansi colors that are used by the library.

<img src="https://github.com/Frezyx/talker/blob/dev/docs/assets/console/ios_colors.png?raw=true">

For disable colors in iOS application you can setup this loggerSettings field
```dart
  final talker = Talker(
    loggerSettings: TalkerLoggerSettings(
      enableColors: !Platform.isIOS,
    ),
  );
```

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

## Talker Flutter 
Often you need to check what happening in the application when there is no console at hand. <br>
There is a [talker_flutter](https://pub.dev/packages/talker_flutter) package for this situations.<br>


| <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_screen.gif?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_screen.gif?raw=true" width="250px"></a></p> | <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_screen.jpg?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_screen.jpg?raw=true" width="250px"></a></p> | <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_screen_filter.jpg?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_screen_filter.jpg?raw=true" width="250px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
<!-- [Check SetUp guide on docs site](https://frezyx.github.io/talker/guide/get-started.html#instalation) -->

## Get Started with talker_flutter
Follow these steps to implement talker_flutter in your application

### Add dependency
```yaml
dependencies:
  talker_flutter: ^2.0.6
```

### Easy to use
You can use TalkerScreen everywhere in your app
At Screen, BottomSheet, ModalDialog, etc...

```dart
final talker = Talker(
  loggerOutput: debugPrint,
);

Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => TalkerScreen(talker: talker),
  )
);
```
TalkerScreen [usage example](https://github.com/Frezyx/talker/blob/master/packages/talker_flutter/example/lib/main.dart)

### TalkerWrapper
In addition to the above, <br>
talker_flutter is able to show default and custom error messages and another status messages
| <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_wrapper_app_example.gif?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_wrapper_app_example.gif?raw=true" width="350px"></a></p> | <p align="left"><a href="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_wrapper_storage_view.jpeg?raw=true" align="center"><img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter/talker_wrapper_storage_view.jpeg?raw=true" width="1130px"></a></p> |
| ------------------------------------------------------------ | ------------------------------------------------------------ |

```dart
final talker = Talker(
  loggerOutput: debugPrint,
);

TalkerWrapper(
  talker: talker,
  options: const TalkerWrapperOptions(
    enableErrorAlerts: true,
  ),
  child: /// Application or the screen where you need to show messages
),
```

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

- ✅ Logs history list screen
- ✅ HTTP cals logging
- ✅ TalkerRouteObserver - router logging (which screen is opened, which is closed)
- ✅ TalkerWrapper - Showing errors and exceptions messages at UI
- ✅ TalkerListener - Listen logs data at application UI
- ✅ TalkerBuilder - UI builder to Logs List showing custom UI
- ✅ Android/Windows/Web application logs colors
- 🚧 iOS/MacOS application logs colors

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