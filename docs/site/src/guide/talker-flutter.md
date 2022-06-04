# TalkerFlutter

## Setup
First of all you need to [setup talker for Flutter app](../guide/get-started#flutter-initialization)

## TalkerScreen
Flutter UI view for output of all Talker logs and errors
```dart
final talker = Talker();
TalkerScreen(talker: talker)
```
## TalkerRouteObserver
Logging NavigatorObserver working on [Talker] base
This observer displays which routes were opened and closed in the application
```dart
MaterialApp(
      title: 'TalkerRouteObserver',
      navigatorObservers: [
        TalkerRouteObserver(talker),
      ],
);
```