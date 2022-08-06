<p align="center">
    <a href="https://github.com/Frezyx/talker" align="center">
        <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logo/full_logo.png?raw=true" width="250px">
    </a>
</p>
<!-- <h1 align="center">Talker</h1> -->
<h2 align="center"> Advanced exceptions and errors handler and logger for dart and flutter apps ☎️</h2>

<p align="center">
    Log your app actions, catch and handle your app exceptions and errors, show alerts
   <br>
   <span style="font-size: 0.9em"> Show some ❤️ and <a href="https://github.com/Frezyx/talker">star the repo</a> to support the project! </span>
</p>

<p align="center">
    <a href="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_big.gif?raw=true" align="center">
        <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_big.gif?raw=true">
    </a>
</p>

<p align="center">
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <!-- <a href="https://pub.dev/packages/talker"><img src="https://img.shields.io/pub/v/talker.svg" alt="Pub"></a> -->
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>

## Packages
Talker is designed for any level of customization. <br>
- Use [talker_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_logger) if you need only a pretty logger for your Flutter/dart app.<br>
- Use [talker](https://github.com/Frezyx/talker/tree/master/packages/talker) if you need error handling and advanced methods.<br>
- Use [talker_flutter](https://github.com/Frezyx/talker/tree/master/packages/talker_flutter) to handle error in a Flutter application, display error alerts, collect statistics [and output errors to the UI](https://frezyx.github.io/talker/guide/talker-flutter.html#talkerscreen).

| Package                                                      | Version                                                       | Stats                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [talker](https://github.com/Frezyx/talker/tree/master/packages/talker) | [![Pub](https://img.shields.io/pub/v/talker.svg?style=flat-square)](https://pub.dartlang.org/packages/talker) | [![Pub](https://badges.bar/talker/likes)](https://badges.bar/talker/score) [![Pub](https://badges.bar/talker/popularity)](https://badges.bar/talker/score) [![Pub](https://badges.bar/talker/pub%20points)](https://badges.bar/talker/score)                                        |
| [talker_flutter](https://github.com/Frezyx/talker/tree/master/packages/talker_flutter) | [![Pub](https://img.shields.io/pub/v/talker_flutter.svg?style=flat-square)](https://pub.dartlang.org/packages/talker_flutter) | [![Pub](https://badges.bar/talker_flutter/likes)](https://badges.bar/talker_flutter/score) [![Pub](https://badges.bar/talker_flutter/popularity)](https://badges.bar/talker_flutter/score) [![Pub](https://badges.bar/talker_flutter/pub%20points)](https://badges.bar/talker_flutter/score)                                        |
| [talker_logger](https://github.com/Frezyx/talker/tree/master/packages/talker_logger) | [![Pub](https://img.shields.io/pub/v/talker_logger.svg?style=flat-square)](https://pub.dartlang.org/packages/talker_logger) | [![Pub](https://badges.bar/talker_logger/likes)](https://badges.bar/talker_logger/score) [![Pub](https://badges.bar/talker_logger/popularity)](https://badges.bar/talker_logger/score) [![Pub](https://badges.bar/talker_logger/pub%20points)](https://badges.bar/talker_logger/score)                                        |

<!-- <h2 align="center">On All Platforms</h2>
<p align="center">
   <span style="font-size: 0.8em">Please add Windows and Linux screenshots😘</span>
</p>
<p align="center">
  <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/all_platforms.jpg?raw=true">
</p> -->

## Get Started
See all documentation at [talker web site](https://frezyx.github.io/talker/guide/get-started.html#instalation) or
follow these steps to the coolest experience in error handling

### Add dependency
```yaml
dependencies:
  talker: ^1.1.0
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
    talker.handle(e, st, 'Exception in ...');
}

// Log your app info
talker.info('App is started');
talker.critical('❌ Houston, we have a problem!');
talker.error('🚨 The service is not available');
///...
```
More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/talker_interface.dart)

### Customization
Configure the error handler and logger for yourself
```dart
final talker = Talker();
talker.configure(
    /// Your own observers to handle errors's exception's and log's
    observers: [],
    settings: const TalkerSettings(
      maxHistoryItems: 100,
      useHistory: true,
      useConsoleLogs: true,
    ),
  );
```

More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/talker_interface.dart)

## Use Talker Flutter 
Often you need to check what happening in the application when there is no console at hand. There is a talker_flutter package for this situations.<br>

[Check SetUp guide on docs site](https://frezyx.github.io/talker/guide/get-started.html#instalation)



## Coverage
[![](https://codecov.io/gh/Frezyx/talker/branch/master/graphs/sunburst.svg)](https://codecov.io/gh/Frezyx/talker/branch/master)

For help getting started with 😍 Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

