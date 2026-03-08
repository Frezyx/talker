# Crashlytics & Sentry Integration

Use `TalkerObserver` to send errors, exceptions, and logs from Talker to external crash reporting and analytics services.

## How TalkerObserver Works

`TalkerObserver` listens to all Talker events and provides callbacks for each type:

```dart
abstract class TalkerObserver {
  void onError(TalkerError err) {}
  void onException(TalkerException exception) {}
  void onLog(TalkerDataInterface log) {}
}
```

- **onError** — called when `talker.handle()` catches an `Error`
- **onException** — called when `talker.handle()` catches an `Exception`
- **onLog** — called for every log event (info, debug, HTTP, custom, etc.)

## Firebase Crashlytics

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:talker/talker.dart';

class CrashlyticsTalkerObserver extends TalkerObserver {
  CrashlyticsTalkerObserver(this.crashlytics);

  final FirebaseCrashlytics crashlytics;

  @override
  void onError(TalkerError err) {
    crashlytics.recordError(
      err.error,
      err.stackTrace,
      reason: err.message,
      fatal: err.logLevel == LogLevel.critical,
    );
  }

  @override
  void onException(TalkerException exception) {
    crashlytics.recordError(
      exception.exception,
      exception.stackTrace,
      reason: exception.message,
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    // Optionally log breadcrumbs for non-error events
    crashlytics.log(log.generateTextMessage());
  }
}
```

### Setup

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final crashlytics = FirebaseCrashlytics.instance;

  final talker = TalkerFlutter.init(
    observer: CrashlyticsTalkerObserver(crashlytics),
  );

  // Now all talker.handle() calls will automatically report to Crashlytics
  try {
    throw Exception('Payment failed');
  } catch (e, st) {
    talker.handle(e, st, 'Payment processing error');
    // ^ This will log to console, save to history, AND send to Crashlytics
  }
}
```

## Sentry

```dart
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:talker/talker.dart';

class SentryTalkerObserver extends TalkerObserver {
  @override
  void onError(TalkerError err) {
    Sentry.captureException(
      err.error,
      stackTrace: err.stackTrace,
    );
  }

  @override
  void onException(TalkerException exception) {
    Sentry.captureException(
      exception.exception,
      stackTrace: exception.stackTrace,
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: log.generateTextMessage(),
        level: _mapLevel(log),
        timestamp: DateTime.now(),
      ),
    );
  }

  SentryLevel _mapLevel(TalkerDataInterface log) {
    if (log is TalkerError || log is TalkerException) {
      return SentryLevel.error;
    }
    return SentryLevel.info;
  }
}
```

### Setup

```dart
void main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
    },
    appRunner: () {
      final talker = TalkerFlutter.init(
        observer: SentryTalkerObserver(),
      );
      runApp(MyApp(talker: talker));
    },
  );
}
```

## Custom Analytics Service

The same pattern works for any analytics or monitoring service:

```dart
class AnalyticsTalkerObserver extends TalkerObserver {
  AnalyticsTalkerObserver(this.analytics);

  final MyAnalyticsService analytics;

  @override
  void onError(TalkerError err) {
    analytics.trackError(
      name: 'app_error',
      error: err.error.toString(),
      stackTrace: err.stackTrace?.toString(),
    );
  }

  @override
  void onException(TalkerException exception) {
    analytics.trackError(
      name: 'app_exception',
      error: exception.exception.toString(),
      stackTrace: exception.stackTrace?.toString(),
    );
  }

  @override
  void onLog(TalkerDataInterface log) {
    analytics.trackEvent(
      name: 'app_log',
      params: {'message': log.message, 'title': log.title},
    );
  }
}
```

## Best Practices

1. **Don't block the main thread** — crash reporting SDKs handle this internally, but be mindful with `onLog` callbacks if you add heavy processing.

2. **Use log levels wisely** — send only `error` and `critical` logs to Crashlytics, use `onLog` for breadcrumbs.

3. **Combine with TalkerWrapper** — show errors to users via SnackBars while simultaneously reporting to your crash service:

```dart
TalkerWrapper(
  talker: talker, // Same instance with CrashlyticsTalkerObserver
  options: TalkerWrapperOptions(enableErrorAlerts: true),
  child: MyApp(),
)
```

4. **Test your observer** — write unit tests to verify that the observer is called correctly for each event type.
