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
## TalkerListener
It should be used for app functionality like
showing **SnackBar** or **Dialog** about error or exception 
The **listener** be called when [Talker.stream](https://frezyx.github.io/talker/guide/talker.html#stream) recive new message
```dart
TalkerListener(
  talker: talker,
  listener: (data) => _talkerListener(context, data),
  child: Text('Your app or app screen'),
),

void _talkerListener(BuildContext context, TalkerDataInterface data) {
  if (data is TalkerException || data is TalkerError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data.displayMessage),
      ),
    );
  }
}
```