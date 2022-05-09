<h1 align="center">Talker</h1>
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
<h2 align="center">How it works?</h2>
<p align="center">Here is the general scheme of the package and its main features</p>
<p align="center">
  <a href="https://www.figma.com/proto/uv7J8NiEVFSq1bLdPXb1aL/Talker?node-id=203%3A327&scaling=min-zoom&page-id=203%3A274&starting-point-node-id=203%3A275" align="center">
    <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/scheme.gif?raw=true">
  </a>
<p>

<h2 align="center">On All Platforms</h2>
<p align="center">
   <span style="font-size: 0.8em">Please add Windows and Linux screenshots😘</span>
</p>
<p align="center">
  <img src="https://github.com/Frezyx/talker/blob/master/docs/assets/all_platforms.jpg?raw=true">
</p>

## Get Started
Follow these steps to use this package

### Add dependency
```yaml
dependencies:
  talker: ^0.11.0
```

### Easy to use
You can use Talker instance everywhere in your app <br>
Simple and concise syntax will help you with this

```dart
final talker = Talker();
// Handle exceptions and errors
try {
  // your code...
} on Error catch (e, st) {
    talker.handleError(e, st, 'Error in ...');
}

// Log your app info
talker.log('App is started'),
talker.error('App is started'),
talker.waring('App is started'),
///...
```
More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/talker_interface.dart)

### Customization
Configure the error handler and logger for yourself
```dart
final talker = Talker();
// Handle exceptions and errors
talker.configure(
    /// Your own observers to handle errors's exception's and log's
    observers: [],
    settings: const TalkerSettings(
      maxHistoryItems: 1000,
      useHistory: true,
      useConsoleLogs: true,
    ),
  );
```

More examples you can get [there](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart) or in [docs](https://github.com/Frezyx/talker/blob/master/packages/talker/lib/src/talker_interface.dart)

## Use Talker Flutter 
Often you need to check what happening in the application when there is no console at hand. There is a talker_flutter package for this situations

### Add dependency
```yaml
dependencies:
  talker: ^0.11.0
  talker_flutter: ^0.10.0
```

### Easy to use
Add this code at something place of your Flutter  application where you want to display logs
```dart
final talker = Talker();
TalkerScreen(talker: talker)
```

### Result
<img src="https://github.com/Frezyx/talker/blob/master/docs/assets/talker_flutter_ios_screen.png?raw=true" width="25%">


## Coverage
[![](https://codecov.io/gh/Frezyx/talker/branch/master/graphs/sunburst.svg)](https://codecov.io/gh/Frezyx/talker/branch/master)

For help getting started with 😍 Flutter, view
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

