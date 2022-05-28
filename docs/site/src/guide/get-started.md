# Getting Started

## Instalation

For [Dart](https://dart.dev/) applications you need add **talker** dependency to your **pubspec.yaml**
```yaml
dependencies:
  talker: ^0.12.0
```

For [Flutter](https://flutter.dev/) applications you can add **talker_flutter** or **talker** dependency to your **pubspec.yaml**
```yaml
dependencies:
  talker_flutter: ^0.12.0
```

**What's difference ?**<br>
**talker_flutter** has advanced features that's convenient to use in the Flutter application
like [TalkerScreen](../guide/talker-flutter.html#TalkerScreen) or [TalkerRouteObserver](../guide/talker-flutter.html#TalkerRouteObserver)<br>
**talker** package working both for dart and flutter applications
 
## Easy to use
You can use Talker instance everywhere in your app<br>
Simple and concise syntax will help you with this
```dart
final talker = Talker();
// Handle exceptions and errors
try {
  // your code...
} on Exception catch (e, st) {
    talker.handle(e, st, 'Exception in ...');
}

// Make logs
talker.log('App is started'),
talker.error('App is started'),
talker.waring('App is started'),
```
More examples you can get [there](../guide/examples) or in [GitHub](https://github.com/Frezyx/talker/blob/master/packages/talker/example/talker_example.dart) 