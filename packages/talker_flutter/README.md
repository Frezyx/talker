<p align="center">
    <a href="https://github.com/Frezyx/talker" align="center">
        <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/logo/full_logo.png?raw=true" width="400px">
    </a>
</p>
<!-- <h1 align="center">Talker</h1> -->
<h2 align="center"> Advanced exception handling and logging for dart/flutter applications 🚀</h2>

<p align="center">
    Log your app actions, catch and handle your app exceptions and errors
   <br>
   <span style="font-size: 0.9em"> Show some ❤️ and <a href="https://github.com/Frezyx/talker">star the repo</a> to support the project! </span>
</p>

<p align="center">
  <a href="https://codecov.io/gh/Frezyx/talker"><img src="https://codecov.io/gh/Frezyx/talker/branch/master/graph/badge.svg" alt="codecov"></a>
  <a href="https://pub.dev/packages/talker"><img src="https://img.shields.io/pub/v/talker.svg" alt="Pub"></a>
  <a href="https://github.com/Frezyx/talker"><img src="https://img.shields.io/github/stars/Frezyx/talker.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
  <a href="https://github.com/Frezyx/talker/actions"><img src="https://github.com/Frezyx/talker/workflows/talker/badge.svg" alt="talker"></a>
  <a href="https://github.com/Frezyx/talker_flutter/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_flutter/badge.svg" alt="talker_flutter"></a>
  <a href="https://github.com/Frezyx/talker_logger/actions"><img src="https://github.com/Frezyx/talker/workflows/talker_logger/badge.svg" alt="talker_logger"></a>
</p>
<p align="center">
  <a href="https://pub.dev/packages/talker/score"><img src="https://badges.bar/talker/likes" alt="Pub likes"></a>
  <a href="https://pub.dev/packages/talker/score"><img src="https://badges.bar/talker/popularity" alt="Pub popularity"></a>
  <a href="https://pub.dev/packages/talker/score"><img src="https://badges.bar/talker/pub%20points" alt="Pub points"></a>
</p>

<p align="center">
    <a href="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_big.gif?raw=true" align="center">
        <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/gifs/talker_big.gif?raw=true">
    </a>
</p>

<!-- <h2 align="center">On All Platforms</h2>
<p align="center">
   <span style="font-size: 0.8em">Please add Windows and Linux screenshots😘</span>
</p>
<p align="center">
  <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/all_platforms.jpg?raw=true">
</p> -->

## Get Started
See Get Started documentation at [talker web site](https://frezyx.github.io/talker/guide/get-started.html#instalation) or
follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker: ^1.0.0
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

