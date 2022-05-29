# Customization
This package was made to simplify use, but it can be customized to suit any of your needs.

## Overview
You can setup your talker with initialization in constructor
```dart
final talker = Talker(
    observers: [],
    settings: const TalkerSettings(
      useConsoleLogs: true,
    ),
  );
```
Or you can configure settings of your talker in any time when you app working by **configure()** method
```dart
final talker = Talker();
talker.configure(
    observers: [],
    settings: const TalkerSettings(
      useConsoleLogs: true,
    ),
  );
```
Now let's take a detailed look at the settings

## TalkerSettings
**TalkerSettings** have сlear name. This field is used for basic settings:
```dart
final talker = Talker(
    settings: const TalkerSettings(
      maxHistoryItems: 1000,
      useHistory: true,
      useConsoleLogs: true,
      enabled: true,
    ),
);
```

- **enabled** - The main rule that is responsible for the operation of the package.<br> All log and handle error / exception methods are working when **true** and not working when **false**

- **useConsoleLogs** - By default talker print all Errors / Exceptions and logs in console. If **true** - printing in history **false** - not printing.

- **useHistory** - By default talker write all Errors / Exceptions and logs in history list (base dart List<> field in core). If **true** - writing in history **false** - not writing.

- **maxHistoryItems** - Max records count in history list

## TalkerObserver
Any project at some point begins to need **analysis** of errors and everything that happens in the application. For such things, projects usually use [Google Analytics](https://google.com/analytics/), [Firebase Crashlytics](https://firebase.google.com/products/crashlytics), [Sentry](https://sentry.io/), [AppsFlyer](https://www.appsflyer.com/) and many others. There are even projects that make their own analytical system.<br>

In startups, these tools can change frequently. Are you want to **manually write something like this every time**?
```dart
  try {
    // your code...
  } on Exception catch (exception, stackTrace) {
    Crashlytics.instance
        .recordError(exception, stackTrace, reason: exception.message);
    Sentry.captureException(exception, stackTrace: stackTrace);
    YourOwnAnalytics.sendError(exception, stackTrace: stackTrace);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(exception.toString())));
    Logger.error('Something Service exception', exception, stackTrace);
  }
```
It looks terrible🤢<br>But how **Talker can fix this case** ?

### Crete TalkerObserver
**TalkerObserver** like everyone else observer can check all data, that processed in [Talker.stream]().<br>
Therefore, you can make an observer **that redirects the received error** to all services at once
```dart
class ExceptionsAnalyticsTalkerObserver extends TalkerObserver {
  ExceptionsAnalyticsTalkerObserver();

  @override
  Function(TalkerException e) get onException => (e) {
        Crashlytics.instance
            .recordError(e.exception, stack: e.stackTrace, reason: e.message);
        Sentry.captureException(e.exception, stackTrace: e.stackTrace);
        YourOwnAnalytics.sendError(e.exception, stackTrace: e.stackTrace);
      };
}
```

### Add created observer in Talker observers
```dart
final talker = Talker(
    observers: [
        ExceptionsAnalyticsTalkerObserver(),
    ],
);
```

### Add common Talker catch Exception logic for your methods
```dart
try {
  // your code...
} on Exception catch (e, st) {
    talker.handle(e, st, 'Something Service exception');
}
```

Now all your app exception events will come to **ExceptionsAnalyticsTalkerObserver** observer
and **will be redirected to the necessary services**<br>
Isn 't it beautiful? 😌

### Other TalkerObserver methods
```dart
class BaseTalkerObserver extends TalkerObserver {
  BaseTalkerObserver();

  @override
  Function(TalkerError err) get onError => (err) {
        /// All handled Error's
      };

  @override
  Function(TalkerException exception) get onException => (exception) {
        /// All handled Exceptions's
      };

  @override
  Function(TalkerDataInterface log)? get onLog => (log) {
        /// All logs from talker.verbose(msg), talker.error(msg) and other log methods
      };
}
```

## TalkerLogger
Talker using core package [talker_logger](https://pub.dev/packages/talker_logger) for console logging.<br>
This core package provides **TalkerLoggerInterface**.<br>
With this interface you can implement your own logger

### Create your CustomLogger
```dart
class CutsomLogger implements TalkerLoggerInterface {}
//or
class CustomLogger extends TalkerLogger {}
```

### Setup logger for Talker

```dart
final talker = Talker(
    logger: CustomLogger(),
);
```

**[Check more](../guide/talker-logger.md) about TalkerLogger**
